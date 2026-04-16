import pymysql.cursors
from AwsSecrets import AwsSecrets
from sqlalchemy import create_engine, URL
from sqlalchemy.orm import sessionmaker, scoped_session
import pandas as pd
from contextlib import contextmanager



class MysqlDBConnection(AwsSecrets):
    def __init__(self, profileName, secretsName, regionName):
        super().__init__(profileName, secretsName, regionName)
        self.token = self.getdbToken()
        self.engine = self.getEngine()
        self.sessionMaker = sessionmaker(bind=self.engine)


    @contextmanager
    def session_scope(self):
        Session = scoped_session(self.sessionMaker)
        session = Session()
        try:
            yield session
            session.commit()
        except Exception as e:
            session.rollback()
            raise e
        finally:
            Session.remove()


    def getEngine(self):
        url_create  = URL.create(
            drivername='mysql+pymysql',
            host=self.secretDict['host'],
            port=self.secretDict['port'],
            database='stocks',
            username=self.secretDict['username'],
            password=self.token
        )

        ssl_args = {'ca':self.certpath, 'verify_identity':True,'ssl_verify_cert':True}

        engine = create_engine(url_create, connect_args={'ssl': ssl_args, 'auth_plugin_map': {'mysql_clear_password': None,}})
        return engine


    def getConnection(self):
        connection = pymysql.connect(user=self.secretDict['username'],
                                          auth_plugin_map={'mysql_clear_password': None},
                                          host=self.secretDict['host'],
                                          password=self.token,
                                          database='stocks',
                                          ssl_ca=self.certpath,
                                          ssl_verify_identity=True,
                                          ssl_verify_cert=True)
        return connection


    def testConnection(self):
        try:
            conn = self.connection
            cur = conn.cursor()
            cur.execute("""SELECT now()""")
            query_results = cur.fetchall()
            print(query_results)
        except Exception as e:
            print("Database connection failed due to {}".format(e))

    def testEngine(self):
        try:
            self.getEngine()
            engine = self.engine
            sql = "SELECT * FROM rawfinancialdata;"
            df = pd.read_sql(sql, engine)
            print(
                f"{engine}, Connection to the {self.secretDict['host']} for user {self.secretDict['username']} created successfully.")
        except Exception as ex:
            print("Connection could not be made due to the following error: \n", ex)

