from functools import reduce
from alpaca.data.timeframe import TimeFrame
from datetime import datetime
from alpaca.data.requests import StockBarsRequest
from pyspark.sql.functions import col
import logging
from stockalgo.validate_bars import validate_bars

logger = logging.getLogger(__name__)


def get_symbols(spark):
    symdf = spark.read.table("stockalgo.market.company_info").where(col("active"))
    symdf = symdf.select("symbol")
    sym = [row["symbol"] for row in symdf.collect()]
    return sym


def getstockbardata(client, spark, symbols, datefrom=None, dateto=None):

    if dateto is None:
        dateto = datetime.today()

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
    if temp.empty:
        return None
    else:
        sparkdf = spark.createDataFrame(temp)
        return sparkdf


def merge_raw_bars(spark, spark_df):
    spark_df.createOrReplaceTempView("new_raw_bars")
    spark.sql(""" MERGE INTO stockalgo.market.raw_bars AS rb 
              USING new_raw_bars AS nrb ON rb.symbol = nrb.symbol AND rb.time_stamp = nrb.time_stamp
              WHEN MATCHED THEN UPDATE SET *
              WHEN NOT MATCHED THEN INSERT *
              """)


def clean_and_insert_rawbars(
    sym_client, spark, chunk_size=200, dt_year=2026, dt_month=1, dt_day=1
):

    sym = get_symbols(spark)

    sparkdflist = []
    failed = []

    for i in range(0, len(sym), chunk_size):
        chunk = sym[i : i + chunk_size]
        try:
            tempsparkdf = getstockbardata(
                client=sym_client,
                spark=spark,
                symbols=chunk,
                datefrom=datetime(dt_year, dt_month, dt_day),
            )

            if tempsparkdf is not None and tempsparkdf.head():
                sparkdflist.append(tempsparkdf)
        except Exception as e:
            logger.warning("chunk %s failed: %s", i, e)
            failed.append(chunk)

    if not sparkdflist:
        raise RuntimeError(f"{len(failed)} errored, all other chunks empty")

    sparkdf = reduce(lambda df_a, df_b: df_a.unionByName(df_b), sparkdflist)

    sparkdf = validate_bars(sparkdf)

    merge_raw_bars(spark, spark_df=sparkdf)

    if failed:
        logger.warning("%d chunks failed: %s", len(failed), failed)
