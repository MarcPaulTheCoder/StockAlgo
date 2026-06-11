import pytest
from pyspark.sql import SparkSession


@pytest.fixture(scope="session")
def spark(tmp_path_factory):
    warehouse = tmp_path_factory.mktemp("iceberg_warehouse")
    s = (
        SparkSession.builder.master("local[2]")
        .appName("stockalgo-tests")
        .config("spark.sql.shuffle.partitions", "2")
        .config(
            "spark.sql.extensions",
            "org.apache.iceberg.spark.extensions.IcebergSparkSessionExtensions",
        )
        .config("spark.sql.catalog.stockalgo", "org.apache.iceberg.spark.SparkCatalog")
        .config("spark.sql.catalog.stockalgo.type", "hadoop")
        .config("spark.sql.catalog.stockalgo.warehouse", f"file://{warehouse}")
        .getOrCreate()
    )
    yield s
    s.stop()
