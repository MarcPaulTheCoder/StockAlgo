import os
from datetime import datetime
from pyspark.sql import SparkSession, Window, functions as func
from alpaca.data.historical import StockHistoricalDataClient
from alpaca.data.requests import StockBarsRequest
from alpaca.data.timeframe import TimeFrame
from pyspark.sql.types import DoubleType
from pyspark.sql.functions import col


def spark_connect():
    spark = (
        SparkSession.builder.appName("alpaca-ingest")
        .config("spark.sql.artifact.rootDirectory", "/tmp/spark-artifacts")
        .config("spark.sql.scripting.enabled", "true")
        .getOrCreate()
    )
    return spark


def alpaca_historical_data_connect():
    client = StockHistoricalDataClient(
        os.getenv(key="ALPACA_KEY"), os.getenv(key="ALPACA_SECRET")
    )
    return client


def getstockbardata(client, spark, symbols, datefrom=None, dateto=datetime.today()):

    if datefrom is None:
        apicall = StockBarsRequest(
            symbol_or_symbols=symbols, timeframe=TimeFrame.Day, end=dateto
        )
    else:
        apicall = StockBarsRequest(
            symbol_or_symbols=symbols,
            timeframe=TimeFrame.Day,
            start=datefrom,
            end=dateto,
        )

    temp = client.get_stock_bars(apicall).df.reset_index()
    sparkdf = spark.createDataFrame(temp)
    return sparkdf


def sma_sql(sparkdf, spark, numObs):
    numObs = 5
    sparkdf.createOrReplaceTempView("smatbl")
    smadf = spark.sql(
        """
              SELECT symbol, timestamp, open, high, low, close, volume, trade_count, vwap,
              LAG(close) OVER (PARTITION BY symbol ORDER BY timestamp ASC) AS  LagClose,
              MIN(`timestamp`)  OVER ( PARTITION BY `symbol` ORDER BY `timestamp` ASC ROWS BETWEEN {numObservations}  PRECEDING AND CURRENT ROW) AS StartDate,
              MAX(`timestamp`)  OVER ( PARTITION BY `symbol` ORDER BY `timestamp` ASC ROWS BETWEEN {numObservations}  PRECEDING AND CURRENT ROW) AS EndDate,
              AVG(`close`) OVER ( PARTITION BY `symbol` ORDER BY `timestamp` ASC ROWS BETWEEN {numObservations} PRECEDING AND CURRENT ROW) AS sma
              from smatbl;
              """.format(numObservations=numObs - 1)
    )
    return smadf


def ema_df(
    sparkdf, mperiods, espan=0, data_column="close", emacolname="ema", ealpha=0.0
):

    ema_schema = sparkdf.schema.add(emacolname, DoubleType())
    emadff = sparkdf.withColumn(emacolname, func.lit(0.0))
    ema_adjust = True

    def inner_ema_df(pdf):
        nonlocal mperiods, ema_adjust, espan, data_column, ealpha
        pdf = pdf.sort_values("timestamp")
        if ealpha == 0:
            ema = (
                pdf[data_column]
                .ewm(span=espan, min_periods=mperiods, adjust=ema_adjust)
                .mean()
            )
        else:
            ema = (
                pdf[data_column]
                .ewm(alpha=ealpha, min_periods=mperiods, adjust=ema_adjust)
                .mean()
            )
        return pdf.assign(**{emacolname: ema})

    return emadff.groupBy("symbol").applyInPandas(inner_ema_df, schema=ema_schema)


def macd_df(sparkdf, fastperiod=12, slowperiod=26, signalperiod=9):

    macdfast = ema_df(
        sparkdf, fastperiod, fastperiod, "close", emacolname=f"macd{fastperiod}"
    )
    macdslow = ema_df(
        macdfast, slowperiod, slowperiod, "close", emacolname=f"macd{slowperiod}"
    )

    macdline = macdslow.withColumn(
        "macd_line", col(f"macd{fastperiod}") - col(f"macd{slowperiod}")
    )

    signalline = ema_df(
        macdline, signalperiod, signalperiod, "macd_line", emacolname="signalline"
    )
    fmacd = signalline.withColumn("histogram", col("macd_line") - col("signalline"))
    return fmacd


def bbands_df(sparkdf, spark, smaperiod=20, stdmultiplier=2):
    window = Window.partitionBy("symbol").orderBy(col("timestamp").asc())
    smadf = sma_sql(sparkdf, spark, smaperiod)
    bbdf = smadf.withColumns(
        {
            "sma+": col("sma") + (func.stddev("sma").over(window) * stdmultiplier),
            "sma-": col("sma")
            - (func.stddev("sma").over(window) * (-1 * stdmultiplier)),
        }
    )
    return bbdf


def avgrolling_df(sparkdf, avgrolling_col, data_column_name, rolling_periods):
    rolling_schema = sparkdf.schema.add(avgrolling_col, DoubleType())
    rolling_df = sparkdf.withColumn(avgrolling_col, func.lit(0.0))

    def inner_avgrolling_df(pdf):
        nonlocal avgrolling_col, data_column_name, rolling_periods

        pdf.sort_values("timestamp")
        avgrolling = pdf[data_column_name].rolling(rolling_periods).mean()
        return pdf.assign(**{avgrolling_col: avgrolling})

    return rolling_df.groupBy("symbol").applyInPandas(
        inner_avgrolling_df, rolling_schema
    )


def rsi_df(
    sparkdf,
    pos_roll_col="posrolling",
    pos_data_col="pos_change",
    neg_roll_col="negrolling",
    neg_data_col="neg_change",
    period=14,
):

    window = Window.partitionBy("symbol").orderBy(col("timestamp").asc())
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
            "rs": (col(pos_roll_col) / col(neg_roll_col)),
            "rsi": 100 - (100 / (1 + col("rs"))),
        }
    )
    return rsidf


def obv_df(sparkdf):

    closelagwindow = Window.partitionBy("symbol").orderBy(col("timestamp").asc())
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
        SELECT timestamp, volume,close, symbol, LAG(close) OVER (PARTITION BY symbol ORDER BY timestamp ASC) AS yesterdayclose, 
        CASE
            WHEN `close` > yesterdayclose THEN `volume`
            WHEN `close` < yesterdayclose THEN  (`volume` * -1)
            WHEN close = yesterdayclose THEN volume
            ELSE volume
            END AS ttobv 
          FROM obvcalc
          ),
        obvfinal AS (
            SELECT timestamp, volume, close, symbol, SUM(ttobv) OVER (PARTITION BY symbol ORDER BY timestamp ASC) AS lazyobv 
            FROM getlaggingclose ) 
        SELECT * FROM obvfinal;
    """)
    return obvdf


def RoC_df(sparkdf):
    window = Window.orderBy("timestamp").partitionBy("symbol")
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
        "SELECT timestamp, close,  LAG(close) OVER (PARTITION BY symbol ORDER BY timestamp ASC) AS Lagyesterday, \
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
    window = Window.partitionBy("symbol").orderBy(col("timestamp").asc())
    trdf = sparkdf.withColumns(
        {
            "Lagclose": func.lag(col("close")).over(window),
            "hl": col("high") - col("low"),
            "hyc": col("high") - col("Lagclose"),
            "lyc": col("low") - col("Lagclose"),
        }
    )
    ttt = trdf.withColumn(
        "largestcoltoday",
        func.greatest(
            func.abs(col("hl")),
            func.abs(col("hyc")),
            func.abs(col("lyc")),
        ),
    )

    atr = avgrolling_df(ttt, "atr", "largestcoltoday", 14)
    return atr


# chaikin AD
# money flow multiplier = (  (close - low) - (high - close) ) / (high - Low)
# Money flow volume = Money flow multiplier * (volume * period)
# ADL = Money flow volume * (Period - 1) + Money flow volume (Period)
# CO = 3 day ema of ADL - 10 day ema of ADL
def ad_df(sparkdf):
    window = Window.partitionBy("symbol").orderBy(col("timestamp").asc())

    t = sparkdf.withColumns(
        {
            "mfm": ((col("close") - col("low")) - (col("high") - col("close")))
            / (col("high") - col("low")),
            "mfv": col("mfm") * col("volume"),
        }
    )

    tt = t.withColumn("adl", func.sum(col("mfv")).over(window))

    treedayemadf = ema_df(tt, 3, 3, "adl", "3dayema")

    addfs = ema_df(treedayemadf, 10, 10, "adl", "10dayema")

    addf = addfs.withColumn("co", col("3dayema") - col("10dayema"))

    return addf


# ADX
def adx_df(sparkdf, period):
    # 1. DM
    # dm+ = high - prevhigh
    # dm- = prevlow - low
    # use greater --> smaller = 0

    window = Window.partitionBy("symbol").orderBy(col("timestamp").asc())
    lagdf = sparkdf.withColumns(
        {
            "laglow": func.lag("low").over(window),
            "laghigh": func.lag("high").over(window),
            "lagclose": func.lag("close").over(window),
        }
    )

    dmdf = lagdf.withColumns(
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

    atrdf = atr_df(dmdf)

    # 3. Smoothed Directional Movement Indicators
    # Represents % strength of movement
    # +DI = ((Smoothed +DM(Period)) / ATR(Period)) * 100
    # -DI = ((Smoothed -DM(Period)) / ATR(Period)) * 100

    diplus = ema_df(
        atrdf, period, data_column="dm+", emacolname="smoothdm+", ealpha=1 / 14
    )
    dismooth = ema_df(
        diplus, period, data_column="dm-", emacolname="smoothdm-", ealpha=1 / 14
    )

    # 4. DX
    # DX = (abs(+DI(Period) - -DI(Period)) )  /  (abs(+DI(Period) + -DI(Period)))

    dxdf = dismooth.withColumn(
        "dx",
        (
            (func.abs((col("smoothdm+") - col("smoothdm-"))))
            / (func.abs((col("smoothdm+") + col("smoothdm-"))))
        )
        * 100,
    )

    # 5. ADX
    # first ADX = average of first Period DX values
    # ADX = ((PrevADX * (Period - 1)) + DX) / Period
    adxdf = ema_df(dxdf, period, period, "dx", emacolname="adx", ealpha=1 / 14)
    return adxdf


# Parabolic SAR
# 2 main pieces: Trend Direction (TD), Acceleration Factor (AF), Extreme Point (EP)
# SAR = Previous Periods SAR + Acceleration Factor * (Extreme Point (Local Max/Min) - Previous Periods SAR)
# Acceleration Factor = 0.02 --> usually
# First SAR = local Min/Max dependent on trend direction
# look back Period --> Used to determine First SAR and Extreme Points Value --> 5 rows (not strict) -->
#   checks close slope --> if close slope + --> uptrend SAR = MIN(low Loop Back Period), EP = MAX(high Loop Back Period) -->
#   if close slope - --> SAR = MAX(high Loop Back Period), EP = MIN(low Loop Back Period)


def sar_df(sparkdf):

    window = Window.partitionBy("symbol").orderBy(col("timestamp").asc())
    firstsarwindow = window.rowsBetween(-4, 5)

    sarschema = (
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
            func.sign((col("close") - (col("lmin"))) / 5),
        ),
    )
    sarvarsdf = sarvarsdf.withColumn(
        "prevtd", func.when(col("rnum") <= 5, func.lag(col("td")).over(window))
    )
    sarvarsdf = sarvarsdf.withColumn(
        "td", func.when((col("rnum") <= 5) & (col("td") == 0), col("prevtd"))
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

    # While Up trend --> If SAR > low (Extreme Point) --> Trendreversal (Trend flips to Down Trend) --> Old Extreme Point becomes Current SAR --> Extreme Point = low
    # While Down trend --> If SAR < high (Extreme Point) --> Trendreversal (Trend flips to Up Trend) --> Old Extreme Point becomes Current SAR --> Extreme Point = high
    # Acceleration Factor increases by 0.02 every SAR passes Extreme Point --> Max Acceleration Factor = 0.20
    # SAR = Previous Periods SAR + Acceleration Factor * (Extreme Point (Local Max/Min) - Previous Periods SAR)
    def inner_sar_df(pdf):
        pdf = pdf.sort_values("timestamp")
        pdf = pdf.reset_index(drop=True)

        for i in range(5, len(pdf)):
            oldsar = pdf.at[(i - 1), "sar"]
            oldep = pdf.at[(i - 1), "ep"]
            oldtd = pdf.at[(i - 1), "td"]
            oldaf = pdf.at[(i - 1), "af"]

            sar = oldsar + oldaf * (oldep - oldsar)

            if sar < pdf.at[i, "high"] and oldtd < 0:
                sar = oldep
                td = oldtd * -1
                af = 0.02

            elif sar > pdf.at[i, "low"] and oldtd > 0:
                sar = oldep
                td = oldtd * -1
                af = 0.02

            else:
                td = oldtd

            if td > 0 and oldep < pdf.at[i, "high"]:
                ep = pdf.at[i, "high"]
                if oldaf < 0.19:
                    af = oldaf + 0.02
                else:
                    af = oldaf
            elif td < 0 and oldep > pdf.at[i, "low"]:
                ep = pdf.at[i, "low"]
                if oldaf < 0.19:
                    af = oldaf + 0.02
                else:
                    af = oldaf
            else:
                ep = oldep
                af = oldaf

            pdf.at[i, "sar"] = sar
            pdf.at[i, "ep"] = ep
            pdf.at[i, "td"] = td
            pdf.at[i, "af"] = af
        return pdf

    return sarvarsdf.groupBy("symbol").applyInPandas(inner_sar_df, schema=sarschema)


def call_indicators(
    spark=None,
    client=None,
    sparkdf=None,
    symbols=None,
    datefrom=None,
    dateto=datetime.today(),
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

    if client is None:
        client = alpaca_historical_data_connect()

    if sparkdf is None:
        sparkdf = getstockbardata(client, spark, symbols, datefrom, dateto)

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
    return indicatordf


def checkparquet(spark, parquetpath, symbol):
    check = spark.read.parquet(parquetpath)
    check.printSchema()
    check.filter(col("symbol") == symbol).show(25)


spark = spark_connect()
sym = ["SPY"]
parquetpath = "/mnt/data/output/indicators"


dfs = call_indicators(spark=spark, symbols=sym, datefrom=datetime(2025, 8, 1))
dfs.write.mode("overwrite").partitionBy("symbol").parquet(parquetpath)
checkparquet(spark, parquetpath, "SPY")


dfs.show()
