import pytest


@pytest.mark.integration
def test_iceberg(spark_integration):
    spark = spark_integration
    spark.sql("DROP TABLE IF EXISTS stockalgo.test.smoke PURGE")
    spark.sql("DROP NAMESPACE IF EXISTS stockalgo.test")

    spark.sql("CREATE NAMESPACE IF NOT EXISTS stockalgo.test")

    spark.sql("""
      CREATE TABLE IF NOT EXISTS stockalgo.test.smoke (
        id BIGINT,
        name STRING
      ) USING iceberg
    """)

    spark.sql("INSERT INTO stockalgo.test.smoke VALUES (1, 'hello iceberg')")

    namespace_df = spark.sql("SHOW NAMESPACES IN stockalgo")
    table_df = spark.sql("SELECT * FROM stockalgo.test.smoke")
    snapshot_df = spark.sql("SELECT * FROM stockalgo.test.smoke.snapshots")

    assert namespace_df.filter(namespace_df.namespace == "test").count()
    assert table_df.select("name").first()[0] == "hello iceberg"
    assert snapshot_df.count()
