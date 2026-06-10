import argparse
import logging
from stockalgo.connections import spark_connect, alpaca_historical_data_connect
from stockalgo.ingest import clean_and_insert_rawbars
from stockalgo.indicators import call_indicators


def main():
    spark = spark_connect()
    parser = argparse.ArgumentParser()
    logging.basicConfig(
        level=logging.INFO, format="%(asctime)s %(name)s %(levelname)s %(message)s"
    )

    parser.add_argument(
        "action",
        choices=["ingest", "compute_indicators"],
    )
    parser.add_argument("start_year", type=int, nargs="?", default=2026)
    parser.add_argument("start_month", type=int, nargs="?", default=1)
    parser.add_argument("start_day", type=int, nargs="?", default=1)
    args = parser.parse_args()

    if args.action == "ingest":
        sym_client = alpaca_historical_data_connect()
        clean_and_insert_rawbars(
            sym_client, spark, args.start_year, args.start_month, args.start_day
        )
    if args.action == "compute_indicators":
        call_indicators(spark)


if __name__ == "__main__":
    main()
