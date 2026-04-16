import pandas as pd

class formatData:

    @staticmethod
    def createSingleDFFromQueue(dfQueue):
        dfs = []
        tickerList = []
        while not dfQueue.empty():
            df = dfQueue.get(block=False)
            if not df.empty:
                if 'StockSymbol' in df.columns:
                    tickerList.append(df['StockSymbol'].iloc[0])
                else:
                    tickerList.append(df['ticker'].iloc[0])
                dfs.append(df)
            if len(tickerList) >= 75 and dfs:
                dfFinalData = pd.concat(dfs)
                yield dfFinalData, tickerList
                dfs = []
                tickerList = []
        else:
            if dfs:
                dfFinalData = pd.concat(dfs)
                yield dfFinalData, tickerList
            else:
                yield None, None


    @staticmethod
    def getFilteredData(UpdateDate, StockDatadf):
        if not StockDatadf.empty:
            if UpdateDate is not pd.NaT:
                filteredStockData = StockDatadf.loc[StockDatadf.index > UpdateDate]
            else:
                filteredStockData = StockDatadf
            return filteredStockData
        else:
            return StockDatadf
