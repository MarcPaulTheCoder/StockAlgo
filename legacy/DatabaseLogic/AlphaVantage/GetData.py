from DatabaseLogic.AlphaVantage.AlphaVantageConn import AlphaVantage as av
import pandas as pd
from functools import reduce
from DatabaseLogic.FormatData import FormatData
import time
from datetime import datetime
import re


def handleIndicatorTimeouts(func):
    def wrapper(self, *args, **kwargs):
        data = pd.DataFrame()
        for n in range(20):
            try:
                data, meta_data = func(self, *args, **kwargs)
                for key, value in meta_data.items():
                    if re.search('symbol|Symbol', key):
                        symbolColumn = key
                        data['StockSymbol'] = meta_data[symbolColumn]
                        return data
                raise Exception(f"Function: {func.__name__}, Error: No Symbol found in Meta Data")
            except Exception as e:
                if str(e) == "Thank you for using Alpha Vantage! Please contact premium@alphavantage.co if you are targeting a higher API call volume.":
                    time.sleep(self.sleeptime)
                    continue
                elif str(e) == "Burst pattern detected. Please consider spreading out your API requests more evenly across a 1-minute window and query no more than 20 requests per second. Please contact support@alphavantage.co if you are targeting a higher API request volume.":
                    time.sleep(.1)
                    continue
                elif str(e) == "Minute-level rate limit exceed. Please stay under the number of API requests per minute for your premium subscription plan. Please contact support@alphavantage.co if you are targeting a higher API request volume.":
                    time.sleep(60)
                    continue
                elif str(e) == "Response ended prematurely":
                    continue
                elif str(e) == "Error getting data from the api, no return was given.":
                    break
                elif str(e) == "This API call returns NO data. Please check documentation":
                    break
                else:
                    print(f"Function: {func.__name__}, Ticker: {self.symbol}, RetrivalDate: {self.retrivalDate} raised an error: {str(e)}")
                    break
        return data
    return wrapper

class AlphaVantage(av):

    def __init__(self, symbol, interval, seriestype, apiKey, retrivalDate):
        super().__init__(symbol, interval, seriestype, apiKey, retrivalDate)
        self.wma_timeperiod = 20
        self.ema_timeperiod = 26
        self.bbands_timeperiod = 20
        self.RoC_timeperiod = 9
        self.adx_timeperiod = 14
        self.dx_timeperiod = 14
        self.plusMinusDx_timeperiod = 14
        self.sleeptime = 10

    def updateSymbol( self, symbol):
        self.symbol = symbol

    def updateFullOrCompact(self, fullOrCompact):
        self.fullOrCompact = fullOrCompact

    def updateRetrivalDate(self, retrivalDate):
        self.retrivalDate = retrivalDate

    def checkOutputSize(self, lastUpdateDate):
        difference = datetime.now() - lastUpdateDate
        minute_difference = difference.total_seconds() / 60
        if minute_difference < 100:
            self.updateFullOrCompact('compact')
        else:
            self.updateFullOrCompact('full')


    def getAllDataInDf(self, df):
        ticker = df[0]["Symbol"]
        lastStockDate = df[0]["LastStockDate"]

        dfout = df[1]
        NoDataList = df[2]
        tickerList = df[3]
        previousDate = df[4]
        self.updateSymbol(ticker)

        if previousDate is not None:
            self.updateRetrivalDate(previousDate)
            lastStockDate = None
        else:
            self.updateRetrivalDate(None)

            lastStockDt = datetime.strptime(lastStockDate, "%Y-%m-%d %H:%M")
            dfnow = datetime.now()

            differenceInDays = dfnow - lastStockDt
            differenceInDays = differenceInDays.days

            if differenceInDays < 30:
                self.checkOutputSize(lastStockDt)

        try:
            new_data = self.getCombinedData(lastStockDate)

            if previousDate is None:
                new_filtered_data = FormatData.formatData.getFilteredData(lastStockDate, new_data)
            else:
                new_filtered_data = new_data

            if not new_filtered_data.empty:
                dfout.put(new_filtered_data)
                tickerList.append(ticker)
                return f"{ticker}: Data Found"
            else:
                NoDataList.append(ticker)
                return f"{ticker}: No Data"
        except Exception as e:
            print(f"ticker: {ticker}, Error: {str(e)}")


    def getQuarterlyData(self,df):
        ticker = df[0]["Symbol"]
        dfout = df[1]
        tickerList = df[3]
        self.updateSymbol(ticker)

        for n in range(20):
            try:
                quart_bs_data = self.getQuarterlyBalanceSheetData()
                quart_inc_data = self.getQuarterlyIncomeStatementData()
                quart_cash_data = self.getQuarterlyCashFlowData()
                quart_earn_data = self.getQuarterlyEarningsData()

                if not isinstance(quart_bs_data, pd.DataFrame):
                    quart_bs_data = pd.DataFrame()
                if not isinstance(quart_inc_data, pd.DataFrame):
                    quart_inc_data = pd.DataFrame()
                if not isinstance(quart_cash_data, pd.DataFrame):
                    quart_cash_data = pd.DataFrame()
                if not isinstance(quart_earn_data, pd.DataFrame):
                    quart_earn_data = pd.DataFrame()

                dfs = [quart_bs_data, quart_inc_data, quart_cash_data, quart_earn_data]
                dfout.put(dfs)
                tickerList.append(ticker)
                return f"{ticker}: Data Found"

            except ValueError as e:
                if str(e) ==  "Thank you for using Alpha Vantage! Please contact premium@alphavantage.co if you are targeting a higher API call volume.":
                    time.sleep(self.sleeptime)
                    continue
                else:
                    return f"{ticker}: No Data"
        return f"{ticker}: No Data"

    @handleIndicatorTimeouts
    def getIntradayData(self):
        if self.retrivalDate is not None:
            data, meta_data = self.ts.get_intraday(symbol=self.symbol, interval=self.interval, outputsize=self.fullOrCompact, month=self.retrivalDate, entitlement='realtime')
        else:
            data, meta_data = self.ts.get_intraday(symbol=self.symbol, interval=self.interval,outputsize=self.fullOrCompact,entitlement='realtime')
        data.rename(columns={'1. open': 'openPrice', '2. high': 'highPrice', '3. low': 'lowPrice', '4. close': 'closePrice', '5. volume': 'volume' }, inplace=True)
        return data, meta_data

    @handleIndicatorTimeouts
    def getWMAData(self):
        if self.retrivalDate is not None:
            data, meta_data = self.ti.get_wma(symbol=self.symbol, interval=self.interval, time_period=self.wma_timeperiod, month=self.retrivalDate, series_type = self.series_type, entitlement='realtime')
        else:
            data, meta_data = self.ti.get_wma(symbol=self.symbol, interval=self.interval, time_period=self.wma_timeperiod, series_type=self.series_type, entitlement='realtime')
        data.rename(columns={ 'WMA' : 'wma'},inplace=True)
        return data, meta_data

    @handleIndicatorTimeouts
    def getEmaData(self):
        if self.retrivalDate is not None:
            data, meta_data = self.ti.get_ema(symbol=self.symbol, interval=self.interval, time_period=self.ema_timeperiod, month=self.retrivalDate, series_type = self.series_type, entitlement='realtime')
        else:
            data, meta_data = self.ti.get_ema(symbol=self.symbol, interval=self.interval, time_period=self.ema_timeperiod, series_type=self.series_type, entitlement='realtime')
        data.rename(columns={ 'EMA' : 'ema'}, inplace=True)
        return data, meta_data

    @handleIndicatorTimeouts
    def getMACDData(self):
        if self.retrivalDate is not None:
            data, meta_data = self.ti.get_macd(symbol=self.symbol, interval=self.interval, series_type = self.series_type, month=self.retrivalDate, entitlement='realtime')
        else:
            data, meta_data = self.ti.get_macd(symbol=self.symbol, interval=self.interval, series_type=self.series_type, entitlement='realtime')
        data.rename(columns={'MACD_Hist' : 'MACD_hist'}, inplace=True)
        return data, meta_data

    @handleIndicatorTimeouts
    def getBoilerData(self):
        if self.retrivalDate is not None:
            data, meta_data = self.ti.get_bbands(symbol=self.symbol, interval=self.interval,time_period=self.bbands_timeperiod, series_type = self.series_type, month=self.retrivalDate, entitlement='realtime')
        else:
            data, meta_data = self.ti.get_bbands(symbol=self.symbol, interval=self.interval, time_period=self.bbands_timeperiod, series_type=self.series_type, entitlement='realtime')
        data.rename(columns={'Real Upper Band': 'boiler_band_upper', 'Real Lower Band': 'boiler_band_lower', 'Real Middle Band': 'boiler_band_middle'}, inplace=True)
        return data, meta_data

    @handleIndicatorTimeouts
    def getVWAPData(self):
        if self.retrivalDate is not None:
            data, meta_data = self.ti.get_vwap(symbol=self.symbol, interval=self.interval, month=self.retrivalDate, entitlement='realtime')
        else:
            data, meta_data = self.ti.get_vwap(symbol=self.symbol, interval=self.interval, entitlement='realtime')
        return data, meta_data

    @handleIndicatorTimeouts
    def getRoCData(self):
        if self.retrivalDate is not None:
            data, meta_data = self.ti.get_roc(symbol=self.symbol, interval=self.interval, time_period=self.RoC_timeperiod, series_type = self.series_type, month=self.retrivalDate, entitlement='realtime')
        else:
            data, meta_data = self.ti.get_roc(symbol=self.symbol, interval=self.interval, time_period=self.RoC_timeperiod, series_type=self.series_type, entitlement='realtime')
        data.rename(columns={'ROC': 'RoC'}, inplace=True)
        return data, meta_data

    @handleIndicatorTimeouts
    def getOBVData(self):
        if self.retrivalDate is not None:
            data, meta_data = self.ti.get_obv(symbol=self.symbol, interval=self.interval, month=self.retrivalDate, entitlement='realtime')
        else:
            data, meta_data = self.ti.get_obv(symbol=self.symbol, interval=self.interval, entitlement='realtime')
        return data, meta_data

    @handleIndicatorTimeouts
    def getADData(self):
        if self.retrivalDate is not None:
            data, meta_data = self.ti.get_ad(symbol=self.symbol, interval=self.interval, month=self.retrivalDate, entitlement='realtime')
        else:
            data, meta_data = self.ti.get_ad(symbol=self.symbol, interval=self.interval, entitlement='realtime')
        data.rename(columns={'Chaikin A/D': 'AD'}, inplace=True)
        return data, meta_data

    @handleIndicatorTimeouts
    def getSARData(self):
        if self.retrivalDate is not None:
            data, meta_data = self.ti.get_sar(symbol=self.symbol, interval=self.interval, month=self.retrivalDate, entitlement='realtime')
        else:
            data, meta_data = self.ti.get_sar(symbol=self.symbol, interval=self.interval, entitlement='realtime')
        return data, meta_data

    @handleIndicatorTimeouts
    def getADXData(self):
        if self.retrivalDate is not None:
            data, meta_data = self.ti.get_adx(symbol=self.symbol, interval=self.interval, time_period=self.adx_timeperiod, month=self.retrivalDate, entitlement='realtime')
        else:
            data, meta_data = self.ti.get_adx(symbol=self.symbol, interval=self.interval, time_period=self.adx_timeperiod, entitlement='realtime')
        return data, meta_data

    @handleIndicatorTimeouts
    def getDXData(self):
        if self.retrivalDate is not None:
            data, meta_data = self.ti.get_dx(symbol=self.symbol, interval=self.interval, time_period=self.dx_timeperiod, month=self.retrivalDate, entitlement='realtime')
        else:
            data, meta_data = self.ti.get_dx(symbol=self.symbol, interval=self.interval, time_period=self.dx_timeperiod, entitlement='realtime')
        return data, meta_data

    @handleIndicatorTimeouts
    def getPDMIData(self):
        if self.retrivalDate is not None:
            data, meta_data = self.ti.get_plus_dm(symbol=self.symbol, interval=self.interval, time_period= self.plusMinusDx_timeperiod, month=self.retrivalDate, entitlement='realtime')
        else:
            data, meta_data = self.ti.get_plus_dm(symbol=self.symbol, interval=self.interval, time_period=self.plusMinusDx_timeperiod,entitlement='realtime')
        data.rename(columns={'PLUS_DM': 'PDMI'}, inplace=True)
        return data, meta_data

    @handleIndicatorTimeouts
    def getMDMIData(self):
        if self.retrivalDate is not None:
            data, meta_data = self.ti.get_minus_dm(symbol=self.symbol, interval= self.interval, time_period=self.plusMinusDx_timeperiod, month=self.retrivalDate, entitlement='realtime')
        else:
            data, meta_data = self.ti.get_minus_dm(symbol=self.symbol, interval=self.interval, time_period=self.plusMinusDx_timeperiod, entitlement='realtime')
        data.rename(columns={'MINUS_DM': 'MDMI'}, inplace=True)
        return data, meta_data

    def getListingStatusData(self):
        CSV_URL = 'https://www.alphavantage.co/query?function=LISTING_STATUS&apikey={}'.format(self.apiKey)
        pcr = pd.read_csv(CSV_URL, encoding='utf-8', header=0)
        pcr.drop(columns=['delistingDate','status', 'ipoDate'], inplace=True)
        pcr.rename(columns={'symbol' : 'Symbol', 'assetType' : 'AssetType', 'name' : 'CompanyName', 'exchange' : 'StockExchange'}, inplace=True)
        return pcr

    def getListingEarningsCalData(self, symbol=None, horizon='12month'):
        if symbol is None:
            CSV_URL = 'https://www.alphavantage.co/query?function=EARNINGS_CALENDAR&horizon={}&apikey={}'.format(horizon,self.apiKey)
        else:
            CSV_URL = 'https://www.alphavantage.co/query?function=EARNINGS_CALENDAR&symbol={}&horizon={}apikey={}'.format(symbol,horizon,self.apiKey)

        pcr = pd.read_csv(CSV_URL, encoding='utf-8', header=0)
        pcr.drop(columns=['estimate', 'currency'], inplace=True)
        pcr.rename(columns={'symbol' : 'Symbol', 'name' : 'CompanyName'}, inplace=True)
        #pcr = pcr[pcr['Symbol'] != pcr['CompanyName']]
        return pcr

    def getCompanyOverviewData(self, df):
        ticker = df[0]
        dfout = df[1]
        self.updateSymbol(ticker)
        for n in range(50):
            try:
                data, meta_data = self.fd.get_company_overview(symbol=self.symbol)
                if data is not None and not data.empty:
                    data.rename(columns={'Symbol': 'StockSymbol'},
                                inplace=True)
                    # data.to_csv(f"companyOverview{ticker}.csv", index=False)
                    dfout.put(data)
                    return f"{ticker}: Data Found"
                break
            except ValueError as e:
                if str(e) == 'Thank you for using Alpha Vantage! Please contact premium@alphavantage.co if you are targeting a higher API call volume.':
                    time.sleep(10)
                else:
                    return f"{ticker}: No Data Found"
        return f"{ticker}: No Data Found"

    def getCompanyNews(self, df):

        ticker = df[0]["Symbol"]
        date = df[0]["LastNewsRetrieval"]
        dfout = df[1]
        tickerList = df[2]
        self.updateSymbol(ticker)

        for n in range(20):
            try:
                if type(date) is None:
                    data, meta_data = self.ai.get_news_sentiment(tickers=self.symbol, limit=1000)
                else:
                    data, meta_data = self.ai.get_news_sentiment(tickers=self.symbol,time_from=date ,limit=1000)

                if data is not None and not data.empty:
                    data['time_published'] = pd.to_datetime(data['time_published'])

                    data['authors'] = [', '.join(map(str, l)) for l in data['authors']]
                    data['authors'] = data['authors'].str.replace(r'(^|\s)and ', r'\1 ', regex=True)

                    data_with_exploded_tickers = data.explode('ticker_sentiment')
                    all_data_exploded = data_with_exploded_tickers.explode('topics')

                    all_data_exploded.reset_index(drop=True, inplace=True)
                    all_data_exploded['NewsID'] = pd.RangeIndex(len(all_data_exploded))

                    topic_df  = pd.json_normalize(all_data_exploded['topics'])
                    topic_df.rename(columns={'relevance_score': 'topic_relevance_score'}, inplace=True)

                    stocks_df = pd.json_normalize(all_data_exploded['ticker_sentiment'])
                    stocks_df.rename(columns={'relevance_score': 'ticker_relevance_score'}, inplace=True)

                    all_data = pd.concat([all_data_exploded,topic_df, stocks_df], axis=1).replace('n/a', None)
                    all_data.drop(['NewsID','ticker_sentiment', 'topics'],inplace=True, axis=1)

                    tickerList.append(ticker)
                    dfout.put([ticker, all_data])
                    return f'{ticker}: Data Found'

            except ValueError as e:
                if str(e) == 'Thank you for using Alpha Vantage! Please contact premium@alphavantage.co if you are targeting a higher API call volume.':
                    time.sleep(self.sleeptime)
                else:
                    return f'{ticker}: Data Not Found'
        return None

    # @handleIndicatorTimeouts
    def getQuarterlyBalanceSheetData(self):
        data, meta_data = self.fd.get_balance_sheet_quarterly(symbol=self.symbol)
        data['StockSymbol'] = meta_data
        return data

    # @handleIndicatorTimeouts
    def getAnnualBalanceSheetData(self):
        data, meta_data = self.fd.get_balance_sheet_annual(symbol=self.symbol)
        data['StockSymbol'] = meta_data
        return data

    # @handleIndicatorTimeouts
    def getQuarterlyIncomeStatementData(self):
        data, meta_data = self.fd.get_income_statement_quarterly(symbol=self.symbol)
        data['StockSymbol'] = meta_data
        return data

    # @handleIndicatorTimeouts
    def getAnnualIncomeStatementData(self):
        data, meta_data = self.fd.get_income_statement_annual(symbol=self.symbol)
        data['StockSymbol'] = meta_data
        return data

    # @handleIndicatorTimeouts
    def getAnnualCashFlowData(self):
        data, meta_data = self.fd.get_cash_flow_annual(symbol=self.symbol)
        data['StockSymbol'] = meta_data
        return data

    # @handleIndicatorTimeouts
    def getQuarterlyCashFlowData(self):
        data, meta_data = self.fd.get_cash_flow_quarterly(symbol=self.symbol)
        data['StockSymbol'] = meta_data
        return data

    # @handleIndicatorTimeouts
    def getQuarterlyEarningsData(self):
        data, meta_data = self.fd.get_earnings_quarterly(symbol=self.symbol)
        data['StockSymbol'] = meta_data
        return data

    # @handleIndicatorTimeouts
    def getAnnualEarningsData(self):
        data, meta_data = self.fd.get_earnings_annual(symbol=self.symbol)
        data['StockSymbol'] = meta_data
        return data

    def getCombinedStockData(self):
        alltickers = self.getListingStatusData()
        allEarningDates = self.getListingEarningsCalData(symbol=None)

        dfs = [alltickers, allEarningDates]
        df_merged = reduce(lambda left, right: pd.merge(left, right, on=['Symbol', 'CompanyName'], how='outer'), dfs)
        return df_merged


    def getCombinedData(self, lastDateTime):
        intraday_data = self.getIntradayData()

        count = len(intraday_data)

        if lastDateTime is not None:
            target_date = pd.to_datetime(lastDateTime)
            if count > 0:
                count = len(intraday_data.loc[intraday_data.index > target_date])

        if count > 0:
            mdmi_data = self.getMDMIData()
            pdmi_data = self.getPDMIData()
            dx_data = self.getDXData()
            adx_data= self.getADXData()
            sar_data= self.getSARData()
            ad_data= self.getADData()
            obv_data= self.getOBVData()
            roc_data= self.getRoCData()
            vwap_data= self.getVWAPData()
            bband_data= self.getBoilerData()
            macd_data= self.getMACDData()
            ema_data= self.getEmaData()
            wma_data= self.getWMAData()

            data_frames = [mdmi_data, pdmi_data, dx_data, adx_data, sar_data, ad_data,obv_data,
                           roc_data, vwap_data, bband_data, macd_data, ema_data, wma_data, intraday_data]

            bad_data_frames = []
            for index, df in enumerate(data_frames):
                if df.empty or len(df) == 0:
                    bad_data_frames.append(index)
            for x in sorted(bad_data_frames, reverse=True):
                del data_frames[x]

            try:
                df_merged = reduce(lambda left, right: pd.merge(left, right, on=['date', 'StockSymbol'], how='outer'), data_frames)
                df_merged['dates'] = df_merged.index.date
                df_merged['times'] = df_merged.index.time
                df_merged['StockDateTime'] = pd.to_datetime(df_merged.index)
                return df_merged
            except Exception as e:
                print(f'ticker: {self.symbol}, Error: {e}')
                return pd.DataFrame()

        else:
            return pd.DataFrame()

