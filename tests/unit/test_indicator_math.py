from stockalgo.indicator_math import ema_math, avg_rolling_math, sar_math
import pandas as pd
import pytest


test_data = {
    "close": [10.0, 11.0, 12.0, 13.0],
    "close_ema": [0, 0, 0, 0],
    "time_stamp": pd.to_datetime(
        ["2026-01-02", "2026-01-05", "2026-01-06", "2026-01-07"]
    ),
}
test_pdf = pd.DataFrame(test_data)
test_col_name = "close_test"
data_col = "close"

true_adjust_expected_results = [10.0, 10.666667, 11.428571, 12.266667]
false_adjust_expected_results = [10, 10.5, 11.25, 12.125]


two_roll_expected_results = [float("nan"), 10.5, 11.5, 12.5]
three_roll_expected_results = [float("nan"), float("nan"), 11.0, 12.0]
one_roll_expected_results = [10.0, 11.0, 12.0, 13.0]

sar_test_data = {
    "time_stamp": [1, 2, 3, 4, 5, 6, 7, 8],
    "high": [10.5, 11.5, 12.5, 12.8, 13.0, 13.5, 10.5, 9.5],
    "low": [9.5, 10.5, 11.5, 11.8, 12.0, 12.5, 9.0, 8.5],
    "sar": [0.0, 0.0, 0.0, 0.0, 10.0, 0.0, 0.0, 0.0],
    "ep": [0.0, 0.0, 0.0, 0.0, 13.0, 0.0, 0.0, 0.0],
    "td": [0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0],
    "af": [0.0, 0.0, 0.0, 0.0, 0.02, 0.0, 0.0, 0.0],
}
sar_test_pd = pd.DataFrame(sar_test_data)

sar_expected_results = [10.06, 13.5, 13.41]
ep_expected_results = [13.5, 9.0, 8.5]
td_expected_results = [1.0, -1.0, -1.0]
af_expected_results = [0.04, 0.02, 0.04]

sar_cap_data = {
    "time_stamp": list(range(1, 17)),
    "high": [
        10.5,
        11.0,
        11.5,
        12.0,
        13.0,
        14.0,
        15.0,
        16.0,
        17.0,
        18.0,
        19.0,
        20.0,
        21.0,
        22.0,
        23.0,
        24.0,
    ],
    "low": [
        9.5,
        10.0,
        10.5,
        11.0,
        12.0,
        13.0,
        14.0,
        15.0,
        16.0,
        17.0,
        18.0,
        19.0,
        20.0,
        21.0,
        22.0,
        23.0,
    ],
    "sar": [0.0] * 4 + [10.0] + [0.0] * 11,
    "ep": [0.0] * 4 + [13.0] + [0.0] * 11,
    "td": [0.0] * 4 + [1.0] + [0.0] * 11,
    "af": [0.0] * 4 + [0.02] + [0.0] * 11,
}

sar_cap_pd = pd.DataFrame(sar_cap_data)


def test_sar_af_cap():
    results = sar_math(pd.DataFrame(sar_cap_data))
    assert list(results["af"].iloc[13:]) == pytest.approx([0.2, 0.2, 0.2])
    assert results["af"].max() <= 0.2 + 1e-9


@pytest.mark.parametrize(
    "test_data,sar_expected_results,ep_expected_results,td_expected_results,af_expected_results",
    [
        (
            sar_test_pd,
            sar_expected_results,
            ep_expected_results,
            td_expected_results,
            af_expected_results,
        ),
    ],
)
def test_sar_math(
    test_data,
    sar_expected_results,
    ep_expected_results,
    td_expected_results,
    af_expected_results,
):
    results = sar_math(test_data)

    assert list(results["sar"].iloc[5:]) == pytest.approx(
        sar_expected_results, nan_ok=True
    )
    assert list(results["ep"].iloc[5:]) == pytest.approx(
        ep_expected_results, nan_ok=True
    )
    assert list(results["td"].iloc[5:]) == pytest.approx(
        td_expected_results, nan_ok=True
    )
    assert list(results["af"].iloc[5:]) == pytest.approx(
        af_expected_results, nan_ok=True
    )


@pytest.mark.parametrize(
    "test_pdf,avg_rolling_col_name,data_col,roll_periods,expected_results",
    [
        (test_pdf, test_col_name, data_col, 2, two_roll_expected_results),
        (test_pdf, test_col_name, data_col, 3, three_roll_expected_results),
        (test_pdf, test_col_name, data_col, 1, one_roll_expected_results),
    ],
)
def test_avg_rolling_math(
    test_pdf, avg_rolling_col_name, data_col, roll_periods, expected_results
):
    results = avg_rolling_math(
        pdf=test_pdf,
        avgrolling_col=avg_rolling_col_name,
        data_column_name=data_col,
        rolling_periods=roll_periods,
    )
    assert list(results[avg_rolling_col_name]) == pytest.approx(
        expected_results, nan_ok=True
    )


@pytest.mark.parametrize(
    "test_pdf,ema_col_name,data_col,ema_adjust,e_alpha,m_periods,e_span,expected_results",
    [
        (
            test_pdf,
            test_col_name,
            data_col,
            True,
            0.5,
            1,
            0,
            true_adjust_expected_results,
        ),
        (
            test_pdf,
            test_col_name,
            data_col,
            False,
            0.5,
            1,
            0,
            false_adjust_expected_results,
        ),
        (
            test_pdf,
            test_col_name,
            data_col,
            True,
            None,
            1,
            3,
            true_adjust_expected_results,
        ),
        (test_pdf, test_col_name, data_col, True, 0.5, 3, 0, "na"),
    ],
)
def test_ema_math(
    test_pdf,
    ema_col_name,
    data_col,
    expected_results,
    ema_adjust,
    e_span,
    e_alpha,
    m_periods,
):
    results = ema_math(
        pdf=test_pdf,
        m_periods=m_periods,
        ema_adjust=ema_adjust,
        e_span=e_span,
        ema_col_name=ema_col_name,
        data_column=data_col,
        e_alpha=e_alpha,
        sort_values=True,
    )
    if expected_results == "na":
        assert pd.isna(results[ema_col_name].iloc[0])
    else:
        assert list(results[ema_col_name]) == pytest.approx(expected_results)
