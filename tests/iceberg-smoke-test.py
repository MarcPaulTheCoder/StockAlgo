from pyspark.sql import SparkSession

spark = SparkSession.builder.appName("iceberg-smoke-test").getOrCreate()

print("=== Catalogs visible ===")
spark.sql("SHOW CATALOGS").show(truncate=False)

print("=== Creating namespace ===")
spark.sql("CREATE NAMESPACE IF NOT EXISTS stockalgo.test")

print("=== Creating table ===")
spark.sql("""
  CREATE TABLE IF NOT EXISTS stockalgo.test.smoke (
    id BIGINT,
    name STRING
  ) USING iceberg
""")

print("=== Inserting row ===")
spark.sql("INSERT INTO stockalgo.test.smoke VALUES (1, 'hello iceberg')")

print("=== Reading back ===")
spark.sql("SELECT * FROM stockalgo.test.smoke").show()

print("=== Showing snapshots ===")
spark.sql("SELECT * FROM stockalgo.test.smoke.snapshots").show(truncate=False)

print("=== Smoke test complete ===")
