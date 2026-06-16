from pyspark.sql import SparkSession


def apply_ddl(spark: SparkSession, path: str) -> None:
    with open(path, "r") as f:
        sql_txt = f.readlines()

    lines = [line for line in sql_txt if not line.strip().startswith("--")]
    clean_sql_txt = "".join(lines)
    queries = [query for query in clean_sql_txt.split(";") if query.strip()]

    for query in queries:
        print(f"Query:{query} \n")
        spark.sql(query)
