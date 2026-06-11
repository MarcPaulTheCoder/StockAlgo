import pytest
from pyspark.sql import SparkSession
import os


@pytest.fixture(scope="session")
def spark_integration():
    s = (
        SparkSession.builder.master("local[2]")
        .appName("stockalgo-integration")
        .config(
            "spark.sql.extensions",
            "org.apache.iceberg.spark.extensions.IcebergSparkSessionExtensions",
        )
        .config("spark.sql.catalog.stockalgo", "org.apache.iceberg.spark.SparkCatalog")
        .config("spark.sql.catalog.stockalgo.type", "rest")
        .config("spark.sql.catalog.stockalgo.uri", os.environ["POLARIS_URI"])
        .config("spark.sql.catalog.stockalgo.credential", os.environ["POLARIS_CREDS"])
        .config("spark.sql.catalog.stockalgo.warehouse", "stockalgo")
        .config("spark.sql.catalog.stockalgo.scope", "PRINCIPAL_ROLE:ALL")
        .config(
            "spark.sql.catalog.stockalgo.io-impl", "org.apache.iceberg.aws.s3.S3FileIO"
        )
        .config("spark.sql.catalog.stockalgo.s3.endpoint", os.environ["MINIO_ENDPOINT"])
        .config("spark.sql.catalog.stockalgo.s3.path-style-access", "true")
        .config("spark.sql.catalog.stockalgo.rest-metrics-reporting-enabled", "false")
        .getOrCreate()
    )
    yield s
    s.stop()
