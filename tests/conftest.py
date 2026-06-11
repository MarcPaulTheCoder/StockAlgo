import pytest
from pyspark.sql import SparkSession


@pytest.fixture(scope="session")
def spark():
    s = (
        SparkSession.builder.master("local[2]")
        .appName("stockalgo-tests")
        .config("spark.sql.shuffle.partitions", "2")
        .getOrCreate()
    )
    yield s
    s.stop()
