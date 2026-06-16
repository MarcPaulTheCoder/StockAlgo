from datetime import datetime
from airflow import DAG
from airflow.providers.cncf.kubernetes.operators.spark_kubernetes import (
    SparkKubernetesOperator,
)

with DAG(
    dag_id="stockalgo_apply_ddl",
    start_date=datetime(2026, 4, 20),
    schedule=None,
    catchup=False,
) as dag:
    apply_ddl = SparkKubernetesOperator(
        task_id="stockalgo_apply_ddl",
        namespace="default",
        application_file="spark/stockalgo-apply-ddl.yaml",
        kubernetes_conn_id="kubernetes_default",
        do_xcom_push=False,
    )
