from pyspark.sql.functions import col, lit
from pyspark.sql import Window, functions as func


def validate_bars(spark_df):
    sparkdf = spark_df.withColumnRenamed("timestamp", "time_stamp")
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
        "lag_volume",
        "lead_volume",
        "lag_high",
        "lead_high",
    )
    return sparkdf
