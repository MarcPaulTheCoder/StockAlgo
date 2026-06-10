from pyspark.sql import SparkSession
from alpaca.data.historical import StockHistoricalDataClient
import os


def spark_connect():
    spark = (
        SparkSession.builder.appName("alpaca-ingest")
        .config("spark.sql.artifact.rootDirectory", "/tmp/spark-artifacts")
        .config("spark.sql.scripting.enabled", "true")
        .config(
            "spark.sql.catalog.stockalgo.credential", os.getenv(key="POLARIS_CREDS")
        )
        .getOrCreate()
    )
    return spark


def alpaca_historical_data_connect():
    client = StockHistoricalDataClient(
        os.getenv(key="ALPACA_KEY"), os.getenv(key="ALPACA_SECRET")
    )
    return client
