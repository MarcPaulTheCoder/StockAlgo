from pyspark.sql import Window, functions as F, DataFrame


def validate_col_helper(
    spark_df: DataFrame,
    target_col_name: str,
    target_col_absolute_min: float = 0,
    target_col_threshold: float = 0.5,
) -> DataFrame:
    window = Window.partitionBy("symbol").orderBy(F.col("time_stamp").asc())
    cols = spark_df.columns

    near_lag = F.try_divide(
        (F.abs(F.col(target_col_name) - F.col(f"lag_{target_col_name}"))),
        F.col(f"lag_{target_col_name}"),
    ) <= F.lit(target_col_threshold)
    near_lead = F.try_divide(
        (F.abs(F.col(target_col_name) - F.col(f"lead_{target_col_name}"))),
        F.col(f"lead_{target_col_name}"),
    ) <= F.lit(target_col_threshold)

    lead_lag_df = spark_df.withColumns(
        {
            f"valid_{target_col_name}": F.when(
                (F.col(target_col_name) > F.lit(target_col_absolute_min))
                & (F.col(target_col_name).isNotNull()),
                F.lit(1),
            ).otherwise(F.lit(0)),
            f"lag_{target_col_name}": F.lag(F.col(target_col_name)).over(window),
            f"lead_{target_col_name}": F.lead(F.col(target_col_name)).over(window),
        }
    )

    validated_df = lead_lag_df.withColumns(
        {
            f"valid_{target_col_name}": F.when(
                (F.col(f"lag_{target_col_name}").isNull())
                | (F.col(f"lead_{target_col_name}").isNull()),
                F.col(f"valid_{target_col_name}"),
            )
            .when(
                (F.col(f"valid_{target_col_name}") == 1) & (near_lag | near_lead),
                F.lit(1),
            )
            .otherwise(F.lit(0))
        }
    )

    is_valid_df = validated_df.select(*cols, F.col(f"valid_{target_col_name}"))
    return is_valid_df


def validate_bars(spark_df: DataFrame) -> DataFrame:
    """
    A value is_valid only when they're not Null, greater than target_col_absolute_min (default 0),
    close/low/high are within 50% deviation between the previous value OR next value
    low/high must be the lowest/greatest value in the row
    first/last values skip the previous/next value check since there's no previous/next value for first/last values
    they're partitioned based on symbol, ordered by time_stamp
    volume only needs to be a positive number (null is invalid)

    open isn't validated, it isn't used and the low/high checks invalidate any bad open values.
    """
    sparkdf = spark_df.withColumnRenamed("timestamp", "time_stamp")

    for col in ["close", "low", "high"]:
        sparkdf = validate_col_helper(
            spark_df=sparkdf,
            target_col_name=col,
            target_col_absolute_min=0,
            target_col_threshold=0.5,
        )

    sparkdf = sparkdf.withColumns(
        {
            "valid_volume": F.when(
                (F.col("volume") > F.lit(0)) & (F.col("volume").isNotNull()), F.lit(1)
            ).otherwise(F.lit(0)),
            "valid_low": F.when(
                (F.col("valid_low") == 1)
                & (
                    F.least(F.col("low"), F.col("high"), F.col("open"), F.col("close"))
                    == F.col("low")
                ),
                1,
            ).otherwise(F.lit(0)),
            "valid_high": F.when(
                (F.col("valid_high") == 1)
                & (
                    F.greatest(
                        F.col("low"), F.col("high"), F.col("open"), F.col("close")
                    )
                    == F.col("high")
                ),
                1,
            ).otherwise(F.lit(0)),
        }
    )

    sparkdf = sparkdf.withColumn(
        "is_valid",
        F.when(
            (F.col("valid_volume") == 1)
            & (F.col("valid_close") == 1)
            & (F.col("valid_low") == 1)
            & (F.col("valid_high") == 1),
            1,
        )
        .otherwise(F.lit(0))
        .cast("boolean"),
    )

    sparkdf = sparkdf.select(
        "symbol",
        "time_stamp",
        "open",
        "low",
        "close",
        "high",
        "volume",
        "trade_count",
        "vwap",
        "is_valid",
    )
    return sparkdf
