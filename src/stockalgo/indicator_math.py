def ema_math(pdf, m_periods, ema_adjust, e_span, ema_col_name, data_column, e_alpha):
    pdf = pdf.sort_values("time_stamp")
    if e_alpha == 0:
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


def avg_rolling_math(pdf, avgrolling_col, data_column_name, rolling_periods):

    pdf = pdf.sort_values("time_stamp")
    avgrolling = pdf[data_column_name].rolling(rolling_periods).mean()
    return pdf.assign(**{avgrolling_col: avgrolling})


# While Up trend --> If SAR > low (Extreme Point) --> Trendreversal (Trend flips to Down Trend) --> Old Extreme Point becomes Current SAR --> Extreme Point = low
# While Down trend --> If SAR < high (Extreme Point) --> Trendreversal (Trend flips to Up Trend) --> Old Extreme Point becomes Current SAR --> Extreme Point = high
# Acceleration Factor increases by 0.02 every SAR passes Extreme Point --> Max Acceleration Factor = 0.20
# SAR = Previous Periods SAR + Acceleration Factor * (Extreme Point (Local Max/Min) - Previous Periods SAR)
def sar_math(pdf):
    pdf = pdf.sort_values("time_stamp")
    pdf = pdf.reset_index(drop=True)

    for i in range(5, len(pdf)):
        oldsar = pdf.at[(i - 1), "sar"]
        oldep = pdf.at[(i - 1), "ep"]
        oldtd = pdf.at[(i - 1), "td"]
        oldaf = pdf.at[(i - 1), "af"]
        flipflag = 0

        sar = oldsar + oldaf * (oldep - oldsar)

        if sar < pdf.at[i, "high"] and oldtd < 0:
            sar = oldep
            td = oldtd * -1
            af = 0.02
            flipflag = 1

        elif sar > pdf.at[i, "low"] and oldtd > 0:
            sar = oldep
            td = oldtd * -1
            af = 0.02
            flipflag = 1

        else:
            td = oldtd

        if td > 0 and oldep < pdf.at[i, "high"]:
            ep = pdf.at[i, "high"]
            if oldaf < 0.19 and flipflag == 0:
                af = oldaf + 0.02
            else:
                if flipflag == 0:
                    af = oldaf
        elif td < 0 and oldep > pdf.at[i, "low"]:
            ep = pdf.at[i, "low"]
            if oldaf < 0.19 and flipflag == 0:
                af = oldaf + 0.02
            else:
                if flipflag == 0:
                    af = oldaf
        else:
            ep = oldep
            af = oldaf

        pdf.at[i, "sar"] = sar
        pdf.at[i, "ep"] = ep
        pdf.at[i, "td"] = td
        pdf.at[i, "af"] = af
    return pdf
