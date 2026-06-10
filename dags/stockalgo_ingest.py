from datetime import datetime, timedelta
from airflow import DAG
from airflow.providers.cncf.kubernetes.operators.spark_kubernetes import (
    SparkKubernetesOperator,
)

default_args = {
    "retries": 3,
    "retry_delay": timedelta(minutes=5),
    "retry_exponential_backoff": True,
}

with DAG(
    dag_id="stockalgo",
    start_date=datetime(2026, 4, 20),
    schedule="0 22 * * 1-5",
    catchup=False,
    default_args=default_args,
) as dag:
    ingest = SparkKubernetesOperator(
        task_id="run_alpaca_ingest",
        namespace="default",
        application_file="spark/stockalgo-ingest.yaml",
        kubernetes_conn_id="kubernetes_default",
        do_xcom_push=False,
    )
    indicator = SparkKubernetesOperator(
        task_id="run_alpaca_indicators",
        namespace="default",
        application_file="spark/stockalgo-indicators.yaml",
        kubernetes_conn_id="kubernetes_default",
        do_xcom_push=False,
    )
    ingest >> indicator
