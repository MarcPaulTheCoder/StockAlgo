# StockAlgo

A Python-based stock market data pipeline that pulls financial data from the Alpha Vantage API, processes it through a normalized MySQL database on AWS RDS, computes technical indicators via stored procedures, and surfaces the results through presentation views consumed by a Power BI dashboard.

## Architecture

```
Alpha Vantage API
       |
       v
  main.py (Python, async + multiprocessing)
       |
       v
  AWS Secrets Manager (API keys, DB credentials)
       |
       v
  Raw tables (MySQL on AWS RDS)
       |
       v
  Scheduled Events (raw-to-processed ETL)
       |
       v
  Stored Procedures (technical indicator calculations)
       |
       v
  Presentation Views
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
├── main.py                        # Entry point — async data ingestion
├── AwsSecrets.py                  # AWS Secrets Manager integration
├── requirements.txt               # Python dependencies
├── DatabaseLogic/
│   ├── AlphaVantage/
│   │   ├── AlphaVantageConn.py    # API client initialization
│   │   └── GetData.py             # Data retrieval methods
│   ├── DatabaseFunc/
│   │   ├── MySqlDBConnection.py   # MySQL connection via IAM auth
│   │   └── InsertData.py          # Raw data insertion logic
│   └── FormatData/
│       └── FormatData.py          # DataFrame formatting for DB insert
├── priv_alpha_vantage/            # Forked alpha_vantage library (see below)
├── mysql_database/
│   ├── Demo_db_full_schema.sql    # Full schema export (tables, views, procedures, events)
│   └── DemoDb_ERD.drawio          # Entity-relationship diagram (draw.io)
└── AllTickers.csv                 # Reference list of all ticker symbols
```

## Database

The database schema includes 35+ tables organized into three tiers: raw staging tables that hold unprocessed API responses, processed tables with normalized and deduplicated data, and technical indicator tables that store computed analysis results.

The full schema — including all tables, primary keys, indexes, views, stored procedures, and scheduled events — is available in `mysql_database/Demo_db_full_schema.sql`. The ERD is in `mysql_database/DemoDb_ERD.drawio` (open with [draw.io](https://app.diagrams.net/)).

**Stored procedures** handle raw-to-processed ETL (e.g., `rawFinancialDataToFinancialData`, `RawNewsToNews`), technical indicator computation (e.g., `AnalyzeBoilerBand`, `AnalyzeMACD`, `CreateUpdateSarSlope`), trend detection and change tracking (e.g., `CreateUpdateADXTrendDirection`, `CreateUpdateMacdTrendChange`), and data maintenance (e.g., `CreateFinancialDataParentChild`, `UpdatePresentationStocks`).

**Scheduled events** manage the processing pipeline automatically, running `processRawTableLoop` across multiple threads, `RawNewsToNews`, `ProcessQuarterlyData`, `UpdateCompanyOverviews`, and `UpdatePresentationStocks`.

## Forked Alpha Vantage Library

The `priv_alpha_vantage/` directory contains a [forked version](https://github.com/MarcPaulTheCoder/priv_alpha_vantage) of the [alpha_vantage](https://github.com/RomelTorres/alpha_vantage) Python library. The fork adds `get_earnings_call_transcript()` and `get_insider_transactions()` endpoints, removes deprecated sector performance features, and bumps the version to 3.0.0 to reflect these changes.

## Tech Stack

Python 3, pandas, asyncio, multiprocessing, SQLAlchemy, PyMySQL, boto3, AWS RDS (MySQL 8.0), AWS Secrets Manager, Alpha Vantage API, Power BI.

## Environment Variables

The application requires the following environment variables:

| Variable | Description |
|---|---|
| `Aws_Profile` | AWS CLI profile name |
| `Aws_AV_Secret` | Secrets Manager secret name for Alpha Vantage API key |
| `Aws_Db_Secret` | Secrets Manager secret name for database credentials |
| `Aws_Region` | AWS region (e.g., `us-east-1`) |
| `Aws_SSL_Db_cert` | Path to the AWS RDS SSL certificate bundle (e.g., `us-east-1-bundle.pem`) |
