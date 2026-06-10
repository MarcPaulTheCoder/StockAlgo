from functools import reduce
from alpaca.data.timeframe import TimeFrame
from datetime import datetime
from pyspark.sql import Window, functions as func
from alpaca.data.requests import StockBarsRequest
from pyspark.sql.functions import col, lit
import logging

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

    sparkdf = sparkdf.withColumnRenamed("timestamp", "time_stamp")
    window = Window.partitionBy("symbol").orderBy(col("time_stamp").asc())

    sparkdf = sparkdf.withColumns(
        {
            "valid_close": func.when(
                (col("close") > lit(0)) & (col("close").isNotNull()), lit(1)
            ).otherwise(lit(0)),
            "lag_close": func.lag(col("close")).over(window),
            "lead_close": func.lead(col("close")).over(window),
            "valid_volume": func.when(
                (col("volume") > lit(0)) & (col("volume").isNotNull()), lit(1)
            ).otherwise(lit(0)),
            "lag_volume": func.lag(col("volume")).over(window),
            "lead_volume": func.lead(col("volume")).over(window),
            "valid_low": func.when(
                (col("low") > lit(0))
                & (col("low").isNotNull())
                & (
                    func.least(col("low"), col("high"), col("close"), col("open"))
                    == col("low")
                ),
                lit(1),
            ).otherwise(lit(0)),
            "lag_low": func.lag(col("low")).over(window),
            "lead_low": func.lead(col("low")).over(window),
            "valid_high": func.when(
                (col("high") > lit(0))
                & (col("high").isNotNull())
                & (
                    func.greatest(col("high"), col("low"), col("close"), col("open"))
                    == col("high")
                ),
                lit(1),
            ).otherwise(lit(0)),
            "lag_high": func.lag(col("high")).over(window),
            "lead_high": func.lead(col("high")).over(window),
        }
    )

    sparkdf = sparkdf.withColumns(
        {
            "valid_close": func.when(
                (col("lag_close").isNull()) | (col("lead_close").isNull()),
                col("valid_close"),
            )
            .when(
                (col("valid_close") == 1)
                & (
                    (
                        (
                            func.try_divide(
                                (func.abs(col("close") - col("lag_close"))),
                                col("lag_close"),
                            )
                        )
                        <= lit(0.5)
                    )
                    | (
                        (
                            func.try_divide(
                                (func.abs(col("close") - col("lead_close"))),
                                col("lead_close"),
                            )
                        )
                        <= lit(0.5)
                    )
                ),
                lit(1),
            )
            .otherwise(lit(0)),
            "valid_low": func.when(
                (col("lag_low").isNull()) | (col("lead_low").isNull()),
                col("valid_low"),
            )
            .when(
                (col("valid_low") == 1)
                & (
                    (
                        func.try_divide(
                            (func.abs(col("low") - col("lag_low"))), col("lag_low")
                        )
                        <= lit(0.5)
                    )
                    | (
                        func.try_divide(
                            (func.abs(col("low") - col("lead_low"))),
                            col("lead_low"),
                        )
                        <= lit(0.5)
                    )
                ),
                lit(1),
            )
            .otherwise(lit(0)),
            "valid_high": func.when(
                (col("lag_high").isNull()) | (col("lead_high").isNull()),
                col("valid_high"),
            )
            .when(
                (col("valid_high") == 1)
                & (
                    (
                        (
                            func.try_divide(
                                (func.abs(col("high") - col("lag_high"))),
                                col("lag_high"),
                            )
                        )
                        <= lit(0.5)
                    )
                    | (
                        (
                            func.try_divide(
                                (func.abs(col("high") - col("lead_high"))),
                                col("lead_high"),
                            )
                        )
                        <= lit(0.5)
                    )
                ),
                lit(1),
            )
            .otherwise(lit(0)),
        }
    )

    sparkdf = sparkdf.withColumn(
        "is_valid",
        func.when(
            (col("valid_volume") == 1)
            & (col("valid_close") == 1)
            & (col("valid_low") == 1)
            & (col("valid_high") == 1),
            1,
        )
        .otherwise(lit(0))
        .cast("boolean"),
    )

    sparkdf = sparkdf.drop(
        "valid_volume",
        "valid_close",
        "valid_low",
        "valid_high",
        "lag_low",
        "lead_low",
        "lag_close",
        "lead_close",
        "lag_close",
        "lead_close",
        "lag_volume",
        "lead_volume",
        "lag_high",
        "lead_high",
    )

    sparkdf.createOrReplaceTempView("new_raw_bars")
    spark.sql(""" MERGE INTO stockalgo.market.raw_bars AS rb 
              USING new_raw_bars AS nrb ON rb.symbol = nrb.symbol AND rb.time_stamp = nrb.time_stamp
              WHEN MATCHED THEN UPDATE SET *
              WHEN NOT MATCHED THEN INSERT *
              """)
    if failed:
        logger.warning("%d chunks failed: %s", len(failed), failed)
