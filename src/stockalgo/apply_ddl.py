from pyspark.sql import SparkSession


def spark_connect():
    spark = (
        SparkSession.builder.appName("iceberg_table_creation")
        .config("spark.sql.artifact.rootDirectory", "/tmp/spark-artifacts")
        .config("spark.sql.scripting.enabled", "true")
        .getOrCreate()
    )
    return spark


path = "/mnt/data/ddl/stockTableCreation.sql"
with open(path, "r") as f:
    sql_txt = f.readlines()

lines = [line for line in sql_txt if not line.strip().startswith("--")]
clean_sql_txt = "".join(lines)
queries = [query for query in clean_sql_txt.split(";") if query.strip()]

spark = spark_connect()
for query in queries:
    print(f"Query:{query} \n")
    spark.sql(query)
