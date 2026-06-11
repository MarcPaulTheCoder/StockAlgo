from pyspark.sql import Window, functions as func
from pyspark.sql.types import DoubleType
from pyspark.sql.functions import col, lit
from stockalgo.connections import spark_connect
from stockalgo.ingest import get_symbols
from stockalgo.indicator_math import ema_math, avg_rolling_math, sar_math


def sma_sql(sparkdf, spark, numObs=5):
    sparkdf = sparkdf.drop(
        col("StartDate"), col("EndDate"), col("sma"), col("LagClose")
    )
    sparkdf.createOrReplaceTempView("smatbl")
    smadf = spark.sql(
        """
              SELECT *,
              LAG(close) OVER (PARTITION BY symbol ORDER BY time_stamp ASC) AS  LagClose,
              MIN(`time_stamp`)  OVER ( PARTITION BY `symbol` ORDER BY `time_stamp` ASC ROWS BETWEEN {numObservations}  PRECEDING AND CURRENT ROW) AS StartDate,
              MAX(`time_stamp`)  OVER ( PARTITION BY `symbol` ORDER BY `time_stamp` ASC ROWS BETWEEN {numObservations}  PRECEDING AND CURRENT ROW) AS EndDate,
              AVG(`close`) OVER ( PARTITION BY `symbol` ORDER BY `time_stamp` ASC ROWS BETWEEN {numObservations} PRECEDING AND CURRENT ROW) AS sma
              from smatbl;
              """.format(numObservations=numObs - 1)
    )
    return smadf


def ema_df(
    spark_df, m_periods, e_span=0, data_column="close", ema_col_name="ema", e_alpha=0.0
):
    ema_schema = spark_df.schema.add(ema_col_name, DoubleType())
    ema_df = spark_df.withColumn(ema_col_name, func.lit(0.0))
    ema_adjust = True
    ema_df_output = ema_df.groupBy("symbol").applyInPandas(
        lambda pdf: ema_math(
            pdf, m_periods, ema_adjust, e_span, ema_col_name, data_column, e_alpha
        ),
        schema=ema_schema,
    )
    return ema_df_output


def macd_df(spark_df, fast_period=12, slow_period=26, signal_period=9):

    macdfast = ema_df(
        spark_df, fast_period, fast_period, "close", ema_col_name=f"macd{fast_period}"
    )
    macdslow = ema_df(
        macdfast, slow_period, slow_period, "close", ema_col_name=f"macd{slow_period}"
    )

    macdline = macdslow.withColumn(
        "macd_line", col(f"macd{fast_period}") - col(f"macd{slow_period}")
    )

    signalline = ema_df(
        macdline,
        signal_period,
        signal_period,
        "macd_line",
        ema_col_name="signalline",
    )
    macd_df_output = signalline.withColumn(
        "histogram", col("macd_line") - col("signalline")
    )
    return macd_df_output


def bbands_df(sparkdf, spark, smaperiod=20, stdmultiplier=2):
    window = (
        Window.partitionBy("symbol")
        .orderBy(col("time_stamp").asc())
        .rowsBetween(-(smaperiod - 1), 0)
    )
    smadf = sma_sql(sparkdf, spark, smaperiod)
    bbdf = smadf.withColumns(
        {
            "sma+": col("sma") + (func.stddev("close").over(window) * stdmultiplier),
            "sma-": col("sma") - (func.stddev("close").over(window) * stdmultiplier),
        }
    )
    return bbdf


def avgrolling_df(spark_df, avg_rolling_col, data_column_name, rolling_periods):
    rolling_schema = spark_df.schema.add(avg_rolling_col, DoubleType())
    rolling_df = spark_df.withColumn(avg_rolling_col, func.lit(0.0))

    rolling_df_output = rolling_df.groupBy("symbol").applyInPandas(
        lambda pdf: avg_rolling_math(
            pdf, avg_rolling_col, data_column_name, rolling_periods
        ),
        schema=rolling_schema,
    )
    return rolling_df_output


def rsi_df(
    sparkdf,
    pos_roll_col="posrolling",
    pos_data_col="pos_change",
    neg_roll_col="negrolling",
    neg_data_col="neg_change",
    period=14,
):

    window = Window.partitionBy("symbol").orderBy(col("time_stamp").asc())
    sparksdf = sparkdf.withColumn(
        "closechange", col("close") - func.lag("close").over(window)
    )
    sparknp = sparksdf.withColumns(
        {
            pos_data_col: func.when(
                col("closechange") > 0, col("closechange")
            ).otherwise(0),
            neg_data_col: func.abs(
                func.when(col("closechange") < 0, col("closechange")).otherwise(0)
            ),
        }
    )

    roll_df = avgrolling_df(sparknp, pos_roll_col, pos_data_col, period)
    rollingavgs = avgrolling_df(roll_df, neg_roll_col, neg_data_col, period)

    rsidf = rollingavgs.withColumns(
        {
            "rs": func.try_divide(col(pos_roll_col), col(neg_roll_col)),
            "rsi": 100 - (func.try_divide(lit(100), (lit(1) + col("rs")))),
        }
    )
    return rsidf


def obv_df(sparkdf):

    closelagwindow = Window.partitionBy("symbol").orderBy(col("time_stamp").asc())
    sspf = sparkdf.withColumn("yesterdayclose", func.lag("close").over(closelagwindow))

    spf = sspf.withColumn(
        "vsum",
        func.when(
            (col("close") >= col("yesterdayclose")) | (col("yesterdayclose").isNull()),
            col("volume"),
        ).otherwise(col("volume") * -1),
    )

    obvdf = spf.withColumn("final_vsum", func.sum(col("vsum")).over(closelagwindow))
    return obvdf


def obv_sql(sparkdf, spark):
    sparkdf.createOrReplaceTempView("obvcalc")
    obvdf = spark.sql("""
    WITH getlaggingclose AS (
        SELECT time_stamp, volume,close, symbol, LAG(close) OVER (PARTITION BY symbol ORDER BY time_stamp ASC) AS yesterdayclose, 
        CASE
            WHEN `close` > yesterdayclose THEN `volume`
            WHEN `close` < yesterdayclose THEN  (`volume` * -1)
            WHEN close = yesterdayclose THEN volume
            ELSE volume
            END AS ttobv 
          FROM obvcalc
          ),
        obvfinal AS (
            SELECT time_stamp, volume, close, symbol, SUM(ttobv) OVER (PARTITION BY symbol ORDER BY time_stamp ASC) AS lazyobv 
            FROM getlaggingclose ) 
        SELECT * FROM obvfinal;
    """)
    return obvdf


def RoC_df(sparkdf):
    window = Window.orderBy("time_stamp").partitionBy("symbol")
    rocdf = sparkdf.withColumns(
        {
            "Lagyesterday": func.lag("close").over(window),
            "RoC": (
                func.try_divide(
                    func.try_subtract("close", "Lagyesterday"), "Lagyesterday"
                )
                * 100
            ),
        }
    )
    return rocdf


def RoC_sql(sparkdf, spark):
    sparkdf.createOrReplaceTempView("RoCtbl")
    rocdf = spark.sql(
        "SELECT time_stamp, close,  LAG(close) OVER (PARTITION BY symbol ORDER BY time_stamp ASC) AS Lagyesterday, \
    (((close - Lagyesterday)/Lagyesterday)*100)  AS RoC  FROM RoCtbl"
    )
    return rocdf


# ATR
# first need true value --> todays high, todays low, yesterdays close
# do all three for every day if you don't have previous ATR --> todays high - todays low, todays high - yesterdays close, and todays low - ysterdays close
# take the largest number of the three calculations above
# find the highest sum at the column level of the three calculations
# multiple that sum by 1/number of periods --> highest sum * (1/number of periods) --> gives you average volatility --> atr of previous period


# do todays high - todays low, todays low - yesterday close, todays high - yesterdays close --> looking for biggest num
# (atr of previous period * (number of periods - 1) + biggest sum of the step above ) / number of periods
def atr_df(sparkdf):
    window = Window.partitionBy("symbol").orderBy(col("time_stamp").asc())
    trdf = sparkdf.withColumns(
        {
            "Lagclose": func.lag(col("close")).over(window),
            "hl": col("high") - col("low"),
            "hyc": col("high") - col("Lagclose"),
            "lyc": col("low") - col("Lagclose"),
        }
    )
    tr_df = trdf.withColumn(
        "largestcoltoday",
        func.greatest(
            func.abs(col("hl")),
            func.abs(col("hyc")),
            func.abs(col("lyc")),
        ),
    )

    atr = avgrolling_df(
        spark_df=tr_df,
        avg_rolling_col="atr",
        data_column_name="largestcoltoday",
        rolling_periods=14,
    )
    return atr


# chaikin AD
# money flow multiplier = (  (close - low) - (high - close) ) / (high - Low)
# Money flow volume = Money flow multiplier * (volume * period)
# ADL = Money flow volume * (Period - 1) + Money flow volume (Period)
# CO = 3 day ema of ADL - 10 day ema of ADL
def ad_df(sparkdf):
    window = Window.partitionBy("symbol").orderBy(col("time_stamp").asc())

    t = sparkdf.withColumns(
        {
            "mfm": func.try_divide(
                ((col("close") - col("low")) - (col("high") - col("close"))),
                (col("high") - col("low")),
            ),
            "mfv": col("mfm") * col("volume"),
        }
    )

    ad_df = t.withColumn("adl", func.sum(col("mfv")).over(window))

    ad_ema_df = ema_df(ad_df, 3, 3, "adl", "3dayema")

    ad_dfs = ema_df(ad_ema_df, 10, 10, "adl", "10dayema")

    ad_df_output = ad_dfs.withColumn("co", col("3dayema") - col("10dayema"))

    return ad_df_output


# ADX
def adx_df(sparkdf, period):
    # 1. DM
    # dm+ = high - prevhigh
    # dm- = prevlow - low
    # use greater --> smaller = 0

    window = Window.partitionBy("symbol").orderBy(col("time_stamp").asc())
    lag_df = sparkdf.withColumns(
        {
            "laglow": func.lag("low").over(window),
            "laghigh": func.lag("high").over(window),
            "lagclose": func.lag("close").over(window),
        }
    )

    dm_df = lag_df.withColumns(
        {
            "dm+": func.when(
                (col("high") - col("laghigh") > col("laglow") - col("low"))
                & (col("high") - col("laghigh") > 0),
                col("high") - col("laghigh"),
            ).otherwise(0),
            "dm-": func.when(
                (col("laglow") - col("low") > col("high") - col("laghigh"))
                & (col("laglow") - col("low") > 0),
                col("laglow") - col("low"),
            ).otherwise(0),
        }
    )

    # 2. TR
    # high - low
    # high - prevclose
    # low - prevclose

    atr_df_output = atr_df(dm_df)

    # 3. Smoothed Directional Movement Indicators
    # Represents % strength of movement
    # +DI = ((Smoothed +DM(Period)) / ATR(Period)) * 100
    # -DI = ((Smoothed -DM(Period)) / ATR(Period)) * 100

    di_plus_df = ema_df(
        atr_df_output,
        period,
        data_column="dm+",
        ema_col_name="smoothdm+",
        e_alpha=1 / 14,
    )
    di_smooth = ema_df(
        di_plus_df, period, data_column="dm-", ema_col_name="smoothdm-", e_alpha=1 / 14
    )

    # 4. DX
    # DX = (abs(+DI(Period) - -DI(Period)) )  /  (abs(+DI(Period) + -DI(Period)))

    dx_df = di_smooth.withColumn(
        "dx",
        (
            func.try_divide(
                (func.abs((col("smoothdm+") - col("smoothdm-")))),
                (func.abs((col("smoothdm+") + col("smoothdm-")))),
            )
        )
        * 100,
    )

    # 5. ADX
    # first ADX = average of first Period DX values
    # ADX = ((PrevADX * (Period - 1)) + DX) / Period
    adx_df_output = ema_df(
        dx_df, period, period, "dx", ema_col_name="adx", e_alpha=1 / 14
    )
    return adx_df_output


# Parabolic SAR
# 2 main pieces: Trend Direction (TD), Acceleration Factor (AF), Extreme Point (EP)
# SAR = Previous Periods SAR + Acceleration Factor * (Extreme Point (Local Max/Min) - Previous Periods SAR)
# Acceleration Factor = 0.02 --> usually
# First SAR = local Min/Max dependent on trend direction
# look back Period --> Used to determine First SAR and Extreme Points Value --> 5 rows (not strict) -->
#   checks close slope --> if close slope + --> uptrend SAR = MIN(low Loop Back Period), EP = MAX(high Loop Back Period) -->
#   if close slope - --> SAR = MAX(high Loop Back Period), EP = MIN(low Loop Back Period)


def sar_df(sparkdf):

    window = Window.partitionBy("symbol").orderBy(col("time_stamp").asc())
    firstsarwindow = window.rowsBetween(-4, 5)

    sar_schema = (
        sparkdf.schema.add("af", DoubleType())
        .add("lmin", DoubleType())
        .add("lmax", DoubleType())
        .add("ep", DoubleType())
        .add("sar", DoubleType())
        .add("td", DoubleType())
        .add("rnum", DoubleType())
        .add("prevtd", DoubleType())
    )

    sarvarsdf = sparkdf.withColumns(
        {
            "af": func.lit(0.02),
            "sar": func.lit(0.0),
            "td": func.lit(0),
            "lmin": func.lit(0.0),
            "lmax": func.lit(0.0),
        }
    )

    sarvarsdf = sarvarsdf.withColumn("rnum", func.row_number().over(window))
    sarvarsdf = sarvarsdf.withColumns(
        {
            "lmin": func.when(
                col("rnum") <= 5, func.min(col("close")).over(firstsarwindow)
            ),
            "lmax": func.when(
                col("rnum") <= 5, func.max(col("close")).over(firstsarwindow)
            ),
        }
    )
    sarvarsdf = sarvarsdf.withColumn(
        "td",
        func.when(
            col("rnum") <= 5,
            func.sign((col("close") - ((col("lmin") + col("lmax")) / 2)) / 5),
        ),
    )
    sarvarsdf = sarvarsdf.withColumn(
        "prevtd", func.when(col("rnum") <= 5, func.lag(col("td")).over(window))
    )
    sarvarsdf = sarvarsdf.withColumn(
        "td",
        func.when((col("rnum") <= 5) & (col("td") == 0), col("prevtd")).otherwise(
            col("td")
        ),
    )
    sarvarsdf = sarvarsdf.withColumns(
        {
            "sar": func.when((col("rnum") <= 5) & (col("td") == 1), col("lmin")).when(
                (col("rnum") <= 5) & (col("td") == -1), col("lmax")
            ),
            "ep": func.when((col("rnum") <= 5) & (col("td") == 1), col("lmax")).when(
                (col("rnum") <= 5) & (col("td") == -1), col("lmin")
            ),
        }
    )

    sar_df_output = sarvarsdf.groupBy("symbol").applyInPandas(
        sar_math, schema=sar_schema
    )
    return sar_df_output


def call_indicators(
    spark=None,
    sparkdf=None,
    sma_period=20,
    ema_period=20,
    emaspan=20,
    macd_fast=12,
    macd_slow=26,
    macd_signal=9,
    bbandsma_period=20,
    bbands_std=2,
    adx_period=14,
    rsi_period=14,
):
    if spark is None:
        spark = spark_connect()

    if sparkdf is None:
        symbols = get_symbols(spark)
        sparkdf = (
            spark.table("stockalgo.market.raw_bars")
            .where((col("is_valid")) & (col("symbol").isin(symbols)))
            .orderBy(col("symbol").desc(), col("time_stamp").asc())
        )

    indicatordf = (
        sparkdf.transform(obv_df)
        .transform(lambda d: sma_sql(d, spark, sma_period))
        .transform(lambda d: ema_df(d, ema_period, emaspan))
        .transform(lambda d: macd_df(d, macd_fast, macd_slow, macd_signal))
        .transform(lambda d: bbands_df(d, spark, bbandsma_period, bbands_std))
        .transform(lambda d: rsi_df(d, period=rsi_period))
        .transform(RoC_df)
        .transform(ad_df)
        .transform(lambda d: adx_df(d, adx_period))
        .transform(sar_df)
    )

    indicatordf = indicatordf.drop(
        "is_valid",
        "yesterdayclose",
        "vsum",
        "macd12",
        "macd26",
        "Lagclose",
        "StartDate",
        "EndDate",
        "closechange",
        "pos_change",
        "neg_change",
        "posrolling",
        "negrolling",
        "Lagyesterday",
        "mfm",
        "mfv",
        "laglow",
        "laghigh",
        "hl",
        "hyc",
        "lyc",
        "largestcoltoday",
        "lmin",
        "lmax",
        "rnum",
        "prevtd",
    )
    indicatordf = indicatordf.withColumn("middle_bollinger_band", col("sma"))
    indicatordf = indicatordf.withColumnsRenamed(
        {
            "final_vsum": "obv",
            "signalline": "macd_signal",
            "histogram": "macd_histogram",
            "RoC": "roc",
            "sma+": "upper_bollinger_band",
            "sma-": "lower_bollinger_band",
            "dm+": "dm_plus",
            "dm-": "dm_minus",
            "smoothdm+": "smooth_dm_plus",
            "smoothdm-": "smooth_dm_minus",
            "3dayema": "three_day_ema",
            "10dayema": "ten_day_ema",
            "co": "chaikin_ad",
        }
    )
    indicatordf.createOrReplaceTempView("new_indicator_data")
    spark.sql(""" MERGE INTO stockalgo.market.stock_indicator_data AS sia
    USING new_indicator_data AS nid ON sia.symbol = nid.symbol AND sia.time_stamp = nid.time_stamp
    WHEN MATCHED THEN UPDATE SET *
    WHEN NOT MATCHED THEN INSERT *
              """)
