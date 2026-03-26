
import pandas as pd
from sqlalchemy.exc import DBAPIError
from sqlalchemy import text

from DatabaseLogic.DatabaseFunc.MySqlDBConnection import MysqlDBConnection


class insertData(MysqlDBConnection):
    def __init__(self, profileName, secretsName, regionName):
        super().__init__(profileName, secretsName, regionName)


    def insertToStockQueue(self, symbolList):
        if symbolList:
            try:
                sqltext = text("INSERT IGNORE INTO rawFinancialDataQueue (Symbol, InsertedTime) VALUES (:Symbol, NOW());")
                symboldic = [{"Symbol" : sym} for sym in symbolList]

                with self.session_scope() as session:
                    cur = session.connection()
                    cur.execute(sqltext, symboldic)

            except Exception as e:
                print(f"Error insertToStockQueue: {e}")

    def insertNoDataFromAPI(self, symbolList):
        if symbolList:
            try:
                sqltext = text("UPDATE stock SET UpdatedDate = NOW() WHERE Symbol = :Symbol;")
                symboldic = [{"Symbol" : sym} for sym in symbolList]

                with self.session_scope() as session:
                    cur = session.connection()
                    cur.execute(sqltext, symboldic)

            except Exception as e:
                print(f"Error insertNoDataFromAPI: {e}")


    def insertDataToRawTable(self,df):
        with self.session_scope() as session:
            try:
                cur = session.connection()
                df.to_sql("rawfinancialdata", con=cur, if_exists='append', index=False, method='multi', chunksize = 200000)
            except DBAPIError as e:
                print(f'insertDataToRawTable: {str(e)}')

    def insertTickersToRawTable(self,df):
        with self.session_scope() as session:
            try:
                cur = session.connection()
                df.to_sql("rawStock", con=cur, if_exists='append', index=False, chunksize = 100000, method='multi')
            except DBAPIError as e:
                print(str(e))


    def insertNewsToRawTable(self,df):
        with self.session_scope() as session:
            try:
                cur = session.connection()
                df.to_sql("RawNews", con=cur, if_exists='append', index=False, method='multi', chunksize=100000)
            except Exception as e:
                print(str(e))

    def getStockSymbols(self):
        with self.session_scope() as session:
            try:
                cur = session.connection()
                query = text("""
                        SELECT s.Symbol, DATE_FORMAT(s.LastStockDate, "%Y-%m-%d %H:%i") AS LastStockDate
                        FROM stocks.stock s 
                        LEFT OUTER JOIN stocks.rawFinancialDataQueue rs 
                        ON s.Symbol = rs.Symbol WHERE rs.Symbol IS NULL 
                                                  # AND (s.NoData IS NULL OR s.NoData = 0) 
                        ORDER BY s.NoData ASC, s.UpdatedDate ASC, s.Symbol ASC;""")
                df_tickers = pd.read_sql(query, cur)
                df_tickers.replace({None: pd.NaT}, inplace=True)
                df_tickers.reset_index(drop=True, inplace=True)
                return df_tickers
            except Exception as e:
                print(f"getStockSymbols Error: {e}")

    def getNewsTickerList(self):
        with self.session_scope() as session:
            try:
                cur = session.connection()
                query = text("""
                SELECT Symbol, DATE_FORMAT(LastNewsRetrieval, "%Y%m%dT%H%i") AS LastNewsRetrieval FROM stock
                WHERE LastNewsRetrieval IS NOT NULL ORDER BY LastNewsRetrieval ASC, Symbol ASC;""")
                df_newstickers = pd.read_sql(query, cur)
                df_newstickers.reset_index(drop=True, inplace=True)
                return df_newstickers
            except Exception as e:
                print(f"getNewsTickerList Error: {e}")

    def updateLastNewsRetriaval(self, symbolList):

        sqltext = text("UPDATE stock SET LastNewsRetrieval = NOW() WHERE Symbol = :Symbol;")
        symboldic = [{"Symbol": sym} for sym in symbolList]

        with self.session_scope() as session:
            try:
                cur = session.connection()
                cur.execute(sqltext, symboldic)

            except Exception as e:
                print(f"Error insertNoDataFromAPI: {e}")

    def getCompanyOverviewSymbols(self):
        with self.session_scope() as session:
            try:
                cur = session.connection()
                query = text("""SELECT Symbol FROM stocks.stock ORDER BY UpdatedDate ASC;""")
                df_tickers = pd.read_sql(query, cur)
                df_tickers.replace({None: pd.NaT}, inplace=True)
                df_tickers.reset_index(drop=True, inplace=True)
                return df_tickers

            except Exception as e:
                print(f"Error: {e}")


    def insertCompanyOverview(self, df):
        with self.session_scope() as session:
            try:
                cur = session.connection()
                df.to_sql("rawCompanyOverview", con=cur, if_exists='append', index=False, method='multi', chunksize=100000)
            except Exception as e:
                print(str(e))

    def insertBalanceSheetToRawTable(self,df):
        with self.session_scope() as session:
            try:
                cur = session.connection()
                df.to_sql("RawBalanceSheet", con=cur, if_exists='append', index=False, method='multi')
            except Exception as e:
                print(str(e))

    def insertCashFlowToRawTable(self,df):
        with self.session_scope() as session:
            try:
                cur = session.connection()
                df.to_sql("RawCashFlow", con=cur, if_exists='append', index=False, method='multi')
            except Exception as e:
                print(str(e))

    def insertEarningToRawTable(self,df):
        with self.session_scope() as session:
            try:
                cur = session.connection()
                df.to_sql("RawEarning", con=cur, if_exists='append', index=False, method='multi')
            except Exception as e:
                print(str(e))

    def insertIncomeStatementToRawTable(self,df):
        with self.session_scope() as session:
            try:
                cur = session.connection()
                df.to_sql("RawIncomeStatement", con=cur, if_exists='append', index=False, method='multi')
            except Exception as e:
                print(str(e))