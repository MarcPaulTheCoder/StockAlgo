from stockalgo.validate_bars import validate_bars
import pytest


def create_test_data(rows, spark):
    test_data = spark.createDataFrame(
        rows,
        [
            "symbol",
            "timestamp",
            "open",
            "high",
            "low",
            "close",
            "volume",
            "trade_count",
            "vwap",
        ],
    )
    return test_data


rows_test1 = [
    ("SPY", 1, 10.0, 10.5, 9.5, 10.0, 1000, 1000, 1),
    ("SPY", 2, 10.2, 10.7, 9.7, 10.2, 1000, 1000, 1),
    ("SPY", 3, 9999.0, 9999.5, 9998.5, 9999.0, 1000, 1000, 1),
    ("SPY", 4, 10.4, 10.9, 9.9, 10.4, 1000, 1000, 1),
    ("SPY", 5, 10.6, 11.1, 10.1, 10.6, 1000, 1000, 1),
]

rows_test2 = [
    ("SOLO", 1, 10.0, 10.5, 9.5, 10.0, 1000, 1000, 1),
    ("ZVOL", 1, 10.0, 10.5, 9.5, 10.0, 0, 1000, 1),
    ("ZCLS", 1, 10.0, 10.5, 9.5, 0.0, 1000, 1000, 1),
    ("BADL", 1, 10.0, 10.5, 9.9, 9.5, 1000, 1000, 1),
    ("NCLS", 1, 10.0, 10.5, 9.5, None, 1000, 1000, 1),
]

rows_test3 = [
    ("AAA", 1, 10.0, 10.5, 9.5, 10.0, 1000, 1000, 1),
    ("AAA", 2, 40.0, 40.5, 39.5, 40.0, 1000, 1000, 1),
    ("BBB", 1, 50000.0, 50000.5, 49999.5, 50000.0, 1000, 1000, 1),
    ("BBB", 2, 50100.0, 50100.5, 50099.5, 50100.0, 1000, 1000, 1),
]

first_row_results = [
    ("SPY", 1, True),
    ("SPY", 2, True),
    ("SPY", 3, False),
    ("SPY", 4, True),
    ("SPY", 5, True),
]
second_row_results = [
    ("SOLO", 1, True),
    ("ZVOL", 1, False),
    ("ZCLS", 1, False),
    ("BADL", 1, False),
    ("NCLS", 1, False),
]
third_row_results = [
    ("AAA", 1, True),
    ("AAA", 2, True),
    ("BBB", 1, True),
    ("BBB", 2, True),
]


@pytest.mark.parametrize(
    "test_data, row_results",
    [
        (rows_test1, first_row_results),
        (rows_test2, second_row_results),
        (rows_test3, third_row_results),
    ],
)
def test_validate_bars(spark, test_data, row_results):
    test_data = create_test_data(test_data, spark)
    results = validate_bars(test_data)
    flags = {(r["symbol"], r["time_stamp"]): r["is_valid"] for r in results.collect()}
    for row in row_results:
        assert flags[(row[0], row[1])] == row[2]
