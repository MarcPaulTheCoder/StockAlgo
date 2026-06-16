from pyspark.sql import Window, WindowSpec, functions as F, DataFrame, SparkSession
from pyspark.sql.types import DoubleType, StructType
from stockalgo.connections import spark_connect
from stockalgo.indicator_math import (
    do_applyInPandas,
)


def _by_symbol() -> WindowSpec:
    return Window.partitionBy("symbol").orderBy("time_stamp")


def build_output_schema(input_df: DataFrame) -> StructType:
    """returns the applyInPandas output schema: input schema plus the 18 indicator columns, in append order."""

    output_schema = (
        StructType(list(input_df.schema))
        .add("ema", DoubleType())
        .add("macd_12", DoubleType())
        .add("macd_26", DoubleType())
        .add("three_day_ema", DoubleType())
        .add("ten_day_ema", DoubleType())
        .add("smooth_dm_plus", DoubleType())
        .add("smooth_dm_minus", DoubleType())
        .add("posrolling", DoubleType())
        .add("negrolling", DoubleType())
        .add("atr", DoubleType())
        .add("macd_line", DoubleType())
        .add("signal_line", DoubleType())
        .add("dx", DoubleType())
        .add("adx", DoubleType())
        .add("histogram", DoubleType())
        .add("chaikin_ad", DoubleType())
        .add("rs", DoubleType())
        .add("rsi", DoubleType())
    )
    return output_schema


def sma_df(spark_df: DataFrame, num_obs: int = 5) -> DataFrame:
    """the num_obs-period simple moving average of close per symbol."""

    window = _by_symbol().rowsBetween(-(num_obs - 1), 0)
    sma = spark_df.withColumn("sma", F.avg(F.col("close")).over(window))
    return sma


def bbands_df(
    spark_df: DataFrame,
    sma_period: int = 20,
    std_multiplier: float = 2,
) -> DataFrame:
    """sma_plus/sma_minus = sma ± std_multiplier × rolling stddev of close over sma_period."""

    window = _by_symbol().rowsBetween(-(sma_period - 1), 0)
    sma = sma_df(spark_df=spark_df, num_obs=sma_period)
    bb_df = sma.withColumns(
        {
            "sma_plus": F.col("sma")
            + (F.stddev_pop("close").over(window) * std_multiplier),
            "sma_minus": F.col("sma")
            - (F.stddev_pop("close").over(window) * std_multiplier),
        }
    )
    return bb_df


def obv_df(sparkdf: DataFrame) -> DataFrame:
    """running sum of volume signed by close vs prior close, per symbol."""

    closelagwindow = _by_symbol()
    prior_close = sparkdf.withColumn("prior_close", F.lag("close").over(closelagwindow))

    signed_vol_df = prior_close.withColumn(
        "signed_volume",
        F.when(
            (F.col("close") >= F.col("prior_close")) | (F.col("prior_close").isNull()),
            F.col("volume"),
        ).otherwise(F.col("volume") * -1),
    )

    obv = signed_vol_df.withColumn(
        "obv", F.sum(F.col("signed_volume")).over(closelagwindow)
    )
    return obv


def roc_df(spark_df: DataFrame) -> DataFrame:
    """1-period percent rate of change of close, per symbol."""

    window = _by_symbol()
    roc = spark_df.withColumns(
        {
            "prior_close": F.lag("close").over(window),
            "roc": (
                F.try_divide(F.try_subtract("close", "prior_close"), "prior_close")
                * 100
            ),
        }
    )
    return roc


# Parabolic SAR
# 2 main pieces: Trend Direction (TD), Acceleration Factor (AF), Extreme Point (EP)
# SAR = Previous Periods SAR + Acceleration Factor * (Extreme Point (Local Max/Min) - Previous Periods SAR)
# Acceleration Factor = 0.02 --> usually
# First SAR = local Min/Max dependent on trend direction
# look back Period --> Used to determine First SAR and Extreme Points Value --> 5 rows (not strict) -->
#   checks close slope --> if close slope + --> uptrend SAR = MIN(low Loop Back Period), EP = MAX(high Loop Back Period) -->
#   if close slope - --> SAR = MAX(high Loop Back Period), EP = MIN(low Loop Back Period)


def sar_df(spark_df: DataFrame, seed_rows: int = 5) -> DataFrame:
    """
    seeds sar/ep/td/af for the first seed_rows rows per symbol in spark.
    sar_math does the row-by-row recursion after that, filling the rows left null here.
    seed_rows here MUST match seed_rows in sar_math or sar breaks.
    seed_low/seed_high/row_num/prev_td are scratch, dropped later in build_indicator_inputs.
    """

    window = _by_symbol()
    seed_window = window.rowsBetween(-(seed_rows - 1), 0)

    sar_sdf = spark_df.withColumns(
        {
            "af": F.lit(0.02),
            "sar": F.lit(0.0),
            "td": F.lit(0),
            "seed_low": F.lit(0.0),
            "seed_high": F.lit(0.0),
        }
    )

    sar_sdf = sar_sdf.withColumn("row_num", F.row_number().over(window))
    sar_sdf = sar_sdf.withColumns(
        {
            "seed_low": F.when(
                F.col("row_num") <= seed_rows, F.min(F.col("low")).over(seed_window)
            ),
            "seed_high": F.when(
                F.col("row_num") <= seed_rows, F.max(F.col("high")).over(seed_window)
            ),
        }
    )
    sar_sdf = sar_sdf.withColumn(
        "td",
        F.when(
            F.col("row_num") <= seed_rows,
            F.sign(F.col("close") - ((F.col("seed_low") + F.col("seed_high")) / 2)),
        ),
    )
    sar_sdf = sar_sdf.withColumn(
        "prev_td",
        F.when(F.col("row_num") <= seed_rows, F.lag(F.col("td")).over(window)),
    )
    sar_sdf = sar_sdf.withColumn(
        "td",
        F.when(
            (F.col("row_num") <= seed_rows) & (F.col("td") == 0), F.col("prev_td")
        ).otherwise(F.col("td")),
    )
    sar_sdf = sar_sdf.withColumns(
        {
            "sar": F.when(
                (F.col("row_num") <= seed_rows) & (F.col("td") == 1), F.col("seed_low")
            ).when(
                (F.col("row_num") <= seed_rows) & (F.col("td") == -1),
                F.col("seed_high"),
            ),
            "ep": F.when(
                (F.col("row_num") <= seed_rows) & (F.col("td") == 1), F.col("seed_high")
            ).when(
                (F.col("row_num") <= seed_rows) & (F.col("td") == -1), F.col("seed_low")
            ),
        }
    )
    return sar_sdf


def build_indicator_inputs(
    sparkdf: DataFrame,
) -> DataFrame:
    """
    builds the spark window cols the pandas pass reads:
    pos_change/neg_change (rsi), true_range (atr), adl (chaikin), dm_plus/dm_minus (adx), sar seed.
    selects down to only what do_applyInPandas reads plus what the merge writes.
    the rest is scratch, dropped before applyInPandas so it never ships to pandas.
    """

    window = _by_symbol()
    change_df = sparkdf.withColumn(
        "close_change", F.col("close") - F.lag("close").over(window)
    )
    gain_losses_df = change_df.withColumns(
        {
            "pos_change": F.when(
                F.col("close_change") > 0, F.col("close_change")
            ).otherwise(0),
            "neg_change": F.abs(
                F.when(F.col("close_change") < 0, F.col("close_change")).otherwise(0)
            ),
        }
    )
    true_range_df = gain_losses_df.withColumns(
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

    money_flow_df = true_range_df.withColumns(
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

    lag_df = adl_df.withColumns(
        {
            "laglow": F.lag("low").over(window),
            "laghigh": F.lag("high").over(window),
        }
    )

    dm_df = lag_df.withColumns(
        {
            "dm_plus": F.when(
                (F.col("high") - F.col("laghigh") > F.col("laglow") - F.col("low"))
                & (F.col("high") - F.col("laghigh") > 0),
                F.col("high") - F.col("laghigh"),
            ).otherwise(0),
            "dm_minus": F.when(
                (F.col("laglow") - F.col("low") > F.col("high") - F.col("laghigh"))
                & (F.col("laglow") - F.col("low") > 0),
                F.col("laglow") - F.col("low"),
            ).otherwise(0),
        }
    )
    spark_computed_df = sar_df(spark_df=dm_df)
    spark_cleaned_df = spark_computed_df.select(
        "symbol",
        "time_stamp",
        "open",
        "high",
        "low",
        "close",
        "volume",
        "vwap",
        "trade_count",
        "sma",
        "sma_plus",
        "sma_minus",
        "obv",
        "roc",
        "adl",
        "dm_plus",
        "dm_minus",
        "pos_change",
        "neg_change",
        "true_range",
        "sar",
        "ep",
        "td",
        "af",
    )
    return spark_cleaned_df


def compute_pandas_from_spark(
    spark_df: DataFrame,
    ema_period: int,
    bbands_sma_period: int = 20,
    bbands_std: float = 2,
) -> DataFrame:
    """
    chains the spark feature builders (obv, bbands, roc, build_indicator_inputs)
    then runs the per-symbol pandas pass with groupBy(symbol).applyInPandas.
    schema is built off the projected frame on purpose: applyInPandas matches by position,
    so it's input cols then the 18 indicators in the order do_applyInPandas adds them.
    """

    sdf = (
        spark_df.transform(obv_df)
        .transform(lambda d: bbands_df(d, bbands_sma_period, bbands_std))
        .transform(roc_df)
    )
    sdf = build_indicator_inputs(sparkdf=sdf)
    sdf_schema = build_output_schema(input_df=sdf)
    fin_df = sdf.groupBy("symbol").applyInPandas(
        lambda d: do_applyInPandas(d, ema_period=ema_period), schema=sdf_schema
    )
    return fin_df


def call_indicators(
    spark: SparkSession | None = None,
    spark_df: DataFrame | None = None,
    ema_period: int = 20,
    bbandsma_period: int = 20,
    bbands_std: int = 2,
) -> None:
    """
    indicator stage entry point.
    with no spark_df it reads raw_bars semi-joined to active company_info, is_valid bars only,
    computes everything, merges into stock_indicator_data on (symbol, time_stamp):
    matched updates, not matched inserts. writes as a side effect, returns nothing.
    """

    if spark is None:
        spark = spark_connect("stockalgo-compute-indicator")

    if spark_df is None:
        raw_bars_tbl = spark.table("stockalgo.market.raw_bars")
        comp_info_tbl = spark.table("stockalgo.market.company_info")
        spark_df = raw_bars_tbl.join(
            comp_info_tbl,
            on=(raw_bars_tbl["symbol"] == comp_info_tbl["symbol"])
            & (comp_info_tbl["active"]),
            how="left_semi",
        ).where((F.col("is_valid")))

    indicatordf = compute_pandas_from_spark(
        spark_df=spark_df,
        ema_period=ema_period,
        bbands_sma_period=bbandsma_period,
        bbands_std=bbands_std,
    )

    indicatordf.createOrReplaceTempView("new_indicator_data")
    spark.sql(""" 
    MERGE INTO stockalgo.market.stock_indicator_data AS sia 
    USING new_indicator_data AS nid ON sia.symbol = nid.symbol AND sia.time_stamp = nid.time_stamp 
    WHEN MATCHED THEN UPDATE SET
    sia.open = nid.open, sia.high = nid.high, sia.low = nid.low, sia.close = nid.close,sia.volume = nid.volume, 
    sia.vwap = nid.vwap, sia.trade_count = nid.trade_count, sia.sma = nid.sma, sia.ema = nid.ema, 
    sia.macd_line = nid.macd_line, sia.macd_signal = nid.signal_line, sia.macd_histogram = nid.histogram, sia.rsi = nid.rsi, 
    sia.rs = nid.rs, sia.roc = nid.`roc`, sia.obv = nid.obv, sia.atr = nid.atr, sia.adx = nid.adx, 
    sia.sar = nid.sar, sia.ep = nid.ep, sia.td = nid.td, sia.af = nid.af, sia.upper_bollinger_band = nid.`sma_plus`, 
    sia.middle_bollinger_band = nid.sma, sia.lower_bollinger_band = nid.`sma_minus`, sia.dm_minus = nid.`dm_minus`, 
    sia.dm_plus = nid.`dm_plus`, sia.smooth_dm_plus = nid.`smooth_dm_plus`, sia.smooth_dm_minus = nid.`smooth_dm_minus`, sia.adl = nid.adl, 
    sia.three_day_ema = nid.`three_day_ema`, sia.ten_day_ema = nid.`ten_day_ema`, sia.dx = nid.dx, sia.chaikin_ad = nid.chaikin_ad
    WHEN NOT MATCHED THEN INSERT 
    (symbol, time_stamp, open, high, low, close, volume, vwap, trade_count, sma, ema, 
    macd_line, macd_signal, macd_histogram, rsi, rs, roc, obv, atr, adx, sar, ep, td, af, upper_bollinger_band, middle_bollinger_band, 
    lower_bollinger_band, dm_minus, dm_plus, smooth_dm_plus, smooth_dm_minus, adl, three_day_ema, ten_day_ema, dx, chaikin_ad) 
    VALUES (
    nid.symbol, nid.time_stamp, nid.open, nid.high, nid.low, nid.close, nid.volume, nid.vwap, nid.trade_count,
    nid.sma, nid.ema, nid.macd_line, nid.signal_line, nid.histogram, nid.rsi, nid.rs, nid.`roc`, nid.obv, nid.atr,
    nid.adx, nid.sar, nid.ep, nid.td, nid.af, nid.`sma_plus`, nid.sma, nid.`sma_minus`, nid.`dm_minus`, nid.`dm_plus`, nid.`smooth_dm_plus`, 
    nid.`smooth_dm_minus`, nid.adl, nid.`three_day_ema`, nid.`ten_day_ema`, nid.dx, nid.chaikin_ad)
    """)
