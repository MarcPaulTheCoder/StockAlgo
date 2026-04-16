from datetime import datetime
import time
import pandas as pd
from DatabaseLogic.AlphaVantage import GetData
import AwsSecrets
import DatabaseLogic.DatabaseFunc.InsertData as InsertData
from DatabaseLogic.FormatData import FormatData
import asyncio
import multiprocessing
import os



async def main():
    profile_name = os.environ.get('Aws_Profile')
    alphaVantage_Secret = os.environ.get('Aws_AV_Secret')
    aws_db_acc = os.environ.get('Aws_Db_Secret')
    aws_region = os.environ.get('Aws_Region')



    insertDataObj = InsertData.insertData(profile_name, aws_db_acc, aws_region)
    aws_acc = AwsSecrets.AwsSecrets(profile_name, alphaVantage_Secret, aws_region)
    apiKey = aws_acc.secretDict['API_Key']

    poolsize = 25

    tickers = insertDataObj.getStockSymbols()
    #tickers = pd.DataFrame.from_dict({"Symbol": ["CCZ"], "LastStockDate": ["2025-05-09 01:00"]})

    newsTickers = insertDataObj.getNewsTickerList()
    compOverviewSymbols = insertDataObj.getCompanyOverviewSymbols()

    manager = multiprocessing.Manager()

    retrivalDate = datetime.now().strftime("%Y-%m")
    previousDate = None # "2025-05"
    getalphadata = GetData.AlphaVantage('', '1min', 'close', apiKey, retrivalDate)

    tickerLen = len(tickers.index) // poolsize
    newsTickerLen = len(newsTickers) // poolsize

    ## UPDATE Stocks to get new ones and next Report Date ###
    #pcr = getalphadata.getListingEarningsCalData(symbol=None)
    #pcr = getalphadata.getListingStatusData()
    #insertDataObj.insertTickersToRawTable(pcr)

    #await asyncGetQuarterlyData(getalphadata, tickers, insertDataObj, manager, poolsize)
    #await asyncCompanyData(getalphadata, compOverviewSymbols, poolsize, insertDataObj, manager)
    #await asyncGetFinancialData(tickers, tickerLen, getalphadata, manager, poolsize, insertDataObj, previousDate)
    #await asyncGetNews(newsTickers, newsTickerLen, getalphadata, manager, poolsize, insertDataObj)

    tasks = [asyncGetNews(newsTickers, newsTickerLen, getalphadata, manager, poolsize, insertDataObj),
              asyncGetFinancialData(tickers, tickerLen, getalphadata, manager, poolsize, insertDataObj, previousDate)]

    await asyncio.gather(*tasks)

    ## Update Stocks ## --> Should create event to run CreateStocks
    #data = getalphadata.getCombinedStockData()
    #insertDataObj.insertTickersToRawTable(data)


async def asyncGetFinancialData( tickers, dfLen, av, manager, poolSize, insertDataObj, previousDate):
    mpFinDataQueue = manager.Queue()

    FinNoDataList = manager.list()
    FintickerList = manager.list()
    NoDataTicker = 0
    tickercount = 0

    with multiprocessing.Pool(poolSize) as pool:
        res = pool.starmap_async(av.getAllDataInDf,
                             [[(tickers.loc[i], mpFinDataQueue, FinNoDataList, FintickerList, previousDate)] for i in tickers.index],
                             chunksize=dfLen)
        while not res.ready():
            if not mpFinDataQueue.empty():
                tickercount, NoDataTicker = asyncInsertFinData(mpFinDataQueue, FinNoDataList,tickercount,NoDataTicker, insertDataObj)
            await asyncio.sleep(.05)

        if res.successful():
            while not mpFinDataQueue.empty():
                tickercount, NoDataTicker = asyncInsertFinData(mpFinDataQueue, FinNoDataList,tickercount, NoDataTicker,insertDataObj)
                await asyncio.sleep(.05)
            print(f"All Financial Data Inserted Successfully, Total Ticker Count: {tickercount}")

def asyncInsertFinData(mpDataQueue, NoDataList, tickercounter, NoDataTicker, insertDataObj):

    formatGenerator = FormatData.formatData.createSingleDFFromQueue(mpDataQueue)

    while not mpDataQueue.empty():
        try:
            dfFinalData, insertTickers = next(formatGenerator)
        except StopIteration:
            break

        if dfFinalData is not None:
            if not dfFinalData.empty:
                insertDataObj.insertDataToRawTable(dfFinalData)
                insertDataObj.insertToStockQueue(insertTickers)
                lisLen = len(insertTickers)
                tickercounter = tickercounter + lisLen
                print(f"Time: {time.strftime("%H:%M:%S", time.localtime())}, Total Financial Data Inserted: {tickercounter}, Tickers Inserted {lisLen}: {insertTickers}")

    if NoDataList:
        insertDataObj.insertNoDataFromAPI(NoDataList)
        NoDataListLen = len(NoDataList)
        NoDataTicker = NoDataTicker + NoDataListLen
        print(f"Time: {time.strftime("%H:%M:%S", time.localtime())}, Total: {NoDataTicker}, NO FINANCIAL DATA: {NoDataList}")
        del NoDataList[0:NoDataListLen]

    return tickercounter, NoDataTicker

async def asyncGetNews(tickers, tickerLen, av, manager, poolSize, insertDataObj):
    mpDataQueue = manager.Queue()
    tickerList = manager.list()
    counter = 0

    with multiprocessing.Pool(poolSize) as pool:
        res = pool.starmap_async(av.getCompanyNews,
                             [[(tickers.loc[i], mpDataQueue, tickerList)] for i in tickers.index],
                             chunksize=tickerLen)
        while not res.ready():
            if not mpDataQueue.empty():
                tickersent, data = mpDataQueue.get()
                if not data.empty:
                    insertDataObj.insertNewsToRawTable(data)
                    insertDataObj.updateLastNewsRetriaval([tickersent])
                    counter += 1
                    tickerList.remove(tickersent)
                    print(f"News Inserted {tickersent}: Time: {time.strftime("%H:%M:%S", time.localtime())}: Total Inserted: {counter}")
                await asyncio.sleep(.1)
            else:
                await asyncio.sleep(.01)


        if res.successful():
            while not mpDataQueue.empty():
                tickersent, data = mpDataQueue.get()
                if not data.empty:
                    print(mpDataQueue.qsize())
                    insertDataObj.insertNewsToRawTable(data)
                    insertDataObj.updateLastNewsRetriaval([tickersent])
                    counter += 1
                    tickerList.remove(tickersent)
                    print(
                        f"News Inserted {tickersent}: Time: {time.strftime("%H:%M:%S", time.localtime())}: Total Inserted: {counter}")
                await asyncio.sleep(.01)
            else:
                print("News Inserted Successfully")

async def asyncGetQuarterlyData(av, tickers, insertDataObj, manager, poolSize):
    mpDataQueue = manager.Queue()
    NoDataList = manager.list()
    tickerList = manager.list()

    dfLen = len(tickers.index)
    dfLen = dfLen // poolSize

    with multiprocessing.Pool(poolSize) as pool:
        res = pool.starmap_async(av.getQuarterlyData,
                             [[(tickers.loc[i], mpDataQueue, NoDataList, tickerList)] for i in tickers.index],
                             chunksize=dfLen)

        while not res.ready():
            quart_bs_data,quart_inc_data, quart_cash_data, quart_earn_data = mpDataQueue.get()
            insertDataObj.insertBalanceSheetToRawTable(quart_bs_data)
            insertDataObj.insertEarningToRawTable(quart_earn_data)
            insertDataObj.insertCashFlowToRawTable(quart_cash_data)
            insertDataObj.insertIncomeStatementToRawTable(quart_inc_data)
            await asyncio.sleep(.1)

        if res.successful():
            while not mpDataQueue.empty():
                quart_bs_data,quart_inc_data, quart_cash_data, quart_earn_data = mpDataQueue.get()
                insertDataObj.insertBalanceSheetToRawTable(quart_bs_data)
                insertDataObj.insertEarningToRawTable(quart_earn_data)
                insertDataObj.insertCashFlowToRawTable(quart_cash_data)
                insertDataObj.insertIncomeStatementToRawTable(quart_inc_data)
                await asyncio.sleep(.1)
            print(f"All Data Inserted Successfully")

async def asyncCompanyData(av, tickerList, poolsize, insertDataObj, manager):

    tickers = tickerList['Symbol']
    tickerlen = len(tickers) // poolsize

    mpDataQueue = manager.Queue()
    dfLen = tickerlen // poolsize

    counter = 0

    print(f"Starting: {time.strftime("%H:%M:%S", time.localtime())}")
    with multiprocessing.Pool(processes=poolsize) as pool:
        comp = pool.map_async(av.getCompanyOverviewData, [[tickers.loc[i], mpDataQueue] for i in tickers.index], chunksize=dfLen)

        while not comp.ready():
            if not mpDataQueue.empty():
                dfFinalData = mpDataQueue.get()
                # dfFinalData, insertTickers = FormatData.formatData.createSingleDFFromQueue(mpDataQueue)
                if dfFinalData is not None:
                    if not dfFinalData.empty:
                        insertDataObj.insertCompanyOverview(dfFinalData)
                        # listLen = len(insertTickers)
                        # counter = counter + listLen
                        print(f"Time: {time.strftime("%H:%M:%S", time.localtime())}") # , Total Inserted: {counter}, Company Overview Finished {insertTickers}")
            await asyncio.sleep(.1)

    if comp.successful():
        while not mpDataQueue.empty():
            dfFinalData = mpDataQueue.get()
            # dfFinalData, insertTickers = FormatData.formatData.createSingleDFFromQueue(mpDataQueue)
            if dfFinalData is not None:
                if not dfFinalData.empty:
                    insertDataObj.insertCompanyOverview(dfFinalData)
                    # listLen = len(insertTickers)
                    # counter = counter + listLen
                    print(f"Time: {time.strftime("%H:%M:%S", time.localtime())}") # , Total Inserted: {counter}, Company Overview Finished {insertTickers}")
                await asyncio.sleep(.1)
        print(f"Time: {time.strftime("%H:%M:%S", time.localtime())}") #, Company Overview Finished, Total Inserted: {counter}")


if __name__ == "__main__":
    asyncio.run(main())
