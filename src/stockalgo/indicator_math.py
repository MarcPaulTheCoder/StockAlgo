import pandas as pd


def ema_math(
    pdf: pd.DataFrame,
    m_periods: int,
    ema_adjust: bool,
    ema_col_name: str,
    data_column: str,
    e_span: float | None = None,
    e_alpha: float | None = None,
    sort_values: bool = True,
) -> pd.DataFrame:
    if sort_values:
        pdf = pdf.sort_values("time_stamp")
    if e_alpha is None:
        ema = (
            pdf[data_column]
            .ewm(span=e_span, min_periods=m_periods, adjust=ema_adjust)
            .mean()
        )
    else:
        ema = (
            pdf[data_column]
            .ewm(alpha=e_alpha, min_periods=m_periods, adjust=ema_adjust)
            .mean()
        )
    return pdf.assign(**{ema_col_name: ema})


def avg_rolling_math(
    pdf: pd.DataFrame,
    avgrolling_col: str,
    data_column_name: str,
    rolling_periods: int,
    sort_values: bool = True,
) -> pd.DataFrame:
    if sort_values:
        pdf = pdf.sort_values("time_stamp")
    avgrolling = pdf[data_column_name].rolling(rolling_periods).mean()
    return pdf.assign(**{avgrolling_col: avgrolling})


# While Up trend --> If SAR > low (Extreme Point) --> Trendreversal (Trend flips to Down Trend) --> Old Extreme Point becomes Current SAR --> Extreme Point = low
# While Down trend --> If SAR < high (Extreme Point) --> Trendreversal (Trend flips to Up Trend) --> Old Extreme Point becomes Current SAR --> Extreme Point = high
# Acceleration Factor increases by 0.02 every SAR passes Extreme Point --> Max Acceleration Factor = 0.20
# SAR = Previous Periods SAR + Acceleration Factor * (Extreme Point (Local Max/Min) - Previous Periods SAR)
def sar_math(
    pdf: pd.DataFrame, sort_values: bool = True, seed_rows: int = 5
) -> pd.DataFrame:
    """
    computes parabolic sar per symbol per row and returns sar/ep/td/af into the pandas dataframe
    input MUST have sar/ep/td/af populated for any row position less than seed_rows (defaulted to 5)
    any row position less than seed_rows are "warm_up", calculation begins after the "warm_up"
    td = sign trend (>0 = up, <0 = down), ep = running extreme (local min/max), af = acceleration factor,
    af_step = increases af for every new local min/max (ep change), af_max = max value of af
    """
    if sort_values:
        pdf = pdf.sort_values("time_stamp")
        pdf = pdf.reset_index(drop=True)
    af_step = 0.02
    af_max = 0.20

    for i in range(seed_rows, len(pdf)):
        old_sar = pdf.at[(i - 1), "sar"]
        old_ep = pdf.at[(i - 1), "ep"]
        old_td = pdf.at[(i - 1), "td"]
        old_af = pdf.at[(i - 1), "af"]

        high = pdf.at[i, "high"]
        low = pdf.at[i, "low"]
        flip_flag = False

        sar = old_sar + old_af * (old_ep - old_sar)

        if (sar < high and old_td < 0) or (sar > low and old_td > 0):
            sar = old_ep
            td = old_td * -1
            af = af_step
            flip_flag = True
        else:
            td = old_td
        if td > 0 and old_ep < high:
            ep = high
            if not flip_flag:
                af = min(old_af + af_step, af_max)
        elif td < 0 and old_ep > low:
            ep = low
            if not flip_flag:
                af = min(old_af + af_step, af_max)
        else:
            ep = old_ep
            af = old_af

        pdf.at[i, "sar"] = sar
        pdf.at[i, "ep"] = ep
        pdf.at[i, "td"] = td
        pdf.at[i, "af"] = af
    return pdf


def do_applyInPandas(pd_df: pd.DataFrame, ema_period: int) -> pd.DataFrame:
    pdf = pd_df.sort_values("time_stamp").reset_index(drop=True)
    pdf = ema_math(
        pdf=pdf,
        m_periods=ema_period,
        ema_adjust=False,
        ema_col_name="ema",
        data_column="close",
        e_span=ema_period,
        sort_values=False,
    )
    pdf = ema_math(
        pdf=pdf,
        m_periods=12,
        e_span=12,
        ema_adjust=False,
        ema_col_name="macd_12",
        data_column="close",
        sort_values=False,
    )
    pdf = ema_math(
        pdf=pdf,
        m_periods=26,
        e_span=26,
        ema_adjust=False,
        ema_col_name="macd_26",
        data_column="close",
        sort_values=False,
    )
    pdf = ema_math(
        pdf=pdf,
        m_periods=3,
        e_span=3,
        ema_adjust=False,
        ema_col_name="three_day_ema",
        data_column="adl",
        sort_values=False,
    )
    pdf = ema_math(
        pdf=pdf,
        m_periods=10,
        e_span=10,
        ema_adjust=False,
        ema_col_name="ten_day_ema",
        data_column="adl",
        sort_values=False,
    )
    pdf = ema_math(
        pdf=pdf,
        m_periods=14,
        e_alpha=1 / 14,
        ema_adjust=False,
        ema_col_name="smooth_dm_plus",
        data_column="dm_plus",
        sort_values=False,
    )
    pdf = ema_math(
        pdf=pdf,
        m_periods=14,
        e_alpha=1 / 14,
        ema_adjust=False,
        ema_col_name="smooth_dm_minus",
        data_column="dm_minus",
        sort_values=False,
    )
    pdf = ema_math(
        pdf=pdf,
        ema_col_name="posrolling",
        data_column="pos_change",
        m_periods=14,
        e_alpha=1 / 14,
        ema_adjust=False,
        sort_values=False,
    )
    pdf = ema_math(
        pdf=pdf,
        ema_col_name="negrolling",
        data_column="neg_change",
        m_periods=14,
        e_alpha=1 / 14,
        ema_adjust=False,
        sort_values=False,
    )
    pdf = ema_math(
        pdf=pdf,
        ema_col_name="atr",
        data_column="true_range",
        m_periods=14,
        e_alpha=1 / 14,
        ema_adjust=False,
        sort_values=False,
    )
    pdf = sar_math(pdf=pdf, sort_values=False)
    pdf["macd_line"] = pdf["macd_12"] - pdf["macd_26"]
    pdf = ema_math(
        pdf=pdf,
        m_periods=9,
        e_span=9,
        ema_adjust=False,
        ema_col_name="signal_line",
        data_column="macd_line",
        sort_values=False,
    )
    pdf["dx"] = (
        (pdf["smooth_dm_plus"] - pdf["smooth_dm_minus"]).abs()
        / (pdf["smooth_dm_plus"] + pdf["smooth_dm_minus"]).abs()
    ) * 100
    pdf = ema_math(
        pdf=pdf,
        m_periods=14,
        e_alpha=1 / 14,
        ema_adjust=False,
        ema_col_name="adx",
        data_column="dx",
        sort_values=False,
    )
    pdf["histogram"] = pdf["macd_line"] - pdf["signal_line"]
    pdf["chaikin_ad"] = pdf["three_day_ema"] - pdf["ten_day_ema"]
    pdf["rs"] = pdf["posrolling"] / pdf["negrolling"]
    pdf["rsi"] = 100 - (100 / (1 + pdf["rs"]))
    return pdf
