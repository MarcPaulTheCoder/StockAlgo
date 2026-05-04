# StockAlgo

A Python-based stock market data pipeline that pulls financial data from the Alpha Vantage API, processes it through a normalized MySQL database on AWS RDS, computes technical indicators via stored procedures, and surfaces the results through presentation views consumed by a Power BI dashboard.

**Scale:** 325M+ rows in the core financial data table. 1.6B+ rows across all tables (each indicator table holds ~280M rows). 52 tables/views with hash partitioning (100 partitions) on the primary data table. 25-worker concurrent ingestion pool.

## Architecture

```
Alpha Vantage API (13 endpoints)
       |
       v
  main.py (Python, asyncio + multiprocessing, 25 workers)
       |
       v
  AWS Secrets Manager (API keys, DB credentials via IAM auth)
       |
       v
  Raw staging tables (MySQL 8.0 on AWS RDS)
       |
       v
  Scheduled Events (8 events, 1-min intervals, GET_LOCK concurrency control)
       |
       v
  Stored Procedures (ETL + technical indicator calculations)
       |
       v
  Presentation Views (14 views)
       |
       v
  Power BI Dashboard
```

## What It Does

The application retrieves stock market data for a configurable list of tickers and loads it into a MySQL database hosted on AWS RDS. The Python layer handles API interaction and raw data ingestion, while the database layer handles all transformation, processing, and analysis through stored procedures and scheduled events.

**Data ingestion** runs through `main.py` using Python's `asyncio` and `multiprocessing` to pull data concurrently across a pool of 25 workers. It retrieves intraday financial data, quarterly reports (balance sheets, income statements, cash flow, earnings), company overviews, and news articles with sentiment scores.

**Data processing** happens entirely within the database. Eight scheduled events run on one-minute intervals, each using `GET_LOCK` to prevent overlapping executions. These events call stored procedures that transform raw API responses into normalized, queryable tables. The ETL pipeline moves data from raw staging tables (e.g., `rawfinancialdata`, `RawBalanceSheet`, `RawNews`) into their processed counterparts.

**Technical indicator analysis** is performed by stored procedures that compute Bollinger Bands (with width percentage and standard deviation breakouts), MACD (with signal line crossovers and trend direction), Chaikin Oscillator (with zero-line crossings), Directional Movement / ADX (with trend direction and trend changes), and Parabolic SAR (with slope calculations and trend reversals).

**Reporting** is handled by 14 presentation views that join processed tables with a curated stock list, filter to relevant date ranges, and provide a clean interface for Power BI to connect to directly.

## Project Structure

```
├── main.py                        # Entry point: async data ingestion
├── AwsSecrets.py                  # AWS Secrets Manager integration
├── requirements.txt               # Python dependencies
├── DatabaseLogic/
│   ├── AlphaVantage/
│   │   ├── AlphaVantageConn.py    # API client initialization
│   │   └── GetData.py             # Data retrieval methods (13 endpoints)
│   ├── DatabaseFunc/
│   │   ├── MySqlDBConnection.py   # MySQL connection via IAM auth + SSL
│   │   └── InsertData.py          # Raw data insertion (bulk, chunked)
│   └── FormatData/
│       └── FormatData.py          # DataFrame formatting for DB insert
├── priv_alpha_vantage/            # Forked alpha_vantage library (see below)
├── mysql_database/
│   ├── Demo_db_full_schema.sql    # Full schema (tables, views, procedures, events)
│   └── DemoDb_ERD.drawio          # Entity-relationship diagram (draw.io)
└── AllTickers.csv                 # Reference list of all ticker symbols
```

## Database

The database schema includes 35+ tables organized into three tiers:

- **Raw staging tables** hold unprocessed API responses (`rawfinancialdata`, `RawBalanceSheet`, `RawCashFlow`, `RawNews`, etc.)
- **Processed tables** contain normalized and deduplicated data (`FinancialData`, `BalanceSheet`, `NewsArticle`, etc.)
- **Technical indicator tables** store computed analysis results (`boilerband`, `macd`, `chaikinoscillator`, `directionalmovement`, `sar`)

The full schema, including all tables, primary keys, indexes, views, stored procedures, and scheduled events, is available in `mysql_database/Demo_db_full_schema.sql`. The ERD is in `mysql_database/DemoDb_ERD.drawio` (open with [draw.io](https://app.diagrams.net/)).

**Stored procedures** handle raw-to-processed ETL (e.g., `rawFinancialDataToFinancialData`, `RawNewsToNews`), technical indicator computation (e.g., `AnalyzeBoilerBand`, `AnalyzeMACD`, `CreateUpdateSarSlope`), trend detection and change tracking (e.g., `CreateUpdateADXTrendDirection`, `CreateUpdateMacdTrendChange`), and data maintenance (e.g., `CreateFinancialDataParentChild`, `UpdatePresentationStocks`).

**Scheduled events** manage the processing pipeline automatically, running `processRawTableLoop` across multiple threads, `RawNewsToNews`, `ProcessQuarterlyData`, `UpdateCompanyOverviews`, and `UpdatePresentationStocks`.

## Forked Alpha Vantage Library

The `priv_alpha_vantage/` directory contains a [forked version](https://github.com/MarcPaulTheCoder/priv_alpha_vantage) of the [alpha_vantage](https://github.com/RomelTorres/alpha_vantage) Python library. The fork adds `get_earnings_call_transcript()` and `get_insider_transactions()` endpoints, removes deprecated sector performance features, and bumps the version to 3.0.0 to reflect these changes.

## Tech Stack

Python 3, pandas, asyncio, multiprocessing, SQLAlchemy, PyMySQL, boto3, AWS RDS (MySQL 8.0), AWS Secrets Manager, Alpha Vantage API, Power BI.

## Environment Variables

| Variable | Description |
|---|---|
| `Aws_Profile` | AWS CLI profile name |
| `Aws_AV_Secret` | Secrets Manager secret name for Alpha Vantage API key |
| `Aws_Db_Secret` | Secrets Manager secret name for database credentials |
| `Aws_Region` | AWS region (e.g., `us-east-1`) |
| `Aws_SSL_Db_cert` | Path to the AWS RDS SSL certificate bundle (e.g., `us-east-1-bundle.pem`) |
