from stockalgo.apply_ddl import apply_ddl
from stockalgo.ingest import merge_raw_bars
from stockalgo.validate_bars import validate_bars
from datetime import datetime

rows = [
    ("SPY", datetime(2026, 1, 2), 10.0, 10.5, 9.5, 10.0, 1000, 10, 10, 0),
    ("SPY", datetime(2026, 1, 5), 10.2, 10.7, 9.7, 10.2, 1000, 10, 10, 0),
    ("SPY", datetime(2026, 1, 6), 10.4, 10.9, 9.9, 10.4, 1000, 10, 10, 0),
]

rows_changed = [
    ("SPY", datetime(2026, 1, 2), 10.0, 10.5, 9.5, 10.0, 1000, 10, 10, 0),
    ("SPY", datetime(2026, 1, 5), 10.2, 10.7, 9.7, 11.0, 1000, 10, 10, 0),
    ("SPY", datetime(2026, 1, 6), 10.4, 10.9, 9.9, 10.4, 1000, 10, 10, 0),
]
cols = [
    "symbol",
    "time_stamp",
    "open",
    "high",
    "low",
    "close",
    "volume",
    "vwap",
    "trade_count",
    "is_valid",
]


def test_merge_idempotent(spark):
    apply_ddl(spark, "ddl/stockTableCreation.sql")
    df = validate_bars(spark.createDataFrame(rows, cols))

    merge_raw_bars(spark, df)
    n1 = spark.table("stockalgo.market.raw_bars").count()

    merge_raw_bars(spark, df)
    assert spark.table("stockalgo.market.raw_bars").count() == n1 == 3

    df2 = validate_bars(spark.createDataFrame(rows_changed, cols))
    merge_raw_bars(spark, df2)
    assert spark.table("stockalgo.market.raw_bars").count() == 3
    row = (
        spark.table("stockalgo.market.raw_bars")
        .where("symbol = 'SPY' AND time_stamp = '2026-01-05'")
        .collect()[0]
    )
    assert row["close"] == 11.0
