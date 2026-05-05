
CREATE NAMESPACE IF NOT EXISTS stockalgo.market;
USE stockalgo.market;

-- Initial insert + Cleaning + is_valid flag table:
-- if is_valid = false --> data doesn't go into cleaned table
CREATE TABLE IF NOT EXISTS raw_bars (`symbol` string, `time_stamp` timestamp, `open` double, 
    `high` double, `low` double, `close` double, `volume` bigint, `vwap` double, `trade_count` bigint, 
    `is_valid` boolean) USING iceberg PARTITIONED BY (bucket(16,`symbol`));

-- Cleaned + Indicator table
CREATE TABLE IF NOT EXISTS stock_indicator_data (`symbol` string, `time_stamp` timestamp, `open` double, `high` double, 
    `low` double, `close` double, `volume` bigint,`vwap` double, `trade_count` bigint, `sma` double, `ema` double, `macd_line` double,
    `macd_signal` double, `macd_histogram` double, `rsi` double, `rs` double, `roc` double, `obv` double, `atr` double,
    `adx` double, `sar` double, `ep` double, `td` double, `af` double,
    `upper_bollinger_band` double, `middle_bollinger_band` double, `lower_bollinger_band` double,
    `dm_minus` double, `dm_plus` double, `smooth_dm_plus` double, `smooth_dm_minus` double, `adl` double, 
    `three_day_ema` double, `ten_day_ema` double,
    `dx` double, `chaikin_ad` double) USING iceberg PARTITIONED BY (bucket(16,`symbol`));

