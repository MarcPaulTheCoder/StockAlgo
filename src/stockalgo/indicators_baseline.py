from pyspark.sql import Window, functions as F, DataFrame
from pyspark.sql.types import DoubleType
from pyspark.sql import SparkSession
from stockalgo.connections import spark_connect
from stockalgo.indicator_math import ema_math, avg_rolling_math, sar_math


def sma_sql(sparkdf: DataFrame, spark: SparkSession, num_obs: int = 5) -> DataFrame:
    sparkdf = sparkdf.drop("StartDate", "EndDate", "sma", "prior_close")
    sparkdf.createOrReplaceTempView("smatbl")
    sma = spark.sql(
        """
              SELECT *,
              LAG(close) OVER (PARTITION BY symbol ORDER BY time_stamp ASC) AS  prior_close,
              MIN(`time_stamp`)  OVER ( PARTITION BY `symbol` ORDER BY `time_stamp` ASC ROWS BETWEEN {numObservations}  PRECEDING AND CURRENT ROW) AS StartDate,
              MAX(`time_stamp`)  OVER ( PARTITION BY `symbol` ORDER BY `time_stamp` ASC ROWS BETWEEN {numObservations}  PRECEDING AND CURRENT ROW) AS EndDate,
              AVG(`close`) OVER ( PARTITION BY `symbol` ORDER BY `time_stamp` ASC ROWS BETWEEN {numObservations} PRECEDING AND CURRENT ROW) AS sma
              from smatbl;
              """.format(numObservations=num_obs - 1)
    )
    return sma


def ema_df(
    spark_df: DataFrame,
    m_periods: int,
    e_span: float | None = None,
    data_column: str = "close",
    ema_col_name: str = "ema",
    e_alpha: float | None = None,
) -> DataFrame:
    ema_schema = spark_df.schema.add(ema_col_name, DoubleType())
    ema_df = spark_df.withColumn(ema_col_name, F.lit(0.0))
    ema_adjust = True
    ema_df_output = ema_df.groupBy("symbol").applyInPandas(
        lambda pdf: ema_math(
            pdf=pdf,
            m_periods=m_periods,
            ema_adjust=ema_adjust,
            e_span=e_span,
            ema_col_name=ema_col_name,
            data_column=data_column,
            e_alpha=e_alpha,
        ),
        schema=ema_schema,
    )
    return ema_df_output


def macd_df(
    spark_df: DataFrame,
    fast_period: int = 12,
    slow_period: int = 26,
    signal_period: int = 9,
) -> DataFrame:

    fast_ema_df = ema_df(
        spark_df, fast_period, fast_period, "close", ema_col_name=f"macd{fast_period}"
    )
    slow_ema_df = ema_df(
        fast_ema_df,
        slow_period,
        slow_period,
        "close",
        ema_col_name=f"macd{slow_period}",
    )

    macd_line_df = slow_ema_df.withColumn(
        "macd_line", F.col(f"macd{fast_period}") - F.col(f"macd{slow_period}")
    )

    signal_df = ema_df(
        macd_line_df,
        signal_period,
        signal_period,
        "macd_line",
        ema_col_name="signalline",
    )
    macd = signal_df.withColumn("histogram", F.col("macd_line") - F.col("signalline"))
    return macd


def bbands_df(
    spark_df: DataFrame,
    spark: SparkSession,
    sma_period: int = 20,
    std_multiplier: float = 2,
) -> DataFrame:
    window = (
        Window.partitionBy("symbol")
        .orderBy(F.col("time_stamp").asc())
        .rowsBetween(-(sma_period - 1), 0)
    )
    sma = sma_sql(spark_df, spark, sma_period)
    bb_df = sma.withColumns(
        {
            "sma+": F.col("sma") + (F.stddev("close").over(window) * std_multiplier),
            "sma-": F.col("sma") - (F.stddev("close").over(window) * std_multiplier),
        }
    )
    return bb_df


def avgrolling_df(
    spark_df: DataFrame,
    avg_rolling_col: str,
    data_column_name: str,
    rolling_periods: int,
) -> DataFrame:
    rolling_schema = spark_df.schema.add(avg_rolling_col, DoubleType())
    rolling_df = spark_df.withColumn(avg_rolling_col, F.lit(0.0))

    rolling_df_output = rolling_df.groupBy("symbol").applyInPandas(
        lambda pdf: avg_rolling_math(
            pdf, avg_rolling_col, data_column_name, rolling_periods
        ),
        schema=rolling_schema,
    )
    return rolling_df_output


def rsi_df(
    sparkdf: DataFrame,
    pos_roll_col: str = "posrolling",
    pos_data_col: str = "pos_change",
    neg_roll_col: str = "negrolling",
    neg_data_col: str = "neg_change",
    period: int = 14,
) -> DataFrame:

    window = Window.partitionBy("symbol").orderBy(F.col("time_stamp").asc())
    change_df = sparkdf.withColumn(
        "close_change", F.col("close") - F.lag("close").over(window)
    )
    gain_losses_df = change_df.withColumns(
        {
            pos_data_col: F.when(
                F.col("close_change") > 0, F.col("close_change")
            ).otherwise(0),
            neg_data_col: F.abs(
                F.when(F.col("close_change") < 0, F.col("close_change")).otherwise(0)
            ),
        }
    )

    rolling_avgs = gain_losses_df.withColumns(
        {
            "rs": F.try_divide(F.col(pos_roll_col), F.col(neg_roll_col)),
            "rsi": 100 - (F.try_divide(F.lit(100), (F.lit(1) + F.col("rs")))),
        }
    )

    roll_df = avgrolling_df(rolling_avgs, pos_roll_col, pos_data_col, period)
    rsi = avgrolling_df(roll_df, neg_roll_col, neg_data_col, period)
    return rsi


def obv_df(sparkdf: DataFrame) -> DataFrame:

    closelagwindow = Window.partitionBy("symbol").orderBy(F.col("time_stamp").asc())
    prior_close = sparkdf.withColumn("prior_close", F.lag("close").over(closelagwindow))

    signed_vol_df = prior_close.withColumn(
        "signed_volume",
        F.when(
            (F.col("close") >= F.col("prior_close")) | (F.col("prior_close").isNull()),
            F.col("volume"),
        ).otherwise(F.col("volume") * -1),
    )

    obv = signed_vol_df.withColumn(
        "final_vsum", F.sum(F.col("signed_volume")).over(closelagwindow)
    )
    return obv


# SQL version, not wired into anything
def obv_sql(spark_df: DataFrame, spark: SparkSession) -> DataFrame:
    spark_df.createOrReplaceTempView("obvcalc")
    obv = spark.sql("""
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
    return obv


def RoC_df(spark_df: DataFrame) -> DataFrame:
    window = Window.orderBy("time_stamp").partitionBy("symbol")
    roc = spark_df.withColumns(
        {
            "prior_close": F.lag("close").over(window),
            "RoC": (
                F.try_divide(F.try_subtract("close", "prior_close"), "prior_close")
                * 100
            ),
        }
    )
    return roc


# SQL version, not wired to anything
def RoC_sql(spark_df: DataFrame, spark: SparkSession) -> DataFrame:
    spark_df.createOrReplaceTempView("RoCtbl")
    roc = spark.sql(
        "SELECT time_stamp, close,  LAG(close) OVER (PARTITION BY symbol ORDER BY time_stamp ASC) AS prior_close, \
    (((close - prior_close)/prior_close)*100)  AS RoC  FROM RoCtbl"
    )
    return roc


# ATR
# first need true value --> todays high, todays low, yesterdays close
# do all three for every day if you don't have previous ATR --> todays high - todays low, todays high - yesterdays close, and todays low - ysterdays close
# take the largest number of the three calculations above
# find the highest sum at the column level of the three calculations
# multiple that sum by 1/number of periods --> highest sum * (1/number of periods) --> gives you average volatility --> atr of previous period


# do todays high - todays low, todays low - yesterday close, todays high - yesterdays close --> looking for biggest num
# (atr of previous period * (number of periods - 1) + biggest sum of the step above ) / number of periods
def atr_df(spark_df: DataFrame) -> DataFrame:
    window = Window.partitionBy("symbol").orderBy(F.col("time_stamp").asc())
    true_range_df = spark_df.withColumns(
        {
            "prior_close": F.lag(F.col("close")).over(window),
            "high_low": F.col("high") - F.col("low"),
            "high_prev_close": F.col("high") - F.col("prior_close"),
            "low_prev_close": F.col("low") - F.col("prior_close"),
        }
    )
    true_range_df = true_range_df.withColumn(
        "true_range",
        F.greatest(
            F.abs(F.col("high_low")),
            F.abs(F.col("high_prev_close")),
            F.abs(F.col("low_prev_close")),
        ),
    )

    atr = avgrolling_df(
        spark_df=true_range_df,
        avg_rolling_col="atr",
        data_column_name="true_range",
        rolling_periods=14,
    )
    return atr


# chaikin AD
# money flow multiplier = (  (close - low) - (high - close) ) / (high - Low)
# Money flow volume = Money flow multiplier * (volume * period)
# ADL = Money flow volume * (Period - 1) + Money flow volume (Period)
# CO = 3 day ema of ADL - 10 day ema of ADL
def ad_df(spark_df: DataFrame) -> DataFrame:
    window = Window.partitionBy("symbol").orderBy(F.col("time_stamp").asc())

    money_flow_df = spark_df.withColumns(
        {
            "money_flow_mult": F.try_divide(
                ((F.col("close") - F.col("low")) - (F.col("high") - F.col("close"))),
                (F.col("high") - F.col("low")),
            ),
            "money_flow_volume": F.col("money_flow_mult") * F.col("volume"),
        }
    )

    adl_df = money_flow_df.withColumn(
        "adl", F.sum(F.col("money_flow_volume")).over(window)
    )

    adl_3ema_df = ema_df(adl_df, 3, 3, "adl", "3dayema")

    adl_10ema_df = ema_df(adl_3ema_df, 10, 10, "adl", "10dayema")

    ad = adl_10ema_df.withColumn("co", F.col("3dayema") - F.col("10dayema"))

    return ad


# ADX
def adx_df(spark_df: DataFrame, period: int, e_alpha: float | None = None) -> DataFrame:
    # 1. DM
    # dm+ = high - prevhigh
    # dm- = prevlow - low
    # use greater --> smaller = 0

    if e_alpha is None and period > 0:
        e_alpha = 1 / period

    window = Window.partitionBy("symbol").orderBy(F.col("time_stamp").asc())
    lag_df = spark_df.withColumns(
        {
            "laglow": F.lag("low").over(window),
            "laghigh": F.lag("high").over(window),
            "prior_close": F.lag("close").over(window),
        }
    )

    dm_df = lag_df.withColumns(
        {
            "dm+": F.when(
                (F.col("high") - F.col("laghigh") > F.col("laglow") - F.col("low"))
                & (F.col("high") - F.col("laghigh") > 0),
                F.col("high") - F.col("laghigh"),
            ).otherwise(0),
            "dm-": F.when(
                (F.col("laglow") - F.col("low") > F.col("high") - F.col("laghigh"))
                & (F.col("laglow") - F.col("low") > 0),
                F.col("laglow") - F.col("low"),
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
        e_alpha=e_alpha,
    )
    di_smooth = ema_df(
        di_plus_df, period, data_column="dm-", ema_col_name="smoothdm-", e_alpha=e_alpha
    )

    # 4. DX
    # DX = (abs(+DI(Period) - -DI(Period)) )  /  (abs(+DI(Period) + -DI(Period)))

    dx_df = di_smooth.withColumn(
        "dx",
        (
            F.try_divide(
                (F.abs((F.col("smoothdm+") - F.col("smoothdm-")))),
                (F.abs((F.col("smoothdm+") + F.col("smoothdm-")))),
            )
        )
        * 100,
    )

    # 5. ADX
    # first ADX = average of first Period DX values
    # ADX = ((PrevADX * (Period - 1)) + DX) / Period
    adx_df_output = ema_df(
        spark_df=dx_df,
        m_periods=period,
        data_column="dx",
        ema_col_name="adx",
        e_alpha=e_alpha,
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


def sar_df(spark_df: DataFrame, applyInPandas_flag: bool = True) -> DataFrame:

    window = Window.partitionBy("symbol").orderBy(F.col("time_stamp").asc())
    seed_window = window.rowsBetween(-4, 0)

    sar_schema = (
        spark_df.schema.add("af", DoubleType())
        .add("seed_low", DoubleType())
        .add("seed_high", DoubleType())
        .add("ep", DoubleType())
        .add("sar", DoubleType())
        .add("td", DoubleType())
        .add("row_num", DoubleType())
        .add("prev_td", DoubleType())
    )

    sar_df = spark_df.withColumns(
        {
            "af": F.lit(0.02),
            "sar": F.lit(0.0),
            "td": F.lit(0),
            "seed_low": F.lit(0.0),
            "seed_high": F.lit(0.0),
        }
    )

    sar_df = sar_df.withColumn("row_num", F.row_number().over(window))
    sar_df = sar_df.withColumns(
        {
            "seed_low": F.when(
                F.col("row_num") <= 5, F.min(F.col("low")).over(seed_window)
            ),
            "seed_high": F.when(
                F.col("row_num") <= 5, F.max(F.col("high")).over(seed_window)
            ),
        }
    )
    sar_df = sar_df.withColumn(
        "td",
        F.when(
            F.col("row_num") <= 5,
            F.sign(F.col("close") - ((F.col("seed_low") + F.col("seed_high")) / 2)),
        ),
    )
    sar_df = sar_df.withColumn(
        "prev_td", F.when(F.col("row_num") <= 5, F.lag(F.col("td")).over(window))
    )
    sar_df = sar_df.withColumn(
        "td",
        F.when(
            (F.col("row_num") <= 5) & (F.col("td") == 0), F.col("prev_td")
        ).otherwise(F.col("td")),
    )
    sar_df = sar_df.withColumns(
        {
            "sar": F.when(
                (F.col("row_num") <= 5) & (F.col("td") == 1), F.col("seed_low")
            ).when((F.col("row_num") <= 5) & (F.col("td") == -1), F.col("seed_high")),
            "ep": F.when(
                (F.col("row_num") <= 5) & (F.col("td") == 1), F.col("seed_high")
            ).when((F.col("row_num") <= 5) & (F.col("td") == -1), F.col("seed_low")),
        }
    )
    if applyInPandas_flag:
        sar_df_output = sar_df.groupBy("symbol").applyInPandas(
            sar_math, schema=sar_schema
        )
    else:
        sar_df_output = sar_df
    return sar_df_output


def call_indicators(
    spark: SparkSession | None = None,
    spark_df: DataFrame | None = None,
    sma_period: int = 20,
    ema_period: int = 20,
    emaspan: int = 20,
    macd_fast: int = 12,
    macd_slow: int = 26,
    macd_signal: int = 9,
    bbandsma_period: int = 20,
    bbands_std: int = 2,
    adx_period: int = 14,
    rsi_period: int = 14,
) -> None:
    if spark is None:
        spark = spark_connect("stockalgo-compute-indicator-baseline")
    if spark_df is None:
        raw_bars_tbl = spark.table("stockalgo.market.raw_bars")
        comp_info_tbl = spark.table("stockalgo.market.company_info")
        spark_df = (
            raw_bars_tbl.join(
                comp_info_tbl,
                on=(raw_bars_tbl["symbol"] == comp_info_tbl["symbol"])
                & (comp_info_tbl["active"]),
                how="left_semi",
            )
            .where(F.col("is_valid"))
            .orderBy(F.col("symbol").desc(), F.col("time_stamp").asc())
        )

    indicatordf = (
        spark_df.transform(obv_df)
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
        "signed_volume",
        "macd12",
        "macd26",
        "prior_close",
        "StartDate",
        "EndDate",
        "close_change",
        "pos_change",
        "neg_change",
        "posrolling",
        "negrolling",
        "money_flow_mult",
        "money_flow_volume",
        "laglow",
        "laghigh",
        "high_low",
        "high_prev_close",
        "low_prev_close",
        "true_range",
        "seed_low",
        "seed_high",
        "row_num",
        "prev_td",
    )
    indicatordf = indicatordf.withColumn("middle_bollinger_band", F.col("sma"))
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
