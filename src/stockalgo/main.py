import argparse
from datetime import datetime
from stockalgo.connections import spark_connect
from stockalgo.ingest import clean_and_insert_rawbars
from stockalgo.indicators import call_indicators
from stockalgo.apply_ddl import apply_ddl


def main() -> None:
    parser = argparse.ArgumentParser()
    subparser = parser.add_subparsers(dest="action", required=True)

    ingest_subparser = subparser.add_parser("ingest")
    compute_subparser = subparser.add_parser("compute_indicators")
    subparser.add_parser("apply_ddl")

    ingest_subparser.add_argument("airflow_run_id", type=str)
    ingest_subparser.add_argument("start_date", type=str)  # YYYY-MM-DD
    ingest_subparser.add_argument(
        "ingest_repartition_size", type=int, nargs="?", default=32
    )

    compute_subparser.add_argument(
        "airflow_run_id", type=str
    )  # Not yet implemented --> will be used for audit logs

    args = parser.parse_args()

    spark = spark_connect(f"stockalgo-{args.action}")

    if args.action == "ingest":
        clean_and_insert_rawbars(
            airflow_run_id=args.airflow_run_id,
            spark=spark,
            repartition_num=args.ingest_repartition_size,
            start_date=datetime.strptime(args.start_date, "%Y-%m-%d"),
        )
    elif args.action == "compute_indicators":
        call_indicators(spark=spark)

    elif args.action == "apply_ddl":
        apply_ddl(spark=spark, path="/mnt/data/ddl/stockTableCreation.sql")


if __name__ == "__main__":
    main()
