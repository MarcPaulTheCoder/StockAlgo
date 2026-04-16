from priv_alpha_vantage.alpha_vantage.techindicators import TechIndicators
from priv_alpha_vantage.alpha_vantage.timeseries import TimeSeries
from priv_alpha_vantage.alpha_vantage.fundamentaldata import FundamentalData
from priv_alpha_vantage.alpha_vantage.alphaintelligence import AlphaIntelligence



class AlphaVantage:
    def __init__(self, symbol, interval, seriestype, apiKey, retrivalDate):
        self.symbol = symbol
        self.interval = interval
        self.series_type = seriestype
        self.apiKey = apiKey
        self.retrivalDate = retrivalDate
        self.fullOrCompact = 'full'
        self.ts = TimeSeries(key=self.apiKey, output_format='pandas')
        self.ti = TechIndicators(key=self.apiKey, output_format='pandas')
        self.fd = FundamentalData(key=self.apiKey, output_format='pandas')
        self.ai = AlphaIntelligence(key=self.apiKey, output_format='pandas')