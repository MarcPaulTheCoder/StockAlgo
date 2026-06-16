from alpaca.data.timeframe import TimeFrame
from datetime import datetime
from alpaca.data.historical import StockHistoricalDataClient
from alpaca.data.requests import StockBarsRequest
from pyspark.sql import functions as F, SparkSession, DataFrame
from pyspark.sql.types import (
    StructType,
    StructField,
    TimestampType,
    DoubleType,
    StringType,
)
from stockalgo.validate_bars import validate_bars
from stockalgo.connections import alpaca_historical_data_connect
import pandas as pd
from zoneinfo import ZoneInfo
from collections.abc import Iterable

SPARK_ALPACA_SCHEMA = StructType(
    [
        StructField("symbol", StringType(), False),
        StructField("timestamp", TimestampType(), True),
        StructField("open", DoubleType(), True),
        StructField("high", DoubleType(), True),
        StructField("low", DoubleType(), True),
        StructField("close", DoubleType(), True),
        StructField("volume", DoubleType(), True),
        StructField("trade_count", DoubleType(), True),
        StructField("vwap", DoubleType(), True),
        StructField("error", StringType(), True),
        StructField("error_at", TimestampType(), True),
    ]
)

PANDAS_ALPACA_SCHEMA = {
    "symbol": "string",
    "timestamp": "datetime64[ns]",
    "open": "Float64",
    "high": "Float64",
    "low": "Float64",
    "close": "Float64",
    "volume": "Float64",
    "trade_count": "Float64",
    "vwap": "Float64",
    "error": "string",
    "error_at": "datetime64[ns]",
}


def get_symbols(spark: SparkSession) -> DataFrame:
    symdf = spark.read.table("stockalgo.market.company_info").where(F.col("active"))
    symdf = symdf.select("symbol")
    return symdf


def getstockbardata(
    client: StockHistoricalDataClient,
    symbols: list[str],
    datefrom: datetime | None = None,
    dateto: datetime | None = None,
) -> pd.DataFrame | None:
    """
    fetches daily alpaca values and returns a pandas dataframe with a schema of PANDAS_ALPACA_SCHEMA
    three potential ways the data will be returned:
    1. successful api calls will return their data via data_df
    2. any api failures are caught via fail_pdf, the dataframe is written to the fail_log via clean_and_insert_rawbars()
    3. empty successful api calls will return None and be dropped by clean_and_insert_rawbars()
    """

    if dateto is None:
        dateto = datetime.today()

    if datefrom is None:
        apicall = StockBarsRequest(
            symbol_or_symbols=symbols,
            timeframe=TimeFrame.Day,  # type: ignore
            end=dateto,
        )
    else:
        apicall = StockBarsRequest(
            symbol_or_symbols=symbols,
            timeframe=TimeFrame.Day,  # type: ignore
            start=datefrom,
            end=dateto,
        )
    try:
        data_df = client.get_stock_bars(apicall).df.reset_index()  # type: ignore
        if not data_df.empty:
            data_df["timestamp"] = data_df["timestamp"].dt.tz_localize(None)
            data_df = data_df.reindex(columns=PANDAS_ALPACA_SCHEMA.keys()).astype(
                PANDAS_ALPACA_SCHEMA
            )
            return data_df
        else:
            return None
    except Exception as e:
        fail_pdf = pd.DataFrame({"symbol": symbols})
        fail_pdf = fail_pdf.reindex(columns=PANDAS_ALPACA_SCHEMA.keys()).astype(
            PANDAS_ALPACA_SCHEMA
        )
        fail_pdf["error"] = str(e)
        fail_pdf["error_at"] = datetime.now(ZoneInfo("America/New_York"))
        return fail_pdf


def merge_raw_bars(spark: SparkSession, spark_df: DataFrame) -> None:
    spark_df.createOrReplaceTempView("new_raw_bars")
    spark.sql(""" MERGE INTO stockalgo.market.raw_bars AS rb 
              USING new_raw_bars AS nrb ON rb.symbol = nrb.symbol AND rb.time_stamp = nrb.time_stamp
              WHEN MATCHED THEN UPDATE SET rb.time_stamp = nrb.time_stamp, rb.open = nrb.open, rb.close = nrb.close, 
              rb.high = nrb.high, rb.low = nrb.low, rb.volume= nrb.volume, rb.vwap=nrb.vwap, rb.trade_count = nrb.trade_count, 
              rb.is_valid = nrb.is_valid
              WHEN NOT MATCHED THEN INSERT (symbol, time_stamp, open, close, high, low, volume, vwap, trade_count, is_valid)
              VALUES(nrb.symbol, nrb.time_stamp, nrb.open, nrb.close, nrb.high, nrb.low, nrb.volume, nrb.vwap, nrb.trade_count, nrb.is_valid);
              """)


def insert_run_log(spark: SparkSession, spark_df: DataFrame) -> None:
    spark_df.createOrReplaceTempView("new_run")
    spark.sql("""
    MERGE INTO stockalgo.market.run_log AS rl USING new_run AS rn ON rl.run_id = rn.run_id WHEN MATCHED THEN UPDATE SET 
    rl.run_start = rn.run_start, rl.run_end = rn.run_end, rl.data_date_from = rn.data_date_from, rl.data_date_to = rn.data_date_to,
    rl.data_succeeded = rn.succeeded_rows, rl.chunk_size = rn.chunk_size
    WHEN NOT MATCHED THEN INSERT (run_id, run_start, run_end, data_date_from, data_date_to, data_succeeded, chunk_size)
    VALUES(rn.run_id, rn.run_start, rn.run_end, rn.data_date_from, rn.data_date_to, rn.succeeded_rows, rn.chunk_size);
              """)


def insert_fail_log(spark: SparkSession, spark_df: DataFrame) -> None:
    spark_df.createOrReplaceTempView("new_fails")
    spark.sql("""
    MERGE INTO stockalgo.market.fail_log AS fl USING new_fails AS nf ON fl.source_ref = nf.run_id AND fl.symbol = nf.symbol
    WHEN MATCHED THEN UPDATE SET fl.error = nf.error, fl.error_at = nf.error_at 
    WHEN NOT MATCHED THEN INSERT (source, source_ref, symbol, error, error_at)
    VALUES(nf.source, nf.run_id, nf.symbol, nf.error, nf.error_at);
              """)


def clean_and_insert_rawbars(
    airflow_run_id: str,
    spark: SparkSession,
    repartition_num: int = 32,
    start_date: datetime = datetime(2026, 1, 1),
) -> None:
    """
    distributed ingest process:
    executors: fetch values from alpaca --> validates values --> merge values to raw_bars table
    mapInPandas is used so each executor fetches values for its own list of symbols
    mixed_sparkdf is cached because there's at max, 3 ways the dataframe's used:
    1. good values: where error is null --> validate values --> merge values into raw_bars table
    2. failed symbols: where error is not null --> merge symbols into fail_log table to be examined by human
    3. run log: GroupBy Airflow run_id --> provides detailed information about the entire ingest process per run --> merge into run_log table
    responsible for writing to the three iceberg tables mentioned above
    """

    start_time = datetime.now(ZoneInfo("America/New_York"))
    symbols = get_symbols(spark)
    symbols_partitioned = symbols.repartition(repartition_num)
    symbols_size = symbols_partitioned.count()

    def exec_iterator_alpaca(syms: Iterable[pd.DataFrame]) -> Iterable[pd.DataFrame]:
        alpaca_client = alpaca_historical_data_connect()

        for sym in syms:
            sym_list = sym["symbol"].tolist()
            data_pdf = getstockbardata(
                client=alpaca_client,
                symbols=sym_list,
                datefrom=start_date,
            )
            if data_pdf is not None:
                yield data_pdf

    mixed_sparkdf = symbols_partitioned.mapInPandas(
        exec_iterator_alpaca, SPARK_ALPACA_SCHEMA
    ).cache()

    good_spark_df = mixed_sparkdf.filter(F.col("error").isNull())

    validated_df = validate_bars(good_spark_df)
    merge_raw_bars(spark, spark_df=validated_df)

    end_time = datetime.now(ZoneInfo("America/New_York"))

    run_id_df = mixed_sparkdf.withColumns(
        {
            "run_id": F.lit(airflow_run_id),
            "source": F.lit("alpaca_batch"),
        }
    )

    error_df = run_id_df.filter(F.col("error").isNotNull())
    insert_fail_log(spark, error_df)

    run_id_df = run_id_df.groupBy(F.col("run_id")).agg(
        F.sum(F.when(F.col("error").isNull(), 1).otherwise(0)).alias("succeeded_rows"),
        F.min(F.col("timestamp")).alias("data_date_from"),
        F.max(F.col("timestamp")).alias("data_date_to"),
    )

    run_id_df = run_id_df.withColumns(
        {
            "run_end": F.lit(end_time),
            "run_start": F.lit(start_time),
            "chunk_size": F.try_divide(
                F.lit(symbols_size), F.lit(repartition_num)
            ).cast("int"),
        }
    )

    insert_run_log(spark, run_id_df)
