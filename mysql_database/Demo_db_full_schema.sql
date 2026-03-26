-- MySQL dump 10.13  Distrib 8.0.44, for macos15.4 (arm64)
--
-- Host:   Database: stocks
-- ------------------------------------------------------
-- Server version	8.0.39

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `BalanceSheet`
--

DROP TABLE IF EXISTS `BalanceSheet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `BalanceSheet` (
  `BalanceSheetID` int NOT NULL AUTO_INCREMENT,
  `StockID` int DEFAULT NULL,
  `FiscalDateEnding` datetime DEFAULT NULL,
  `ReportedCurrency` varchar(255) DEFAULT NULL,
  `TotalAssets` bigint DEFAULT NULL,
  `TotalCurrentAssets` bigint DEFAULT NULL,
  `CashAndCashEquivalentsAtCarryingValue` bigint DEFAULT NULL,
  `CashAndShortTermInvestments` bigint DEFAULT NULL,
  `Inventory` bigint DEFAULT NULL,
  `CurrentNetReceivables` bigint DEFAULT NULL,
  `TotalNonCurrentAssets` bigint DEFAULT NULL,
  `PropertyPlantEquipment` bigint DEFAULT NULL,
  `AccumulatedDepreciationAmortizationPPE` bigint DEFAULT NULL,
  `IntangibleAssets` bigint DEFAULT NULL,
  `IntangibleAssetsExcludingGoodwill` bigint DEFAULT NULL,
  `Goodwill` bigint DEFAULT NULL,
  `Investments` bigint DEFAULT NULL,
  `LongTermInvestments` bigint DEFAULT NULL,
  `ShortTermInvestments` bigint DEFAULT NULL,
  `OtherCurrentAssets` bigint DEFAULT NULL,
  `OtherNonCurrentAssets` bigint DEFAULT NULL,
  `TotalLiabilities` bigint DEFAULT NULL,
  `TotalCurrentLiabilities` bigint DEFAULT NULL,
  `CurrentAccountsPayable` bigint DEFAULT NULL,
  `DeferredRevenue` bigint DEFAULT NULL,
  `CurrentDebt` bigint DEFAULT NULL,
  `ShortTermDebt` bigint DEFAULT NULL,
  `TotalNonCurrentLiabilities` bigint DEFAULT NULL,
  `CapitalLeaseObligations` bigint DEFAULT NULL,
  `LongTermDebt` bigint DEFAULT NULL,
  `CurrentLongTermDebt` bigint DEFAULT NULL,
  `LongTermDebtNoncurrent` bigint DEFAULT NULL,
  `ShortLongTermDebtTotal` bigint DEFAULT NULL,
  `OtherCurrentLiabilities` bigint DEFAULT NULL,
  `OtherNonCurrentLiabilities` bigint DEFAULT NULL,
  `TotalShareholderEquity` bigint DEFAULT NULL,
  `TreasuryStock` bigint DEFAULT NULL,
  `RetainedEarnings` bigint DEFAULT NULL,
  `CommonStock` bigint DEFAULT NULL,
  `CommonStockSharesOutstanding` bigint DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`BalanceSheetID`)
) ENGINE=InnoDB AUTO_INCREMENT=555448 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `CashFlow`
--

DROP TABLE IF EXISTS `CashFlow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CashFlow` (
  `CashFlowID` int NOT NULL AUTO_INCREMENT,
  `StockID` int DEFAULT NULL,
  `FiscalDateEnding` datetime DEFAULT NULL,
  `ReportedCurrency` varchar(255) DEFAULT NULL,
  `OperatingCashflow` bigint DEFAULT NULL,
  `PaymentsForOperatingActivities` bigint DEFAULT NULL,
  `ProceedsFromOperatingActivities` bigint DEFAULT NULL,
  `ChangeInOperatingLiabilities` bigint DEFAULT NULL,
  `ChangeInOperatingAssets` bigint DEFAULT NULL,
  `DepreciationDepletionAndAmortization` bigint DEFAULT NULL,
  `CapitalExpenditures` bigint DEFAULT NULL,
  `ChangeInReceivables` bigint DEFAULT NULL,
  `ChangeInInventory` bigint DEFAULT NULL,
  `ProfitLoss` bigint DEFAULT NULL,
  `CashflowFromInvestment` bigint DEFAULT NULL,
  `CashflowFromFinancing` bigint DEFAULT NULL,
  `ProceedsFromRepaymentsOfShortTermDebt` bigint DEFAULT NULL,
  `PaymentsForRepurchaseOfCommonStock` bigint DEFAULT NULL,
  `PaymentsForRepurchaseOfEquity` bigint DEFAULT NULL,
  `PaymentsForRepurchaseOfPreferredStock` bigint DEFAULT NULL,
  `DividendPayout` bigint DEFAULT NULL,
  `DividendPayoutCommonStock` bigint DEFAULT NULL,
  `DividendPayoutPreferredStock` bigint DEFAULT NULL,
  `ProceedsFromIssuanceOfCommonStock` bigint DEFAULT NULL,
  `ProceedsFromIssuanceOfLongTermDebtAndCapitalSecuritiesNet` bigint DEFAULT NULL,
  `ProceedsFromIssuanceOfPreferredStock` bigint DEFAULT NULL,
  `ProceedsFromRepurchaseOfEquity` bigint DEFAULT NULL,
  `ProceedsFromSaleOfTreasuryStock` bigint DEFAULT NULL,
  `ChangeInCashAndCashEquivalents` bigint DEFAULT NULL,
  `ChangeInExchangeRate` bigint DEFAULT NULL,
  `NetIncome` bigint DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`CashFlowID`)
) ENGINE=InnoDB AUTO_INCREMENT=355947 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `CompanyOverview`
--

DROP TABLE IF EXISTS `CompanyOverview`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CompanyOverview` (
  `CompanyOverviewID` int NOT NULL AUTO_INCREMENT,
  `StockID` int DEFAULT NULL,
  `Symbol` varchar(255) DEFAULT NULL,
  `AssetType` varchar(255) DEFAULT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `Description` varchar(2000) DEFAULT NULL,
  `CIK` int DEFAULT NULL,
  `Exchange` varchar(255) DEFAULT NULL,
  `Currency` varchar(255) DEFAULT NULL,
  `Country` varchar(255) DEFAULT NULL,
  `Sector` varchar(255) DEFAULT NULL,
  `Industry` varchar(255) DEFAULT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `OfficialSite` varchar(255) DEFAULT NULL,
  `FiscalYearEnd` varchar(255) DEFAULT NULL,
  `LatestQuarter` datetime DEFAULT NULL,
  `MarketCapitalization` bigint DEFAULT NULL,
  `EBITDA` bigint DEFAULT NULL,
  `PERatio` decimal(20,5) DEFAULT NULL,
  `PEGRatio` decimal(20,5) DEFAULT NULL,
  `BookValue` decimal(20,5) DEFAULT NULL,
  `DividendPerShare` decimal(20,5) DEFAULT NULL,
  `DividendYield` decimal(20,5) DEFAULT NULL,
  `EPS` decimal(20,5) DEFAULT NULL,
  `RevenuePerShareTTM` decimal(20,5) DEFAULT NULL,
  `ProfitMargin` decimal(20,5) DEFAULT NULL,
  `OperatingMarginTTM` decimal(20,5) DEFAULT NULL,
  `ReturnOnAssetsTTM` decimal(20,5) DEFAULT NULL,
  `ReturnOnEquityTTM` decimal(20,5) DEFAULT NULL,
  `RevenueTTM` bigint DEFAULT NULL,
  `GrossProfitTTM` bigint DEFAULT NULL,
  `DilutedEPSTTM` decimal(20,5) DEFAULT NULL,
  `QuarterlyEarningsGrowthYOY` decimal(20,5) DEFAULT NULL,
  `QuarterlyRevenueGrowthYOY` decimal(20,5) DEFAULT NULL,
  `AnalystTargetPrice` decimal(20,5) DEFAULT NULL,
  `AnalystRatingStrongBuy` int DEFAULT NULL,
  `AnalystRatingBuy` int DEFAULT NULL,
  `AnalystRatingHold` int DEFAULT NULL,
  `AnalystRatingSell` int DEFAULT NULL,
  `AnalystRatingStrongSell` int DEFAULT NULL,
  `TrailingPE` decimal(20,5) DEFAULT NULL,
  `ForwardPE` decimal(20,5) DEFAULT NULL,
  `PriceToSalesRatioTTM` decimal(20,5) DEFAULT NULL,
  `PriceToBookRatio` decimal(20,5) DEFAULT NULL,
  `EVToRevenue` decimal(20,5) DEFAULT NULL,
  `EVToEBITDA` decimal(20,5) DEFAULT NULL,
  `Beta` decimal(20,5) DEFAULT NULL,
  `52WeekHigh` decimal(20,5) DEFAULT NULL,
  `52WeekLow` decimal(20,5) DEFAULT NULL,
  `50DayMovingAverage` decimal(20,5) DEFAULT NULL,
  `200DayMovingAverage` decimal(20,5) DEFAULT NULL,
  `SharesOutstanding` bigint DEFAULT NULL,
  `DividendDate` datetime DEFAULT NULL,
  `ExDividendDate` datetime DEFAULT NULL,
  `UpdatedDate` datetime DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`CompanyOverviewID`),
  UNIQUE KEY `stockID_Uni` (`StockID`),
  KEY `stockSym_Idx` (`Symbol`)
) ENGINE=InnoDB AUTO_INCREMENT=8809 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Earnings`
--

DROP TABLE IF EXISTS `Earnings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Earnings` (
  `EarningsID` int NOT NULL AUTO_INCREMENT,
  `StockID` int DEFAULT NULL,
  `FiscalDateEnding` datetime DEFAULT NULL,
  `ReportedDate` datetime DEFAULT NULL,
  `ReportedEPS` decimal(20,5) DEFAULT NULL,
  `EstimatedEPS` decimal(20,5) DEFAULT NULL,
  `Surprise` decimal(20,5) DEFAULT NULL,
  `SurprisePercentage` decimal(20,5) DEFAULT NULL,
  `ReportTime` varchar(255) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`EarningsID`)
) ENGINE=InnoDB AUTO_INCREMENT=504265 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `FinancialData`
--

DROP TABLE IF EXISTS `FinancialData`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FinancialData` (
  `FinancialDataID` int NOT NULL AUTO_INCREMENT,
  `StockID` int NOT NULL,
  `StockDate` datetime DEFAULT NULL,
  `Open` decimal(20,5) DEFAULT NULL,
  `Low` decimal(20,5) DEFAULT NULL,
  `High` decimal(20,5) DEFAULT NULL,
  `Close` decimal(20,5) DEFAULT NULL,
  `Volume` decimal(20,5) DEFAULT NULL,
  `EMA` decimal(20,5) DEFAULT NULL,
  `VWAP` decimal(20,5) DEFAULT NULL,
  `RateOfChange` decimal(20,5) DEFAULT NULL,
  `OnBalanceVolume` decimal(20,5) DEFAULT NULL,
  PRIMARY KEY (`FinancialDataID`,`StockID`),
  UNIQUE KEY `StockID_Date_Idx` (`StockID`,`StockDate`),
  KEY `idx3` (`StockID`,`FinancialDataID`,`StockDate`,`Close`)
) ENGINE=InnoDB AUTO_INCREMENT=320075156 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
/*!50100 PARTITION BY HASH (`StockID`)
PARTITIONS 100 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `FinancialDataParentChild`
--

DROP TABLE IF EXISTS `FinancialDataParentChild`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FinancialDataParentChild` (
  `financialdataparentchild` int NOT NULL DEFAULT '0',
  `FinancialDataID` int NOT NULL,
  `ParentFinancialDataID` int DEFAULT NULL,
  `StockID` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `IncomeStatement`
--

DROP TABLE IF EXISTS `IncomeStatement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `IncomeStatement` (
  `IncomeStatementID` int NOT NULL AUTO_INCREMENT,
  `StockID` int DEFAULT NULL,
  `FiscalDateEnding` datetime DEFAULT NULL,
  `ReportedCurrency` varchar(255) DEFAULT NULL,
  `GrossProfit` bigint DEFAULT NULL,
  `TotalRevenue` bigint DEFAULT NULL,
  `CostOfRevenue` bigint DEFAULT NULL,
  `CostofGoodsAndServicesSold` bigint DEFAULT NULL,
  `OperatingIncome` bigint DEFAULT NULL,
  `SellingGeneralAndAdministrative` bigint DEFAULT NULL,
  `ResearchAndDevelopment` bigint DEFAULT NULL,
  `OperatingExpenses` bigint DEFAULT NULL,
  `InvestmentIncomeNet` text,
  `NetInterestIncome` bigint DEFAULT NULL,
  `InterestIncome` bigint DEFAULT NULL,
  `InterestExpense` bigint DEFAULT NULL,
  `NonInterestIncome` bigint DEFAULT NULL,
  `OtherNonOperatingIncome` bigint DEFAULT NULL,
  `Depreciation` bigint DEFAULT NULL,
  `DepreciationAndAmortization` bigint DEFAULT NULL,
  `IncomeBeforeTax` bigint DEFAULT NULL,
  `IncomeTaxExpense` bigint DEFAULT NULL,
  `InterestAndDebtExpense` bigint DEFAULT NULL,
  `NetIncomeFromContinuingOperations` bigint DEFAULT NULL,
  `ComprehensiveIncomeNetOfTax` bigint DEFAULT NULL,
  `Ebit` bigint DEFAULT NULL,
  `Ebitda` bigint DEFAULT NULL,
  `NetIncome` bigint DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`IncomeStatementID`)
) ENGINE=InnoDB AUTO_INCREMENT=353735 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `NewsArticle`
--

DROP TABLE IF EXISTS `NewsArticle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `NewsArticle` (
  `NewsArticleID` int NOT NULL AUTO_INCREMENT,
  `Title` varchar(255) DEFAULT NULL,
  `Authors` varchar(255) DEFAULT NULL,
  `Source` varchar(255) DEFAULT NULL,
  `SourceCategory` varchar(255) DEFAULT NULL,
  `SourceDomain` varchar(255) DEFAULT NULL,
  `Link` varchar(255) DEFAULT NULL,
  `Summary` varchar(800) DEFAULT NULL,
  `Sentiment` varchar(255) DEFAULT NULL,
  `SentimentScore` decimal(10,10) DEFAULT NULL,
  `PublishDate` datetime DEFAULT NULL,
  PRIMARY KEY (`NewsArticleID`),
  KEY `Idx1` (`Link`),
  KEY `Idx2` (`PublishDate` DESC)
) ENGINE=InnoDB AUTO_INCREMENT=1284547 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `NewsArticleToStock`
--

DROP TABLE IF EXISTS `NewsArticleToStock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `NewsArticleToStock` (
  `NewsArticleToStockID` int NOT NULL AUTO_INCREMENT,
  `NewsArticleID` int DEFAULT NULL,
  `StockID` int DEFAULT NULL,
  `Relevance` decimal(10,10) DEFAULT NULL,
  `Sentiment` varchar(255) DEFAULT NULL,
  `SentimentScore` decimal(10,10) DEFAULT NULL,
  PRIMARY KEY (`NewsArticleToStockID`),
  KEY `Idx1` (`StockID`,`NewsArticleID`)
) ENGINE=InnoDB AUTO_INCREMENT=2656708 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `NewsArticleToTopic`
--

DROP TABLE IF EXISTS `NewsArticleToTopic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `NewsArticleToTopic` (
  `NewsArticleToTopicID` int NOT NULL AUTO_INCREMENT,
  `NewsArticleID` int DEFAULT NULL,
  `NewsTopicID` int DEFAULT NULL,
  `Relevance` decimal(10,10) DEFAULT NULL,
  PRIMARY KEY (`NewsArticleToTopicID`),
  KEY `Idx_1` (`NewsArticleID`,`NewsTopicID`,`Relevance`)
) ENGINE=InnoDB AUTO_INCREMENT=3793949 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `NewsTopic`
--

DROP TABLE IF EXISTS `NewsTopic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `NewsTopic` (
  `NewsTopicID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) DEFAULT NULL,
  `DisplayName` varchar(255) DEFAULT NULL,
  `Active` int DEFAULT NULL,
  PRIMARY KEY (`NewsTopicID`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `PresentationBalanceSheet`
--

DROP TABLE IF EXISTS `PresentationBalanceSheet`;
/*!50001 DROP VIEW IF EXISTS `PresentationBalanceSheet`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `PresentationBalanceSheet` AS SELECT 
 1 AS `BalanceSheetID`,
 1 AS `StockID`,
 1 AS `FiscalDateEnding`,
 1 AS `ReportedCurrency`,
 1 AS `TotalAssets`,
 1 AS `TotalCurrentAssets`,
 1 AS `CashAndCashEquivalentsAtCarryingValue`,
 1 AS `CashAndShortTermInvestments`,
 1 AS `Inventory`,
 1 AS `CurrentNetReceivables`,
 1 AS `TotalNonCurrentAssets`,
 1 AS `PropertyPlantEquipment`,
 1 AS `AccumulatedDepreciationAmortizationPPE`,
 1 AS `IntangibleAssets`,
 1 AS `IntangibleAssetsExcludingGoodwill`,
 1 AS `Goodwill`,
 1 AS `Investments`,
 1 AS `LongTermInvestments`,
 1 AS `ShortTermInvestments`,
 1 AS `OtherCurrentAssets`,
 1 AS `OtherNonCurrentAssets`,
 1 AS `TotalLiabilities`,
 1 AS `TotalCurrentLiabilities`,
 1 AS `CurrentAccountsPayable`,
 1 AS `DeferredRevenue`,
 1 AS `CurrentDebt`,
 1 AS `ShortTermDebt`,
 1 AS `TotalNonCurrentLiabilities`,
 1 AS `CapitalLeaseObligations`,
 1 AS `LongTermDebt`,
 1 AS `CurrentLongTermDebt`,
 1 AS `LongTermDebtNoncurrent`,
 1 AS `ShortLongTermDebtTotal`,
 1 AS `OtherCurrentLiabilities`,
 1 AS `OtherNonCurrentLiabilities`,
 1 AS `TotalShareholderEquity`,
 1 AS `TreasuryStock`,
 1 AS `RetainedEarnings`,
 1 AS `CommonStock`,
 1 AS `CommonStockSharesOutstanding`,
 1 AS `CreatedDate`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `PresentationBoilerBand`
--

DROP TABLE IF EXISTS `PresentationBoilerBand`;
/*!50001 DROP VIEW IF EXISTS `PresentationBoilerBand`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `PresentationBoilerBand` AS SELECT 
 1 AS `BoilerBandID`,
 1 AS `StockID`,
 1 AS `FinancialDataID`,
 1 AS `StockDate`,
 1 AS `Lower`,
 1 AS `Middle`,
 1 AS `Upper`,
 1 AS `WidthPercentage`,
 1 AS `OutsideStdDev`,
 1 AS `AmountOutStdDev`,
 1 AS `UpdatedDate`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `PresentationCashFlow`
--

DROP TABLE IF EXISTS `PresentationCashFlow`;
/*!50001 DROP VIEW IF EXISTS `PresentationCashFlow`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `PresentationCashFlow` AS SELECT 
 1 AS `CashFlowID`,
 1 AS `StockID`,
 1 AS `FiscalDateEnding`,
 1 AS `ReportedCurrency`,
 1 AS `OperatingCashflow`,
 1 AS `PaymentsForOperatingActivities`,
 1 AS `ProceedsFromOperatingActivities`,
 1 AS `ChangeInOperatingLiabilities`,
 1 AS `ChangeInOperatingAssets`,
 1 AS `DepreciationDepletionAndAmortization`,
 1 AS `CapitalExpenditures`,
 1 AS `ChangeInReceivables`,
 1 AS `ChangeInInventory`,
 1 AS `ProfitLoss`,
 1 AS `CashflowFromInvestment`,
 1 AS `CashflowFromFinancing`,
 1 AS `ProceedsFromRepaymentsOfShortTermDebt`,
 1 AS `PaymentsForRepurchaseOfCommonStock`,
 1 AS `PaymentsForRepurchaseOfEquity`,
 1 AS `PaymentsForRepurchaseOfPreferredStock`,
 1 AS `DividendPayout`,
 1 AS `DividendPayoutCommonStock`,
 1 AS `DividendPayoutPreferredStock`,
 1 AS `ProceedsFromIssuanceOfCommonStock`,
 1 AS `ProceedsFromIssuanceOfLongTermDebtAndCapitalSecuritiesNet`,
 1 AS `ProceedsFromIssuanceOfPreferredStock`,
 1 AS `ProceedsFromRepurchaseOfEquity`,
 1 AS `ProceedsFromSaleOfTreasuryStock`,
 1 AS `ChangeInCashAndCashEquivalents`,
 1 AS `ChangeInExchangeRate`,
 1 AS `NetIncome`,
 1 AS `CreatedDate`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `PresentationChaikinOscillator`
--

DROP TABLE IF EXISTS `PresentationChaikinOscillator`;
/*!50001 DROP VIEW IF EXISTS `PresentationChaikinOscillator`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `PresentationChaikinOscillator` AS SELECT 
 1 AS `ChaikinOscillatorID`,
 1 AS `StockID`,
 1 AS `FinancialDataID`,
 1 AS `StockDate`,
 1 AS `ChaikinADLine`,
 1 AS `CrossedZero`,
 1 AS `UpdatedDate`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `PresentationCompanyOverview`
--

DROP TABLE IF EXISTS `PresentationCompanyOverview`;
/*!50001 DROP VIEW IF EXISTS `PresentationCompanyOverview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `PresentationCompanyOverview` AS SELECT 
 1 AS `CompanyOverviewID`,
 1 AS `StockID`,
 1 AS `Symbol`,
 1 AS `AssetType`,
 1 AS `Name`,
 1 AS `Description`,
 1 AS `CIK`,
 1 AS `Exchange`,
 1 AS `Currency`,
 1 AS `Country`,
 1 AS `Sector`,
 1 AS `Industry`,
 1 AS `Address`,
 1 AS `OfficialSite`,
 1 AS `FiscalYearEnd`,
 1 AS `LatestQuarter`,
 1 AS `MarketCapitalization`,
 1 AS `EBITDA`,
 1 AS `PERatio`,
 1 AS `PEGRatio`,
 1 AS `BookValue`,
 1 AS `DividendPerShare`,
 1 AS `DividendYield`,
 1 AS `EPS`,
 1 AS `RevenuePerShareTTM`,
 1 AS `ProfitMargin`,
 1 AS `OperatingMarginTTM`,
 1 AS `ReturnOnAssetsTTM`,
 1 AS `ReturnOnEquityTTM`,
 1 AS `RevenueTTM`,
 1 AS `GrossProfitTTM`,
 1 AS `DilutedEPSTTM`,
 1 AS `QuarterlyEarningsGrowthYOY`,
 1 AS `QuarterlyRevenueGrowthYOY`,
 1 AS `AnalystTargetPrice`,
 1 AS `AnalystRatingStrongBuy`,
 1 AS `AnalystRatingBuy`,
 1 AS `AnalystRatingHold`,
 1 AS `AnalystRatingSell`,
 1 AS `AnalystRatingStrongSell`,
 1 AS `TrailingPE`,
 1 AS `ForwardPE`,
 1 AS `PriceToSalesRatioTTM`,
 1 AS `PriceToBookRatio`,
 1 AS `EVToRevenue`,
 1 AS `EVToEBITDA`,
 1 AS `Beta`,
 1 AS `52WeekHigh`,
 1 AS `52WeekLow`,
 1 AS `50DayMovingAverage`,
 1 AS `200DayMovingAverage`,
 1 AS `SharesOutstanding`,
 1 AS `DividendDate`,
 1 AS `ExDividendDate`,
 1 AS `UpdatedDate`,
 1 AS `CreatedDate`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `PresentationDirectionalMovement`
--

DROP TABLE IF EXISTS `PresentationDirectionalMovement`;
/*!50001 DROP VIEW IF EXISTS `PresentationDirectionalMovement`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `PresentationDirectionalMovement` AS SELECT 
 1 AS `DirectionalMovementID`,
 1 AS `StockID`,
 1 AS `FinancialDataID`,
 1 AS `StockDate`,
 1 AS `ADX`,
 1 AS `DX`,
 1 AS `DMIPlus`,
 1 AS `DMIMinus`,
 1 AS `TrendDirection`,
 1 AS `TrendChange`,
 1 AS `UpdatedDate`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `PresentationEarnings`
--

DROP TABLE IF EXISTS `PresentationEarnings`;
/*!50001 DROP VIEW IF EXISTS `PresentationEarnings`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `PresentationEarnings` AS SELECT 
 1 AS `EarningsID`,
 1 AS `StockID`,
 1 AS `FiscalDateEnding`,
 1 AS `ReportedDate`,
 1 AS `ReportedEPS`,
 1 AS `EstimatedEPS`,
 1 AS `Surprise`,
 1 AS `SurprisePercentage`,
 1 AS `ReportTime`,
 1 AS `CreatedDate`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `PresentationFinancialData`
--

DROP TABLE IF EXISTS `PresentationFinancialData`;
/*!50001 DROP VIEW IF EXISTS `PresentationFinancialData`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `PresentationFinancialData` AS SELECT 
 1 AS `FinancialDataID`,
 1 AS `StockID`,
 1 AS `StockDate`,
 1 AS `Open`,
 1 AS `Low`,
 1 AS `High`,
 1 AS `Close`,
 1 AS `Volume`,
 1 AS `EMA`,
 1 AS `VWAP`,
 1 AS `RateOfChange`,
 1 AS `OnBalanceVolume`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `PresentationIncomeStatement`
--

DROP TABLE IF EXISTS `PresentationIncomeStatement`;
/*!50001 DROP VIEW IF EXISTS `PresentationIncomeStatement`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `PresentationIncomeStatement` AS SELECT 
 1 AS `IncomeStatementID`,
 1 AS `StockID`,
 1 AS `FiscalDateEnding`,
 1 AS `ReportedCurrency`,
 1 AS `GrossProfit`,
 1 AS `TotalRevenue`,
 1 AS `CostOfRevenue`,
 1 AS `CostofGoodsAndServicesSold`,
 1 AS `OperatingIncome`,
 1 AS `SellingGeneralAndAdministrative`,
 1 AS `ResearchAndDevelopment`,
 1 AS `OperatingExpenses`,
 1 AS `InvestmentIncomeNet`,
 1 AS `NetInterestIncome`,
 1 AS `InterestIncome`,
 1 AS `InterestExpense`,
 1 AS `NonInterestIncome`,
 1 AS `OtherNonOperatingIncome`,
 1 AS `Depreciation`,
 1 AS `DepreciationAndAmortization`,
 1 AS `IncomeBeforeTax`,
 1 AS `IncomeTaxExpense`,
 1 AS `InterestAndDebtExpense`,
 1 AS `NetIncomeFromContinuingOperations`,
 1 AS `ComprehensiveIncomeNetOfTax`,
 1 AS `Ebit`,
 1 AS `Ebitda`,
 1 AS `NetIncome`,
 1 AS `CreatedDate`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `PresentationMACD`
--

DROP TABLE IF EXISTS `PresentationMACD`;
/*!50001 DROP VIEW IF EXISTS `PresentationMACD`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `PresentationMACD` AS SELECT 
 1 AS `MACDID`,
 1 AS `StockID`,
 1 AS `FinancialDataID`,
 1 AS `StockDate`,
 1 AS `MACD`,
 1 AS `MACD_Signal`,
 1 AS `MACD_Hist`,
 1 AS `CrossedZero`,
 1 AS `TrendDirection`,
 1 AS `TrendChange`,
 1 AS `UpdatedDate`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `PresentationNewsArticle`
--

DROP TABLE IF EXISTS `PresentationNewsArticle`;
/*!50001 DROP VIEW IF EXISTS `PresentationNewsArticle`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `PresentationNewsArticle` AS SELECT 
 1 AS `NewsArticleID`,
 1 AS `Title`,
 1 AS `Authors`,
 1 AS `Source`,
 1 AS `SourceCategory`,
 1 AS `SourceDomain`,
 1 AS `Link`,
 1 AS `Summary`,
 1 AS `Sentiment`,
 1 AS `SentimentScore`,
 1 AS `PublishDate`,
 1 AS `NewsTopicID`,
 1 AS `DisplayName`,
 1 AS `TopicRelevance`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `PresentationNewsArticleToStocks`
--

DROP TABLE IF EXISTS `PresentationNewsArticleToStocks`;
/*!50001 DROP VIEW IF EXISTS `PresentationNewsArticleToStocks`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `PresentationNewsArticleToStocks` AS SELECT 
 1 AS `NewsArticleID`,
 1 AS `Title`,
 1 AS `Authors`,
 1 AS `Source`,
 1 AS `SourceCategory`,
 1 AS `SourceDomain`,
 1 AS `Link`,
 1 AS `Summary`,
 1 AS `ArticleSentiment`,
 1 AS `ArticleSentimentScore`,
 1 AS `PublishDate`,
 1 AS `StockRelevance`,
 1 AS `StockSentiment`,
 1 AS `StockSentimentScore`,
 1 AS `CompanyName`,
 1 AS `Symbol`,
 1 AS `AssetType`,
 1 AS `StockExchange`,
 1 AS `StockID`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `PresentationSar`
--

DROP TABLE IF EXISTS `PresentationSar`;
/*!50001 DROP VIEW IF EXISTS `PresentationSar`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `PresentationSar` AS SELECT 
 1 AS `SarID`,
 1 AS `StockID`,
 1 AS `FinancialDataID`,
 1 AS `StockDate`,
 1 AS `Sar`,
 1 AS `WMA`,
 1 AS `TrendDirection`,
 1 AS `TrendChange`,
 1 AS `UpdatedDate`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `PresentationStock`
--

DROP TABLE IF EXISTS `PresentationStock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PresentationStock` (
  `PresentationStockID` int NOT NULL AUTO_INCREMENT,
  `StockID` int DEFAULT NULL,
  `StockExchange` varchar(250) DEFAULT NULL,
  `StartDate` datetime DEFAULT NULL,
  `EndDate` datetime DEFAULT NULL,
  `UpdatedDate` datetime DEFAULT NULL,
  `Active` int DEFAULT NULL,
  PRIMARY KEY (`PresentationStockID`)
) ENGINE=InnoDB AUTO_INCREMENT=5398 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `PresentationStocks`
--

DROP TABLE IF EXISTS `PresentationStocks`;
/*!50001 DROP VIEW IF EXISTS `PresentationStocks`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `PresentationStocks` AS SELECT 
 1 AS `StockID`,
 1 AS `CompanyName`,
 1 AS `Symbol`,
 1 AS `AssetType`,
 1 AS `StockExchange`,
 1 AS `NoData`,
 1 AS `LastStockDate`,
 1 AS `NextReportDate`,
 1 AS `NextFiscalDateEnd`,
 1 AS `LastNewsRetrieval`,
 1 AS `UpdatedDate`,
 1 AS `CreatedDate`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `ProcessThreadManager`
--

DROP TABLE IF EXISTS `ProcessThreadManager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ProcessThreadManager` (
  `ProcessThreadManagerID` int NOT NULL AUTO_INCREMENT,
  `ThreadID` varchar(45) DEFAULT NULL,
  `Event` varchar(255) DEFAULT NULL,
  `Table` varchar(255) DEFAULT NULL,
  `StartDateTime` datetime DEFAULT NULL,
  PRIMARY KEY (`ProcessThreadManagerID`),
  UNIQUE KEY `ProcessThreadManagerID_UNIQUE` (`ProcessThreadManagerID`),
  UNIQUE KEY `event_uni` (`Event`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `RawBalanceSheet`
--

DROP TABLE IF EXISTS `RawBalanceSheet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `RawBalanceSheet` (
  `RawBalanceSheetID` int NOT NULL AUTO_INCREMENT,
  `fiscalDateEnding` datetime DEFAULT NULL,
  `reportedCurrency` varchar(255) DEFAULT NULL,
  `totalAssets` bigint DEFAULT NULL,
  `totalCurrentAssets` bigint DEFAULT NULL,
  `cashAndCashEquivalentsAtCarryingValue` bigint DEFAULT NULL,
  `cashAndShortTermInvestments` bigint DEFAULT NULL,
  `inventory` bigint DEFAULT NULL,
  `currentNetReceivables` bigint DEFAULT NULL,
  `totalNonCurrentAssets` bigint DEFAULT NULL,
  `propertyPlantEquipment` bigint DEFAULT NULL,
  `accumulatedDepreciationAmortizationPPE` bigint DEFAULT NULL,
  `intangibleAssets` bigint DEFAULT NULL,
  `intangibleAssetsExcludingGoodwill` bigint DEFAULT NULL,
  `goodwill` bigint DEFAULT NULL,
  `investments` bigint DEFAULT NULL,
  `longTermInvestments` bigint DEFAULT NULL,
  `shortTermInvestments` bigint DEFAULT NULL,
  `otherCurrentAssets` bigint DEFAULT NULL,
  `otherNonCurrentAssets` bigint DEFAULT NULL,
  `totalLiabilities` bigint DEFAULT NULL,
  `totalCurrentLiabilities` bigint DEFAULT NULL,
  `currentAccountsPayable` bigint DEFAULT NULL,
  `deferredRevenue` bigint DEFAULT NULL,
  `currentDebt` bigint DEFAULT NULL,
  `shortTermDebt` bigint DEFAULT NULL,
  `totalNonCurrentLiabilities` bigint DEFAULT NULL,
  `capitalLeaseObligations` bigint DEFAULT NULL,
  `longTermDebt` bigint DEFAULT NULL,
  `currentLongTermDebt` bigint DEFAULT NULL,
  `longTermDebtNoncurrent` bigint DEFAULT NULL,
  `shortLongTermDebtTotal` bigint DEFAULT NULL,
  `otherCurrentLiabilities` bigint DEFAULT NULL,
  `otherNonCurrentLiabilities` bigint DEFAULT NULL,
  `totalShareholderEquity` bigint DEFAULT NULL,
  `treasuryStock` bigint DEFAULT NULL,
  `retainedEarnings` bigint DEFAULT NULL,
  `commonStock` bigint DEFAULT NULL,
  `commonStockSharesOutstanding` bigint DEFAULT NULL,
  `StockSymbol` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`RawBalanceSheetID`),
  KEY `Idx1` (`StockSymbol`,`fiscalDateEnding`)
) ENGINE=InnoDB AUTO_INCREMENT=201136 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `RawCashFlow`
--

DROP TABLE IF EXISTS `RawCashFlow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `RawCashFlow` (
  `RawCashFlowID` int NOT NULL AUTO_INCREMENT,
  `fiscalDateEnding` datetime DEFAULT NULL,
  `reportedCurrency` varchar(255) DEFAULT NULL,
  `operatingCashflow` bigint DEFAULT NULL,
  `paymentsForOperatingActivities` bigint DEFAULT NULL,
  `proceedsFromOperatingActivities` bigint DEFAULT NULL,
  `changeInOperatingLiabilities` bigint DEFAULT NULL,
  `changeInOperatingAssets` bigint DEFAULT NULL,
  `depreciationDepletionAndAmortization` bigint DEFAULT NULL,
  `capitalExpenditures` bigint DEFAULT NULL,
  `changeInReceivables` bigint DEFAULT NULL,
  `changeInInventory` bigint DEFAULT NULL,
  `profitLoss` bigint DEFAULT NULL,
  `cashflowFromInvestment` bigint DEFAULT NULL,
  `cashflowFromFinancing` bigint DEFAULT NULL,
  `proceedsFromRepaymentsOfShortTermDebt` bigint DEFAULT NULL,
  `paymentsForRepurchaseOfCommonStock` bigint DEFAULT NULL,
  `paymentsForRepurchaseOfEquity` bigint DEFAULT NULL,
  `paymentsForRepurchaseOfPreferredStock` bigint DEFAULT NULL,
  `dividendPayout` bigint DEFAULT NULL,
  `dividendPayoutCommonStock` bigint DEFAULT NULL,
  `dividendPayoutPreferredStock` bigint DEFAULT NULL,
  `proceedsFromIssuanceOfCommonStock` bigint DEFAULT NULL,
  `proceedsFromIssuanceOfLongTermDebtAndCapitalSecuritiesNet` bigint DEFAULT NULL,
  `proceedsFromIssuanceOfPreferredStock` bigint DEFAULT NULL,
  `proceedsFromRepurchaseOfEquity` bigint DEFAULT NULL,
  `proceedsFromSaleOfTreasuryStock` bigint DEFAULT NULL,
  `changeInCashAndCashEquivalents` bigint DEFAULT NULL,
  `changeInExchangeRate` bigint DEFAULT NULL,
  `netIncome` bigint DEFAULT NULL,
  `StockSymbol` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`RawCashFlowID`),
  KEY `Idx1` (`fiscalDateEnding`,`StockSymbol`)
) ENGINE=InnoDB AUTO_INCREMENT=199068 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `RawEarning`
--

DROP TABLE IF EXISTS `RawEarning`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `RawEarning` (
  `RawEarningID` int NOT NULL AUTO_INCREMENT,
  `fiscalDateEnding` datetime DEFAULT NULL,
  `reportedDate` datetime DEFAULT NULL,
  `reportedEPS` decimal(20,5) DEFAULT NULL,
  `estimatedEPS` decimal(20,5) DEFAULT NULL,
  `surprise` decimal(20,5) DEFAULT NULL,
  `surprisePercentage` decimal(20,5) DEFAULT NULL,
  `reportTime` varchar(255) DEFAULT NULL,
  `StockSymbol` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`RawEarningID`),
  KEY `Idx1` (`StockSymbol`,`reportedDate`)
) ENGINE=InnoDB AUTO_INCREMENT=209350 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `RawIncomeStatement`
--

DROP TABLE IF EXISTS `RawIncomeStatement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `RawIncomeStatement` (
  `RawIncomeStatementID` int NOT NULL AUTO_INCREMENT,
  `fiscalDateEnding` datetime DEFAULT NULL,
  `reportedCurrency` varchar(255) DEFAULT NULL,
  `grossProfit` bigint DEFAULT NULL,
  `totalRevenue` bigint DEFAULT NULL,
  `costOfRevenue` bigint DEFAULT NULL,
  `costofGoodsAndServicesSold` bigint DEFAULT NULL,
  `operatingIncome` bigint DEFAULT NULL,
  `sellingGeneralAndAdministrative` bigint DEFAULT NULL,
  `researchAndDevelopment` bigint DEFAULT NULL,
  `operatingExpenses` bigint DEFAULT NULL,
  `investmentIncomeNet` text,
  `netInterestIncome` bigint DEFAULT NULL,
  `interestIncome` bigint DEFAULT NULL,
  `interestExpense` bigint DEFAULT NULL,
  `nonInterestIncome` bigint DEFAULT NULL,
  `otherNonOperatingIncome` bigint DEFAULT NULL,
  `depreciation` bigint DEFAULT NULL,
  `depreciationAndAmortization` bigint DEFAULT NULL,
  `incomeBeforeTax` bigint DEFAULT NULL,
  `incomeTaxExpense` bigint DEFAULT NULL,
  `interestAndDebtExpense` bigint DEFAULT NULL,
  `netIncomeFromContinuingOperations` bigint DEFAULT NULL,
  `comprehensiveIncomeNetOfTax` bigint DEFAULT NULL,
  `ebit` bigint DEFAULT NULL,
  `ebitda` bigint DEFAULT NULL,
  `netIncome` bigint DEFAULT NULL,
  `StockSymbol` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`RawIncomeStatementID`),
  KEY `Idx1` (`StockSymbol`,`fiscalDateEnding`)
) ENGINE=InnoDB AUTO_INCREMENT=200199 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `RawNews`
--

DROP TABLE IF EXISTS `RawNews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `RawNews` (
  `RawNewsID` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `time_published` datetime DEFAULT NULL,
  `authors` varchar(200) DEFAULT NULL,
  `summary` varchar(800) DEFAULT NULL,
  `banner_image` varchar(255) DEFAULT NULL,
  `source` varchar(255) DEFAULT NULL,
  `category_within_source` varchar(255) DEFAULT NULL,
  `source_domain` varchar(255) DEFAULT NULL,
  `overall_sentiment_score` decimal(20,10) DEFAULT NULL,
  `overall_sentiment_label` varchar(255) DEFAULT NULL,
  `topic` varchar(45) DEFAULT NULL,
  `topic_relevance_score` decimal(20,10) DEFAULT NULL,
  `ticker` varchar(45) DEFAULT NULL,
  `ticker_relevance_score` decimal(20,10) DEFAULT NULL,
  `ticker_sentiment_label` varchar(255) DEFAULT NULL,
  `ticker_sentiment_score` decimal(20,10) DEFAULT NULL,
  PRIMARY KEY (`RawNewsID`),
  KEY `Idx1` (`url`)
) ENGINE=InnoDB AUTO_INCREMENT=1911933 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `boilerband`
--

DROP TABLE IF EXISTS `boilerband`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `boilerband` (
  `BoilerBandID` int NOT NULL AUTO_INCREMENT,
  `StockID` int NOT NULL,
  `FinancialDataID` int NOT NULL,
  `StockDate` datetime DEFAULT NULL,
  `Lower` decimal(20,5) DEFAULT NULL,
  `Middle` decimal(20,5) DEFAULT NULL,
  `Upper` decimal(20,5) DEFAULT NULL,
  `WidthPercentage` decimal(20,5) DEFAULT NULL,
  `OutsideStdDev` int DEFAULT '0',
  `AmountOutStdDev` decimal(20,5) DEFAULT '0.00000',
  `UpdatedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`BoilerBandID`,`StockID`),
  UNIQUE KEY `FinData_Uni` (`FinancialDataID`,`StockID`),
  UNIQUE KEY `StockID_StockDate_Unique` (`StockID`,`StockDate`)
) ENGINE=InnoDB AUTO_INCREMENT=321623785 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
/*!50100 PARTITION BY HASH (`StockID`)
PARTITIONS 100 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `chaikinoscillator`
--

DROP TABLE IF EXISTS `chaikinoscillator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chaikinoscillator` (
  `ChaikinOscillatorID` int NOT NULL AUTO_INCREMENT,
  `StockID` int NOT NULL,
  `FinancialDataID` int NOT NULL,
  `StockDate` datetime DEFAULT NULL,
  `ChaikinADLine` decimal(20,5) DEFAULT NULL,
  `CrossedZero` int DEFAULT '0',
  `UpdatedDate` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ChaikinOscillatorID`,`StockID`),
  UNIQUE KEY `FinancialDataID_UNIQUE` (`FinancialDataID`,`StockID`),
  UNIQUE KEY `StockID_Date_Unique` (`StockID`,`StockDate`),
  KEY `FinID_IDX` (`FinancialDataID`)
) ENGINE=InnoDB AUTO_INCREMENT=325821136 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
/*!50100 PARTITION BY HASH (`StockID`)
PARTITIONS 100 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `directionalmovement`
--

DROP TABLE IF EXISTS `directionalmovement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `directionalmovement` (
  `DirectionalMovementID` int NOT NULL AUTO_INCREMENT,
  `StockID` int NOT NULL,
  `FinancialDataID` int NOT NULL,
  `StockDate` datetime DEFAULT NULL,
  `ADX` decimal(20,5) DEFAULT NULL,
  `DX` decimal(20,5) DEFAULT NULL,
  `DMIPlus` decimal(20,5) DEFAULT NULL,
  `DMIMinus` decimal(20,5) DEFAULT NULL,
  `TrendDirection` int DEFAULT NULL,
  `TrendChange` int DEFAULT '0',
  `UpdatedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`DirectionalMovementID`,`StockID`),
  UNIQUE KEY `FinancialDataID_UNIQUE` (`FinancialDataID`,`StockID`),
  UNIQUE KEY `StockID_StockDate_Unique` (`StockID`,`StockDate`)
) ENGINE=InnoDB AUTO_INCREMENT=321627011 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
/*!50100 PARTITION BY HASH (`StockID`)
PARTITIONS 100 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `errorlog`
--

DROP TABLE IF EXISTS `errorlog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `errorlog` (
  `ErrorLogID` int NOT NULL AUTO_INCREMENT,
  `ObjectName` varchar(255) DEFAULT NULL,
  `ErrorNumber` int DEFAULT NULL,
  `ErrorMessage` varchar(2000) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`ErrorLogID`)
) ENGINE=InnoDB AUTO_INCREMENT=69623 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `indicator`
--

DROP TABLE IF EXISTS `indicator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `indicator` (
  `IndicatorID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) DEFAULT NULL,
  `Strength` varchar(255) DEFAULT NULL,
  `TableName` varchar(255) DEFAULT NULL,
  `ColumnName` varchar(255) DEFAULT NULL,
  `Active` int DEFAULT '1',
  PRIMARY KEY (`IndicatorID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `indicatorgroup`
--

DROP TABLE IF EXISTS `indicatorgroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `indicatorgroup` (
  `IndicatorGroupID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(45) DEFAULT NULL,
  `Strength` float DEFAULT NULL,
  `Active` int DEFAULT NULL,
  PRIMARY KEY (`IndicatorGroupID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `indicatorgroupmapping`
--

DROP TABLE IF EXISTS `indicatorgroupmapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `indicatorgroupmapping` (
  `IndicatorGroupMappingID` int NOT NULL AUTO_INCREMENT,
  `IndicatorID` int DEFAULT NULL,
  `IndicatorGroupID` int DEFAULT NULL,
  `Active` int DEFAULT NULL,
  PRIMARY KEY (`IndicatorGroupMappingID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `indicatorrule`
--

DROP TABLE IF EXISTS `indicatorrule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `indicatorrule` (
  `IndicatorRuleID` int NOT NULL AUTO_INCREMENT,
  `IndicatorID` int DEFAULT NULL,
  `Description` varchar(255) DEFAULT NULL,
  `Relationship` varchar(45) DEFAULT NULL,
  `ActionType` varchar(45) DEFAULT NULL,
  `ExpectedReaction` varchar(45) DEFAULT NULL,
  `ReactionAccuracy` float DEFAULT NULL,
  `TimeFrame` varchar(45) DEFAULT NULL,
  `IdentifyDataSP` varchar(255) DEFAULT NULL,
  `AnalyzeSP` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`IndicatorRuleID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `macd`
--

DROP TABLE IF EXISTS `macd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `macd` (
  `MACDID` int NOT NULL AUTO_INCREMENT,
  `StockID` int NOT NULL,
  `FinancialDataID` int NOT NULL,
  `StockDate` datetime DEFAULT NULL,
  `MACD` decimal(20,5) DEFAULT NULL,
  `MACD_Signal` decimal(20,5) DEFAULT NULL,
  `MACD_Hist` decimal(20,5) DEFAULT NULL,
  `CrossedZero` int DEFAULT '0',
  `TrendDirection` int DEFAULT NULL,
  `TrendChange` int DEFAULT '0',
  `UpdatedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`MACDID`,`StockID`),
  UNIQUE KEY `FinancialDataID_UNIQUE` (`FinancialDataID`,`StockID`),
  UNIQUE KEY `StockID_StockDate_Unique` (`StockID`,`StockDate`)
) ENGINE=InnoDB AUTO_INCREMENT=324412203 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
/*!50100 PARTITION BY HASH (`StockID`)
PARTITIONS 100 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `picklist`
--

DROP TABLE IF EXISTS `picklist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `picklist` (
  `PickListID` int NOT NULL AUTO_INCREMENT,
  `ObjectName` varchar(255) DEFAULT NULL,
  `ColumnName` varchar(255) DEFAULT NULL,
  `Value` varchar(255) DEFAULT NULL,
  `Active` int DEFAULT '1',
  PRIMARY KEY (`PickListID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rawCompanyOverview`
--

DROP TABLE IF EXISTS `rawCompanyOverview`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rawCompanyOverview` (
  `RawCompanyOverviewID` int NOT NULL AUTO_INCREMENT,
  `StockSymbol` varchar(255) DEFAULT NULL,
  `AssetType` varchar(255) DEFAULT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `Description` varchar(2000) DEFAULT NULL,
  `CIK` int DEFAULT NULL,
  `Exchange` varchar(255) DEFAULT NULL,
  `Currency` varchar(255) DEFAULT NULL,
  `Country` varchar(255) DEFAULT NULL,
  `Sector` varchar(255) DEFAULT NULL,
  `Industry` varchar(255) DEFAULT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `OfficialSite` varchar(255) DEFAULT NULL,
  `FiscalYearEnd` varchar(255) DEFAULT NULL,
  `LatestQuarter` datetime DEFAULT NULL,
  `MarketCapitalization` bigint DEFAULT NULL,
  `EBITDA` bigint DEFAULT NULL,
  `PERatio` decimal(20,5) DEFAULT NULL,
  `PEGRatio` decimal(20,5) DEFAULT NULL,
  `BookValue` decimal(20,5) DEFAULT NULL,
  `DividendPerShare` decimal(20,5) DEFAULT NULL,
  `DividendYield` decimal(20,5) DEFAULT NULL,
  `EPS` decimal(20,5) DEFAULT NULL,
  `RevenuePerShareTTM` decimal(20,5) DEFAULT NULL,
  `ProfitMargin` decimal(20,5) DEFAULT NULL,
  `OperatingMarginTTM` decimal(20,5) DEFAULT NULL,
  `ReturnOnAssetsTTM` decimal(20,5) DEFAULT NULL,
  `ReturnOnEquityTTM` decimal(20,5) DEFAULT NULL,
  `RevenueTTM` bigint DEFAULT NULL,
  `GrossProfitTTM` bigint DEFAULT NULL,
  `DilutedEPSTTM` decimal(20,5) DEFAULT NULL,
  `QuarterlyEarningsGrowthYOY` decimal(20,5) DEFAULT NULL,
  `QuarterlyRevenueGrowthYOY` decimal(20,5) DEFAULT NULL,
  `AnalystTargetPrice` decimal(20,5) DEFAULT NULL,
  `AnalystRatingStrongBuy` int DEFAULT NULL,
  `AnalystRatingBuy` int DEFAULT NULL,
  `AnalystRatingHold` int DEFAULT NULL,
  `AnalystRatingSell` int DEFAULT NULL,
  `AnalystRatingStrongSell` int DEFAULT NULL,
  `TrailingPE` decimal(20,5) DEFAULT NULL,
  `ForwardPE` decimal(20,5) DEFAULT NULL,
  `PriceToSalesRatioTTM` decimal(20,5) DEFAULT NULL,
  `PriceToBookRatio` decimal(20,5) DEFAULT NULL,
  `EVToRevenue` decimal(20,5) DEFAULT NULL,
  `EVToEBITDA` decimal(20,5) DEFAULT NULL,
  `Beta` decimal(20,5) DEFAULT NULL,
  `52WeekHigh` decimal(20,5) DEFAULT NULL,
  `52WeekLow` decimal(20,5) DEFAULT NULL,
  `50DayMovingAverage` decimal(20,5) DEFAULT NULL,
  `200DayMovingAverage` decimal(20,5) DEFAULT NULL,
  `SharesOutstanding` bigint DEFAULT NULL,
  `SharesFloat` decimal(20,5) DEFAULT NULL,
  `PercentInsiders` decimal(20,5) DEFAULT NULL,
  `PercentInstitutions` decimal(20,5) DEFAULT NULL,
  `DividendDate` datetime DEFAULT NULL,
  `ExDividendDate` datetime DEFAULT NULL,
  PRIMARY KEY (`RawCompanyOverviewID`)
) ENGINE=InnoDB AUTO_INCREMENT=6620 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rawFinancialDataQueue`
--

DROP TABLE IF EXISTS `rawFinancialDataQueue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rawFinancialDataQueue` (
  `RawFinancialDataQueueID` int NOT NULL AUTO_INCREMENT,
  `Symbol` varchar(250) DEFAULT NULL,
  `InsertedTime` datetime DEFAULT NULL,
  PRIMARY KEY (`RawFinancialDataQueueID`),
  UNIQUE KEY `Sym_Unique` (`Symbol`)
) ENGINE=InnoDB AUTO_INCREMENT=43566 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rawStock`
--

DROP TABLE IF EXISTS `rawStock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rawStock` (
  `Symbol` varchar(250) DEFAULT NULL,
  `AssetType` varchar(250) DEFAULT NULL,
  `CompanyName` varchar(250) DEFAULT NULL,
  `StockExchange` varchar(250) DEFAULT NULL,
  `reportDate` datetime DEFAULT NULL,
  `fiscalDateEnding` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `raw_data_to_data_transaction`
--

DROP TABLE IF EXISTS `raw_data_to_data_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `raw_data_to_data_transaction` (
  `Raw_Data_To_DataID` int NOT NULL AUTO_INCREMENT,
  `StockID` int DEFAULT NULL,
  `RecordQuantity` int DEFAULT NULL,
  `StartDateTime` datetime DEFAULT NULL,
  `EndDateTime` datetime DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`Raw_Data_To_DataID`),
  KEY `Idx1` (`StockID`,`RecordQuantity`)
) ENGINE=InnoDB AUTO_INCREMENT=782312 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rawfinancialdata`
--

DROP TABLE IF EXISTS `rawfinancialdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rawfinancialdata` (
  `RawFinancialDataID` int NOT NULL AUTO_INCREMENT,
  `StockSymbol` varchar(255) DEFAULT NULL,
  `dates` datetime DEFAULT NULL,
  `times` varchar(250) DEFAULT NULL,
  `openPrice` varchar(250) DEFAULT NULL,
  `highPrice` varchar(250) DEFAULT NULL,
  `lowPrice` varchar(250) DEFAULT NULL,
  `closePrice` varchar(250) DEFAULT NULL,
  `volume` varchar(250) DEFAULT NULL,
  `wma` varchar(250) DEFAULT NULL,
  `ema` varchar(250) DEFAULT NULL,
  `MACD` varchar(250) DEFAULT NULL,
  `MACD_Signal` varchar(250) DEFAULT NULL,
  `MACD_hist` varchar(250) DEFAULT NULL,
  `boiler_band_upper` varchar(250) DEFAULT NULL,
  `boiler_band_middle` varchar(250) DEFAULT NULL,
  `boiler_band_lower` varchar(250) DEFAULT NULL,
  `vwap` varchar(250) DEFAULT NULL,
  `RoC` varchar(250) DEFAULT NULL,
  `OBV` varchar(250) DEFAULT NULL,
  `AD` varchar(250) DEFAULT NULL,
  `SAR` varchar(250) DEFAULT NULL,
  `ADX` varchar(250) DEFAULT NULL,
  `DX` varchar(255) DEFAULT NULL,
  `PDMI` varchar(255) DEFAULT NULL,
  `MDMI` varchar(255) DEFAULT NULL,
  `StockDateTime` datetime DEFAULT NULL,
  PRIMARY KEY (`RawFinancialDataID`),
  KEY `stockSym` (`StockSymbol`),
  KEY `StockDate` (`StockDateTime`)
) ENGINE=InnoDB AUTO_INCREMENT=82544725 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sar`
--

DROP TABLE IF EXISTS `sar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sar` (
  `SarID` int NOT NULL AUTO_INCREMENT,
  `StockID` int NOT NULL,
  `FinancialDataID` int NOT NULL,
  `StockDate` datetime DEFAULT NULL,
  `Sar` decimal(20,5) DEFAULT NULL,
  `WMA` decimal(20,5) DEFAULT NULL,
  `TrendDirection` int DEFAULT NULL,
  `TrendChange` int DEFAULT '0',
  `UpdatedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`SarID`,`StockID`),
  UNIQUE KEY `FinancialDataID_UNIQUE` (`FinancialDataID`,`StockID`),
  UNIQUE KEY `StockID_StockDate_Unique` (`StockID`,`StockDate`),
  KEY `idx_sar_trend_update` (`SarID`,`TrendDirection`,`UpdatedDate`,`StockID`)
) ENGINE=InnoDB AUTO_INCREMENT=321638517 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
/*!50100 PARTITION BY HASH (`StockID`)
PARTITIONS 100 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `settings` (
  `SettingsID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) DEFAULT NULL,
  `Location` varchar(255) DEFAULT NULL,
  `Description` varchar(255) DEFAULT NULL,
  `Value` varchar(255) DEFAULT NULL,
  `Active` int DEFAULT '1',
  PRIMARY KEY (`SettingsID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stock`
--

DROP TABLE IF EXISTS `stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock` (
  `StockID` int NOT NULL AUTO_INCREMENT,
  `CompanyName` varchar(250) DEFAULT NULL,
  `Symbol` varchar(250) DEFAULT NULL,
  `AssetType` varchar(45) DEFAULT NULL,
  `StockExchange` varchar(45) DEFAULT NULL,
  `NoData` int DEFAULT NULL,
  `LastStockDate` datetime DEFAULT NULL,
  `NextReportDate` datetime DEFAULT NULL,
  `NextFiscalDateEnd` datetime DEFAULT NULL,
  `LastNewsRetrieval` datetime DEFAULT NULL,
  `UpdatedDate` datetime DEFAULT NULL,
  `CreatedDate` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`StockID`),
  UNIQUE KEY `Symbol_Unique` (`Symbol`)
) ENGINE=InnoDB AUTO_INCREMENT=20365 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stocktoindicatormapping`
--

DROP TABLE IF EXISTS `stocktoindicatormapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stocktoindicatormapping` (
  `StockToIndicatorMappingID` int NOT NULL AUTO_INCREMENT,
  `IndicatorRuleID` int DEFAULT NULL,
  `DateTime` datetime DEFAULT NULL,
  `StockID` int DEFAULT NULL,
  `ExpectedReaction` varchar(45) DEFAULT NULL,
  `ActualReaction` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`StockToIndicatorMappingID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `timeindicator`
--

DROP TABLE IF EXISTS `timeindicator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `timeindicator` (
  `TimeIndicatorID` int NOT NULL AUTO_INCREMENT,
  `TimeUnit` varchar(255) DEFAULT NULL,
  `AmountOfTimeUnit` varchar(255) DEFAULT NULL,
  `GroupByDateFormat` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`TimeIndicatorID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping events for database 'stocks'
--
/*!50106 SET @save_time_zone= @@TIME_ZONE */ ;
/*!50106 DROP EVENT IF EXISTS `GetMostRecentNewsThread0` */;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = '' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`%`*/ /*!50106 EVENT `GetMostRecentNewsThread0` ON SCHEDULE EVERY 1 MINUTE STARTS '2025-04-18 00:44:11' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
                IF (IS_FREE_LOCK('GetMostRecentNewsThread0') = 1) THEN
            
					SELECT GET_LOCK('GetMostRecentNewsThread0', 0);
					call stocks.RawNewsToNews();
					SELECT RELEASE_LOCK('GetMostRecentNewsThread0');
                END IF;
        END */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
/*!50106 DROP EVENT IF EXISTS `ProcessQuarterlyCompanyData` */;;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = '' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`%`*/ /*!50106 EVENT `ProcessQuarterlyCompanyData` ON SCHEDULE EVERY 1 MINUTE STARTS '2025-04-24 23:36:29' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
                IF (IS_FREE_LOCK('ProcessQuarterlyCompanyData') = 1) THEN
					SELECT GET_LOCK('ProcessQuarterlyCompanyData', 0);
					CALL stocks.ProcessQuarterlyData();
					SELECT RELEASE_LOCK('ProcessQuarterlyCompanyData');
				END IF;
        END */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
/*!50106 DROP EVENT IF EXISTS `ProcessRawDataThread0` */;;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = '' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`%`*/ /*!50106 EVENT `ProcessRawDataThread0` ON SCHEDULE EVERY 2 SECOND STARTS '2025-04-24 16:45:50' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN

			IF (IS_FREE_LOCK('ProcessRawDataThread0') = 1) THEN
            
				SELECT GET_LOCK('ProcessRawDataThread0', 0);
                
				CALL stocks.processRawTableLoop(4,0);

				SELECT RELEASE_LOCK('ProcessRawDataThread0');
                
			END IF;

        END */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
/*!50106 DROP EVENT IF EXISTS `ProcessRawDataThread1` */;;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = '' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`%`*/ /*!50106 EVENT `ProcessRawDataThread1` ON SCHEDULE EVERY 2 SECOND STARTS '2025-04-24 16:45:50' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN

			IF (IS_FREE_LOCK('ProcessRawDataThread1') = 1) THEN
            
				SELECT GET_LOCK('ProcessRawDataThread1', 0);
                
				CALL stocks.processRawTableLoop(4,1);

				SELECT RELEASE_LOCK('ProcessRawDataThread1');
                
			END IF;

        END */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
/*!50106 DROP EVENT IF EXISTS `ProcessRawDataThread2` */;;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = '' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`%`*/ /*!50106 EVENT `ProcessRawDataThread2` ON SCHEDULE EVERY 2 SECOND STARTS '2025-04-24 16:45:50' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN

			IF (IS_FREE_LOCK('ProcessRawDataThread2') = 1) THEN
            
				SELECT GET_LOCK('ProcessRawDataThread2', 0);
                
				CALL stocks.processRawTableLoop(4,2);

				SELECT RELEASE_LOCK('ProcessRawDataThread2');
                
			END IF;

        END */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
/*!50106 DROP EVENT IF EXISTS `ProcessRawDataThread3` */;;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = '' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`%`*/ /*!50106 EVENT `ProcessRawDataThread3` ON SCHEDULE EVERY 2 SECOND STARTS '2025-04-24 16:45:50' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN

			IF (IS_FREE_LOCK('ProcessRawDataThread3') = 1) THEN
            
				SELECT GET_LOCK('ProcessRawDataThread3', 0);
                
				CALL stocks.processRawTableLoop(4,3);

				SELECT RELEASE_LOCK('ProcessRawDataThread3');
                
			END IF;

        END */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
/*!50106 DROP EVENT IF EXISTS `UpdateCompanyOverviews` */;;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'UTC' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`%`*/ /*!50106 EVENT `UpdateCompanyOverviews` ON SCHEDULE EVERY 1 MINUTE STARTS '2025-04-08 16:45:13' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
                
			CALL stocks.RawCompanyOverviewToCompanyOverview();

        END */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
/*!50106 DROP EVENT IF EXISTS `UpdatePresentationStocks` */;;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'UTC' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`%`*/ /*!50106 EVENT `UpdatePresentationStocks` ON SCHEDULE EVERY 1 DAY STARTS '2025-04-06 15:33:41' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
                
				CALL stocks.UpdatePresentationStocks();

        END */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
DELIMITER ;
/*!50106 SET TIME_ZONE= @save_time_zone */ ;

--
-- Dumping routines for database 'stocks'
--
/*!50003 DROP PROCEDURE IF EXISTS `AnalyzeBoilerBand` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AnalyzeBoilerBand`(IN iStockID INT, IN StartDate DATETIME, IN EndDate DATETIME, IN iTimeIndicatorID INT)
BEGIN

	-- Bollinger Band Rules:
	-- Upper Band --> Over Bought
	-- Lower Band --> Over Sold
	-- Upper Band - lower Band = ABS(trends strength) --> Smaller the number = Less volatility --> likely big price movement --> BoilerBand Table WidthPercentage Column
	-- Upper Band - lower Band = ABS(trends strength) --> Bigger the number = More volatility --> likely big price movement --> BoilerBand Table WidthPercentage Column
	-- If price touches/goes above upper band --> likely overbought --> potential sell or short call opprotunity --> BoilerBand Table OutsideStdDev Column
	-- If price touches/goes below lower band --> likely oversold --> potential buy or Long call opprotunity --> BoilerBand Table OutsideStdDev Column
	-- If prices go outside of Upper/Lower band --> Signal it's over bought or over sold --> Can remain out of upper/lower band for a good amount of time --> BoilerBand Table OutsideStdDev Column
	-- Mean Revision --> When price oscilates between Upper/Lower Band --> Hitting Band likely signals large price movement
	-- New local Min/Max --> new trend or accelerating current trend --> likely to move in direction of breakout --> SP: bbGetLocalMinsAndMaxes --> LocalMaxAndMins temporary table --> PriceAndLocalBBMaxMins Temporary table

	-- Relationships to look at:
	-- Price touches or pushes through Upper Band  --> Overbought --> potential reversal --> Compare Price to Upper Band
	-- Price touches or pushes through Lower Band --> Oversold --> potential reversal --> Compare Price to Lower Band

	-- Exit Strategies:
	-- Lower/Upper bands can be used as exit marks
    
        -- Error Handler --
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 @errno = MYSQL_ERRNO, @ErrorMsg = MESSAGE_TEXT;
        insert into errorlog(ObjectName, ErrorNumber, ErrorMessage, CreatedDate)
        VALUES ('AnalyzeBoilerBand', @errno, @ErrorMsg, NOW());
    END;
    -- Error Handler End --
    
    CALL bbGetAllMinimumsAndMaximums(iStockID, StartDate,EndDate,iTimeIndicatorID);
    CALL bbGetLocalMinsAndMaxes();
    CALL bbCompareLocalMaxMinsToPrice(iStockID, StartDate,EndDate);
    
    
    SELECT * FROM PriceAndLocalBBMaxMins;
    
	

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AnalyzeMACD` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AnalyzeMACD`(IN iStockID INT, IN StartDate DATETIME, IN EndDate DATETIME, IN iTimeIndicatorID INT)
BEGIN
															  
-- X            X        X               X              X             X            X                X              X
-- MACD, Signal Line, Crossed Zero, TrendDirection, TrendChange, MACD Slope, MACD TrendSlope,MACD Local Mins, MACD Local Maxes


-- Definition --> MACD = 12-Period EMA - 26-Period EMA
-- Distance MACD is above/below Signal line = Base Line
-- When MACD > Signal line --> Overbought
-- When MACD < Signal line --> Oversold
-- When MACD falls below Signal line --> bearish signal --> might experience upward momentum --> CrossedZero = 1
-- When MACD rises above Signal line --> bullish signal --> might experience downward momentum --> CrossedZero = 1
-- Possible bullish/bearish confirmation for long term views when MACD crosses Signal line --> CrossedZero
-- Rapid rises or falls in MACD --> Indication security is overbought/oversold --> should return to normal levels soon --> combine with rsi --> MACD slope

-- THIS ONE:
-- MACD positive (bullish) --> MACD Doesn't reach new low when price of stock reaches new low --> movement should not last and should return to higher price
-- MACD negative (bearish) --> MACD Doesn't reach new high when price of stock reaches new high --> movement should not last and should return to lower price


-- Slope of MACD --> How strong/weak current uptrend/downtrend is --> higher slope = bullish/uptrend, lower slope = bearish/downtrend

-- Further MACD is from signal line --> more short term momentum stock may have

-- Should get ALL local Mins and local Maxes
-- Should be used with Daily Time Periods
-- Traditional Settings Reccommended 26 day EMA/12 day EMA/9 day --> Use weekly prices if trading daily
-- https://www.quantifiedstrategies.com/macd-and-bollinger-bands-strategy/#:~:text=This%20is%20a%20trend%2Dfollowing,out%20of%20the%20Bollinger%20Bands.
-- https://www.td.com/ca/en/investing/direct-investing/articles/bollinger-bands-and-macds


-- IMPORTANT TEMPORARY TABLES:
-- MACDSlopeInformation --> Holds all information about slopes
-- mdLocalMaxAndMins --> Holds all local Maxes/Mins
-- mdLocalMaxes --> Holds all local Maxes
-- mdLocalMins --> Holds all local Mins


			-- Error Handler --
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 @errno = MYSQL_ERRNO, @ErrorMsg = MESSAGE_TEXT;
        insert into errorlog(ObjectName, ErrorNumber, ErrorMessage, CreatedDate)
        VALUES ('AnalyzeMACD', @errno, @ErrorMsg, NOW());
    END;
			-- Error Handler End --
            
	CALL mdGetAllMinimumsAndMaximums(iStockID, StartDate, EndDate, iTimeIndicatorID); 
	CALL mdGetLocalMinsAndMaxes();
	CALL mdGetSlope(iStockID, StartDate, EndDate);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `bbCompareLocalMaxMinsToPrice` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `bbCompareLocalMaxMinsToPrice`(IN iStockID INT, IN StartDate DATETIME, IN EndDate DATETIME)
BEGIN
	-- Compare prices to local Maxes and Mins to determine if price ever touches/goes near local Max/Mins
    -- Creates temporary table: PriceAndLocalBBMaxMins
    
    DECLARE MinMinbbDateTime DATETIME;
    DECLARE MinMaxbbDateTime DATETIME;
    
    DECLARE SmallestMax DECIMAL(20,5);
    DECLARE SmallestMin DECIMAL(20,5);
    
        -- Error Handler --
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 @errno = MYSQL_ERRNO, @ErrorMsg = MESSAGE_TEXT;
        insert into errorlog(ObjectName, ErrorNumber, ErrorMessage, CreatedDate)
        VALUES ('bbCompareLocalMaxMinsToPrice', @errno, @ErrorMsg, NOW());
    END;
    -- Error Handler End --
    
	DROP TEMPORARY TABLE IF EXISTS PriceAndLocalBBMaxMins;
	CREATE TEMPORARY TABLE IF NOT EXISTS PriceAndLocalBBMaxMins
	SELECT fd.FinancialDataID, fd.StockDate, fd.`Open`,fd.`Close`, lmm.`BandValue` AS BoilerBandMaxValue, lmm.`BandValue` AS BoilerBandMinValue, lmm.`MinOrMax`, lmm.NextMinMaxStockDate FROM FinancialData fd LEFT OUTER JOIN bbLocalMaxAndMins lmm ON fd.FinancialDataID = lmm.FinancialDataID
	WHERE fd.StockID = iStockID AND fd.StockDate BETWEEN StartDate AND EndDate ORDER BY fd.StockDate ASC;
        
	SELECT MIN(StockDate) INTO MinMinbbDateTime FROM bbLocalMaxAndMins WHERE MinOrMax = 'Min';
	SELECT MIN(StockDate) INTO MinMaxbbDateTime FROM bbLocalMaxAndMins WHERE MinOrMax = 'Max';
	
    SELECT BandValue INTO SmallestMin FROM bbLocalMaxAndMins WHERE MinOrMax = 'Min' AND StockDate = MinMinbbDateTime;
	SELECT BandValue INTO SmallestMax FROM bbLocalMaxAndMins WHERE MinOrMax = 'Max' AND StockDate = MinMaxbbDateTime;
	
	UPDATE PriceAndLocalBBMaxMins palbbmm JOIN bbLocalMaxAndMins lmm
	SET palbbmm.`BoilerBandMaxValue` = lmm.`BandValue`
	WHERE palbbmm.StockDate >= lmm.`StockDate` AND palbbmm.StockDate < lmm.`NextMinMaxStockDate` AND lmm.`MinOrMax` = 'Max';

	UPDATE PriceAndLocalBBMaxMins palbbmm JOIN bbLocalMaxAndMins lmm
	SET palbbmm.`BoilerBandMinValue` = lmm.`BandValue`
	WHERE palbbmm.StockDate >= lmm.`StockDate` AND palbbmm.StockDate < lmm.`NextMinMaxStockDate` AND lmm.`MinOrMax` = 'Min';

	UPDATE PriceAndLocalBBMaxMins
	SET BoilerBandMinValue = SmallestMin
	WHERE StockDate < MinMinbbDateTime;

	UPDATE PriceAndLocalBBMaxMins
	SET BoilerBandMaxValue = SmallestMax
	WHERE StockDate < MinMaxbbDateTime;
    
    
    
    -- Calculates distance from upper/lower band to close price
	/*
    ALTER TABLE PriceAndLocalBBMaxMins
    ADD DistanceFromMaxBandValueClosePrice FLOAT,
    ADD DistanceFromMinBandValueClosePrice FLOAT;
	UPDATE PriceAndLocalBBMaxMins SET DistanceFromMaxBandValueClosePrice = (BoilerBandMaxValue - `Close`), DistanceFromMinBandValueClosePrice = (`Close` - BoilerBandMinValue);
    */
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `bbGetAllMinimumsAndMaximums` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `bbGetAllMinimumsAndMaximums`(IN iStockID INT, IN StartDate DATETIME, IN EndDate DATETIME, IN iTimeIndicatorID INT)
BEGIN
	-- This SP returns all the Min/Maxes for the boiler band table in a specific time range (Start Date - End Date) for the StockID
    -- Time Indicator ID will define each chunk of data:
    -- Ex: 1 Hour --> all time from Start Date to Start Date + 1 Hour will have a single minimum and maximum
    -- Places All Mins in the below Temporary Tables:
    -- bbTimeFrameMins
    -- bbTimeFrameMaxes
    
    DECLARE vTimeFrame VARCHAR(255) DEFAULT '';
    DECLARE vGroupByDateFormat VARCHAR(255) DEFAULT '';
	
        -- Error Handler --
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 @errno = MYSQL_ERRNO, @ErrorMsg = MESSAGE_TEXT;
        insert into errorlog(ObjectName, ErrorNumber, ErrorMessage, CreatedDate)
        VALUES ('bbGetAllMinimumsAndMaximums', @errno, @ErrorMsg, NOW());
    END;
    -- Error Handler End --
    
    -- Get the Time amount and unit we're using to look at minimums
    SELECT CONCAT(TRIM(AmountOfTimeUnit), ' ', TRIM(TimeUnit)) , GroupByDateFormat INTO vTimeFrame, vGroupByDateFormat FROM TimeIndicator WHERE TimeIndicatorID = iTimeIndicatorID;
    
    -- Only grabs BoilerBand data that pertains to this stock + time frame
	DROP TEMPORARY TABLE IF EXISTS RelevantBoilerBand;
	CREATE TEMPORARY TABLE IF NOT EXISTS RelevantBoilerBand
	SELECT bb.BoilerBandID, bb.FinancialDataID, fd.StockDate, fd.`Close`, bb.Lower, bb.Middle, bb.Upper, bb.WidthPercentage, bb.OutsideStdDev, bb.AmountOutStdDev FROM BoilerBand bb INNER JOIN FinancialData fd ON (bb.FinancialDataID = fd.FinancialDataID AND fd.StockID = iStockID)
	WHERE fd.StockDate BETWEEN StartDate AND EndDate AND fd.StockID = iStockID;

	-- Grabs minimum value in each set time amount and unit
	DROP TEMPORARY TABLE IF EXISTS bbTimeFrameMins;
    CREATE TEMPORARY TABLE IF NOT EXISTS bbTimeFrameMins (
    StockDate DATETIME, LowerBandMin DECIMAL(20,5), BoilerBandID INT PRIMARY KEY,FinancialDataID INT);
    
	INSERT INTO bbTimeFrameMins (BoilerBandID)
	SELECT DISTINCT FIRST_VALUE(BoilerBandID) OVER (PARTITION BY DATE_FORMAT(StockDate, vGroupByDateFormat) ORDER BY `Lower` ASC) FROM RelevantBoilerBand;
	
    UPDATE bbTimeFrameMins tfm LEFT OUTER JOIN RelevantBoilerBand rbb ON tfm.BoilerBandID =rbb.BoilerBandID
    SET tfm.StockDate = rbb.StockDate, tfm.LowerBandMin = rbb.`Lower`, tfm.FinancialDataID = rbb.FinancialDataID
    WHERE rbb.BoilerBandID > 1;

    -- Grabs maximum value in each set time amount and unit
    DROP TEMPORARY TABLE IF EXISTS bbTimeFrameMaxes;
    CREATE TEMPORARY TABLE IF NOT EXISTS bbTimeFrameMaxes (
    StockDate DATETIME, UpperBandMax DECIMAL(20,5), BoilerBandID INT PRIMARY KEY, FinancialDataID INT);
    
	INSERT INTO bbTimeFrameMaxes (BoilerBandID)
	SELECT DISTINCT FIRST_VALUE(BoilerBandID) OVER (PARTITION BY DATE_FORMAT(StockDate, vGroupByDateFormat) ORDER BY `Upper` DESC) FROM RelevantBoilerBand;
	
    UPDATE bbTimeFrameMaxes tfm LEFT OUTER JOIN RelevantBoilerBand rbb ON tfm.BoilerBandID =rbb.BoilerBandID
    SET tfm.StockDate = rbb.StockDate, tfm.UpperBandMax = rbb.`Upper`, tfm.FinancialDataID = rbb.FinancialDataID
    WHERE rbb.BoilerBandID > 1;
   
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `bbGetLocalMinsAndMaxes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `bbGetLocalMinsAndMaxes`()
BEGIN
	-- This SP must be ran after bbGetAllMinimumsAndMaximums SP --> Uses temporary tables created in that SP
    -- This will look at all the mins/maxes and find the local mins and local maxes
    -- Outputs all results in: bbLocalMaxAndMins, bbLocalMaxes, bbLocalMins
    
                -- Error Handler --
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 @errno = MYSQL_ERRNO, @ErrorMsg = MESSAGE_TEXT;
        insert into errorlog(ObjectName, ErrorNumber, ErrorMessage, CreatedDate)
        VALUES ('bbGetLocalMinsAndMaxes', @errno, @ErrorMsg, NOW());
    END;
		-- Error Handler End --

	DROP TEMPORARY TABLE IF EXISTS bbLocalMaxes;
	CREATE TEMPORARY TABLE IF NOT EXISTS bbLocalMaxes (
    FinancialDataID INT, BoilerBandID INT PRIMARY KEY, StockDate DATETIME, UpperBandMax DECIMAL(20,5), bbMaxRank INT, bbLastMax INT);
	
    SET @iLastBBMaxRank = 100000000;
    
    -- Gets the ranking of all the BoilerBand Maxes
	INSERT INTO bbLocalMaxes(bbMaxRank, BoilerBandID, FinancialDataID, StockDate, UpperBandMax)
	SELECT DENSE_RANK() OVER (ORDER BY UpperBandMax DESC) as bbMaxRank, BoilerBandID, FinancialDataID, StockDate, UpperBandMax
    FROM bbTimeFrameMaxes 
    WHERE UpperBandMax IS NOT NULL
	ORDER BY bbMaxRank ASC;
    
    -- Updates bbLastMax only if the BoilerBand rank is the lowest seen so far ordered by stock date
    UPDATE bbLocalMaxes SET bbLastMax = 
		CASE WHEN bbMaxRank < @iLastBBMaxRank THEN bbMaxRank AND @iLastBBMaxRank := bbMaxRank 
        ELSE NULL END
        ORDER BY StockDate ASC;

	DROP TEMPORARY TABLE IF EXISTS bbLocalMins;
	CREATE TEMPORARY TABLE IF NOT EXISTS bbLocalMins (
    FinancialDataID INT, BoilerBandID INT PRIMARY KEY, StockDate DATETIME, LowerBandMin DECIMAL(20,5), bbMinRank INT, bbLastMin INT);
	
    SET @iLastBBMinRank = 100000000;
    
    -- Gets the ranking of all the BoilerBand Mins
	INSERT INTO bbLocalMins(bbMinRank, BoilerBandID, FinancialDataID, StockDate, LowerBandMin)
	SELECT DENSE_RANK() OVER (ORDER BY LowerBandMin ASC) as bbMinRank, BoilerBandID, FinancialDataID, StockDate, LowerBandMin
    FROM bbTimeFrameMins 
    WHERE LowerBandMin IS NOT NULL
	ORDER BY bbMinRank ASC;
    
    -- Updates bbLocalMins only if the BoilerBand rank is the lowest seen so far ordered by stock date
    UPDATE bbLocalMins SET bbLastMin = 
		CASE WHEN bbMinRank < @iLastBBMinRank THEN bbMinRank AND @iLastBBMinRank := bbMinRank 
        ELSE NULL END
        ORDER BY StockDate ASC;
        
	DROP TEMPORARY TABLE IF EXISTS bbLocalMaxAndMins;
	CREATE TEMPORARY TABLE IF NOT EXISTS bbLocalMaxAndMins (
    FinancialDataID INT, BoilerBandID INT PRIMARY KEY, NextMinMaxStockDate DATETIME, StockDate DATETIME, BandValue DECIMAL(20,5), MinOrMax VARCHAR(255));
	
    INSERT INTO bbLocalMaxAndMins(FinancialDataID, BoilerBandID, NextMinMaxStockDate, StockDate, BandValue, MinOrMax)
	SELECT FinancialDataID, BoilerBandID, IFNULL(LEAD(StockDate) OVER (ORDER BY StockDate ASC), StockDate), StockDate, UpperBandMax, 'Max' FROM bbLocalMaxes WHERE bbLastMax IS NOT NULL ORDER BY StockDate ASC;

    INSERT INTO bbLocalMaxAndMins(FinancialDataID, BoilerBandID, NextMinMaxStockDate, StockDate, BandValue, MinOrMax)
	SELECT FinancialDataID, BoilerBandID, IFNULL(LEAD(StockDate) OVER (ORDER BY StockDate ASC), StockDate), StockDate, LowerBandMin, 'Min' FROM bbLocalMins WHERE bbLastMin IS NOT NULL ORDER BY StockDate ASC;

    
    /*
    DECLARE finished INT DEFAULT 0;
    
    DECLARE MinDate DATETIME;
    DECLARE fMinBandValue DECIMAL(20,5);
    DECLARE iMinBoilerBandID INT;
    DECLARE iMinFinancialDataID INT;
    
	DECLARE MaxDate DATETIME;
    DECLARE fMaxBandValue DECIMAL(20,5);
    DECLARE iMaxBoilerBandID INT;
    DECLARE iMaxFinancialDataID INT;
	
    DECLARE fLocalMinValue DECIMAL(20,5);
    DECLARE fLocalMaxValue DECIMAL(20,5);
    
    DECLARE oldMinDate DATETIME;
    DECLARE oldMaxDate DATETIME;
    
	DECLARE GetLocalMins CURSOR FOR SELECT StockDate, LowerBandMin, BoilerBandID, FinancialDataID FROM TimeFrameMins ORDER BY StockDate ASC;
	DECLARE GetLocalMaxes CURSOR FOR SELECT StockDate, UpperBandMax, BoilerBandID, FinancialDataID FROM TimeFrameMaxes ORDER BY StockDate ASC;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;
    
            -- Error Handler --
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 @errno = MYSQL_ERRNO, @ErrorMsg = MESSAGE_TEXT;
        insert into errorlog(ObjectName, ErrorNumber, ErrorMessage, CreatedDate)
        VALUES ('bbGetLocalMinsAndMaxes', @errno, @ErrorMsg, NOW());
    END;
		-- Error Handler End --
    
    DROP TEMPORARY TABLE IF EXISTS LocalMaxAndMins;
	CREATE TEMPORARY TABLE IF NOT EXISTS LocalMaxAndMins (BoilerBandID INT, FinancialDataID INT, MaxOrMinDate DATETIME, `MaxValue` FLOAT, `MinValue` FLOAT, `Max` INT, `Min` INT, LastMaxMinDate DATETIME, LastMaxMinLength FLOAT);
    
    OPEN GetLocalMins;
    OPEN GetLocalMaxes;
    
    GetLocalMinAndMax: LOOP
		FETCH GetLocalMins INTO MinDate, fMinBandValue, iMinBoilerBandID, iMinFinancialDataID;
		FETCH GetLocalMaxes INTO MaxDate, fMaxBandValue, iMaxBoilerBandID, iMaxFinancialDataID;
        
        IF (finished = 1) THEN
			LEAVE GetLocalMinAndMax;
		ELSE
			CASE
				WHEN ((SELECT COUNT(*) FROM LocalMaxAndMins) = 0) THEN 
					
					INSERT INTO LocalMaxAndMins(BoilerBandID, FinancialDataID, MaxOrMinDate, `MaxValue`,`MinValue`, `Max`, `Min`, LastMaxMinLength)
					VALUES (iMinBoilerBandID, iMinFinancialDataID, MinDate, NULL, fMinBandValue, 0, 1, 0),
					(iMaxBoilerBandID, iMaxFinancialDataID, MaxDate, fMaxBandValue,NULL, 1, 0, 0);
					
					SET fLocalMinValue = fMinBandValue;
                    SET oldMinDate = MinDate;
					SET fLocalMaxValue = fMaxBandValue;
                    SET oldMaxDate = MaxDate;
					
				WHEN (fLocalMinValue > fMinBandValue) THEN
				
					INSERT INTO LocalMaxAndMins(BoilerBandID, FinancialDataID, MaxOrMinDate, `MaxValue`,`MinValue`, `Max`,`Min`,LastMaxMinDate, LastMaxMinLength)
					VALUES (iMinBoilerBandID, iMinFinancialDataID, MinDate, NULL, fMinBandValue, 0, 1, oldMinDate, TIMESTAMPDIFF(MINUTE, oldMinDate, MinDate));
					
					SET fLocalMinValue = fMinBandValue;
					SET oldMinDate = MinDate;
                    
				WHEN (fLocalMaxValue < fMaxBandValue) THEN
					
					INSERT INTO LocalMaxAndMins(BoilerBandID, FinancialDataID, MaxOrMinDate, `MaxValue`,`MinValue`, `Max`,`Min`, LastMaxMinDate, LastMaxMinLength)
					VALUES (iMaxBoilerBandID, iMaxFinancialDataID, MaxDate, fMaxBandValue, NULL, 1, 0, oldMaxDate, TIMESTAMPDIFF(MINUTE, oldMaxDate, MaxDate));
					
					SET fLocalMaxValue = fMaxBandValue;
                    SET oldMaxDate = MaxDate;
				ELSE 
					BEGIN
                    END;
			END CASE;
        END IF;
	END LOOP GetLocalMinAndMax;
    
    CLOSE GetLocalMins;
    CLOSE GetLocalMaxes;
    */
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CalculateBoilerBandMinMax` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CalculateBoilerBandMinMax`(IN iStockID INT, IN iStartingFinancialDataID INT,IN iEndFinancialDataID INT)
BEGIN
	
    -- NEED TO FINISH ADD CHOICE TO PICK OPEN/MID/CLOSE PRICE IN SETTINGS
    
    DECLARE iRelativeMin DECIMAL(20,5) DEFAULT 0;    
	DECLARE iRelativeMax DECIMAL(20,5) DEFAULT 0;
    
    -- Loop variables
	DECLARE iPrice DECIMAL(20,5) DEFAULT 0;
    DECLARE iLower DECIMAL(20,5) DEFAULT 0;
    DECLARE iUpper DECIMAL(20,5) DEFAULT 0;
    DECLARE iFinancialDataID INT DEFAULT 0;
    DECLARE iAmountOutsideStdDeviation DECIMAL(20,5) DEFAULT 0;
    DECLARE finished INT DEFAULT 0;
    
	DECLARE RelativeMinMaxLoop CURSOR FOR SELECT FinancialDataID, Close, Lower, Upper, AmountOutStdDev FROM PriceBBLowerUpper ORDER BY FinancialDataID ASC;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;
    -- ADD Open/Mid/Close Price choice select query settings

    
    IF(iEndFinancialDataID IS NULL OR iEndFinancialDataID = 0) THEN 
		SELECT MAX(FinancialDataID) INTO iEndFinancialDataID FROM FinancialData WHERE StockID = iStockID;
    END IF;
    
    SELECT financialdata.Close INTO iRelativeMin FROM FinancialData WHERE FinancialDataID = iStartingFinancialDataID;
    SET iRelativeMax = iRelativeMin;
    
    DROP TEMPORARY TABLE IF EXISTS PriceBBLowerUpper;
    
    CREATE TEMPORARY TABLE IF NOT EXISTS PriceBBLowerUpper
		SELECT fd.FinancialDataID AS FinancialDataID, fd.Close AS Close, bb.Lower AS Lower, bb.Upper AS Upper, bb.AmountOutStdDev AS AmountOutStdDev  FROM FinancialData fd INNER JOIN boilerband bb ON fd.FinancialDataID = bb. FinancialDataID
        WHERE fd.StockID = iStockID AND bb.OutsideStdDev = 1 AND bb.FinancialDataID BETWEEN iStartingFinancialDataID AND iEndFinancialDataID;
    
    
    DROP TEMPORARY TABLE IF EXISTS BoilerBandRelativeMinMax;
    
    CREATE TEMPORARY TABLE IF NOT EXISTS BoilerBandRelativeMinMax 
		(FinancialDataID INT PRIMARY KEY, ClosePrice DECIMAL(20,5), AmountOutsideStdDeviation DECIMAL(20, 5), RelativeMinOrMax INT);
    
    OPEN RelativeMinMaxLoop;
    CalculateMinMax: LOOP
		FETCH RelativeMinMaxLoop INTO iFinancialDataID, iPrice, iLower, iUpper, iAmountOutsideStdDeviation;
		
        IF (finished = 1) THEN 
			LEAVE CalculateMinMax;
        END IF;
        
        IF(iPrice < iLower AND iPrice < iRelativeMin) THEN
        
            INSERT INTO BoilerBandRelativeMinMax(FinancialDataID, ClosePrice, AmountOutsideStdDeviation, RelativeMinOrMax)
				VALUES (iFinancialDataID, iPrice, iAmountOutsideStdDeviation, 1);
                
			SET iRelativeMin = iPrice;
		END IF;
        
        IF(iPrice > iUpper AND iPrice > iRelativeMax) THEN
            
			INSERT INTO BoilerBandRelativeMinMax(FinancialDataID, ClosePrice, AmountOutsideStdDeviation, RelativeMinOrMax)
				VALUES (iFinancialDataID, iPrice, iAmountOutsideStdDeviation, 2);
			
            SET iRelativeMax = iPrice;
            
        END IF;
	END LOOP CalculateMinMax;
    CLOSE RelativeMinMaxLoop;
    
    SELECT * FROM BoilerBandRelativeMinMax;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CalculateDeltaBoilerBands` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CalculateDeltaBoilerBands`(IN iStockID INT, IN iMinStockDate DateTime)
BEGIN
    
    -- Error Handler --
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 @errno = MYSQL_ERRNO, @ErrorMsg = MESSAGE_TEXT;
        insert into errorlog(ObjectName, ErrorNumber, ErrorMessage, CreatedDate)
        VALUES ('CalculateDeltaBoilerBands', @errno, @ErrorMsg, NOW());
    END;
    -- Error Handler End --

	
    SET SQL_SAFE_UPDATES = 0;
    
    UPDATE boilerband bb INNER JOIN FinancialData fd ON bb.FinancialDataID = fd.FinancialDataID
		SET bb.OutsideStdDev = 1, bb.AmountOutStdDev = ((1 - (bb.`Upper`/fd.`Close`)) * 100), bb.UpdatedDate = NOW() 
        WHERE bb.StockID = iStockID AND fd.StockID = iStockID AND fd.`Close` > bb.`Upper` AND bb.`Upper` > 0 AND fd.StockDate >= iMinStockDate;
        
	UPDATE boilerband bb INNER JOIN FinancialData fd ON bb.FinancialDataID = fd.FinancialDataID
		SET bb.OutsideStdDev = 1, bb.AmountOutStdDev = ((1 - (fd.`Close`/bb.`Lower`)) * 100), bb.UpdatedDate = NOW() 
        WHERE bb.StockID = iStockID AND fd.StockID = iStockID AND fd.`Close` < bb.`Lower` AND bb.`Lower` > 0 AND fd.StockDate >= iMinStockDate;
        

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CleanUpApril202025` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `CleanUpApril202025`()
BEGIN
	
           -- Error Handler --
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 @errno = MYSQL_ERRNO, @ErrorMsg = MESSAGE_TEXT;
        insert into errorlog(ObjectName, ErrorNumber, ErrorMessage, CreatedDate)
        VALUES ('CleanUpApril202025', @errno, @ErrorMsg, NOW());
    END;
    -- Error Handler End --
    
    SET SQL_SAFE_UPDATES = 0;
    /*
	DELETE FROM financialdata WHERE FinancialDataID IN (SELECT FinancialDataID FROM sar WHERE StockID = 0);
	DELETE FROM financialdata WHERE FinancialDataID IN (SELECT FinancialDataID FROM macd WHERE StockID = 0);
	DELETE FROM financialdata WHERE FinancialDataID IN (SELECT FinancialDataID FROM directionalmovement WHERE StockID = 0);
	DELETE FROM financialdata WHERE FinancialDataID IN (SELECT FinancialDataID FROM boilerband WHERE StockID = 0);
	DELETE FROM financialdata WHERE FinancialDataID IN (SELECT FinancialDataID FROM chaikinoscillator WHERE StockID = 0);
	*/
    
	DELETE FROM financialdata WHERE FinancialDataID IN (SELECT FinancialDataID FROM directionalmovement WHERE DMIPlus IS NOT NULL AND DMIMinus IS NULL);
	DELETE FROM sar WHERE FinancialDataID IN (SELECT FinancialDataID FROM directionalmovement WHERE DMIPlus IS NOT NULL AND DMIMinus IS NULL);
	DELETE FROM macd WHERE FinancialDataID IN (SELECT FinancialDataID FROM directionalmovement WHERE DMIPlus IS NOT NULL AND DMIMinus IS NULL);
	DELETE FROM boilerband WHERE FinancialDataID IN (SELECT FinancialDataID FROM directionalmovement WHERE DMIPlus IS NOT NULL AND DMIMinus IS NULL);
	DELETE FROM chaikinoscillator WHERE FinancialDataID IN (SELECT FinancialDataID FROM directionalmovement WHERE DMIPlus IS NOT NULL AND DMIMinus IS NULL);
	DELETE FROM directionalmovement WHERE DMIPlus IS NOT NULL AND DMIMinus IS NULL;


	DELETE FROM sar WHERE StockID = 0;
	DELETE FROM macd WHERE StockID = 0;
	DELETE FROM directionalmovement WHERE StockID = 0;
	DELETE FROM boilerband WHERE StockID = 0;
	DELETE FROM chaikinoscillator WHERE StockID = 0;
    
    DELETE boilerband FROM boilerband LEFT OUTER JOIN financialdata ON boilerband.FinancialDataID = financialdata.FinancialDataID WHERE financialdata.FinancialDataID IS NULL;
    DELETE sar FROM sar LEFT OUTER JOIN financialdata ON sar.FinancialDataID = financialdata.FinancialDataID WHERE financialdata.FinancialDataID IS NULL;
    DELETE directionalmovement FROM directionalmovement LEFT OUTER JOIN financialdata ON directionalmovement.FinancialDataID = financialdata.FinancialDataID WHERE financialdata.FinancialDataID IS NULL;
    DELETE macd FROM macd LEFT OUTER JOIN financialdata ON macd.FinancialDataID = financialdata.FinancialDataID WHERE financialdata.FinancialDataID IS NULL;
	DELETE chaikinoscillator FROM chaikinoscillator LEFT OUTER JOIN financialdata ON chaikinoscillator.FinancialDataID = financialdata.FinancialDataID WHERE financialdata.FinancialDataID IS NULL;
	
    
    OPTIMIZE TABLE financialdata;
	OPTIMIZE TABLE sar;
	OPTIMIZE TABLE macd;
	OPTIMIZE TABLE directionalmovement;
	OPTIMIZE TABLE boilerband;
	OPTIMIZE TABLE chaikinoscillator;

	CREATE TEMPORARY TABLE tt
	SELECT StockID, MAX(StockDate) AS LastStockDate FROM financialdata GROUP BY StockID;

	UPDATE stock s INNER JOIN tt on s.StockID = tt.StockID
	SET s.LastStockDate = tt.LastStockDate, s.UpdatedDate = tt.LastStockDate;

	DROP TEMPORARY TABLE tt;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CreateFinancialDataParentChild` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CreateFinancialDataParentChild`(IN iStockID INT)
BEGIN
    
        -- Error Handler --
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 @errno = MYSQL_ERRNO, @ErrorMsg = MESSAGE_TEXT;
        insert into errorlog(ObjectName, ErrorNumber, ErrorMessage, CreatedDate)
        VALUES ('CreateFinancialDataParentChild', @errno, @ErrorMsg, NOW());
    END;
    -- Error Handler End --
    
    SET SQL_SAFE_UPDATES = 0;
    
	
    DELETE FROM financialdataparentchild WHERE StockID = iStockID;
    
    INSERT INTO financialdataparentchild(FinancialDataID, ParentFinancialDataID, StockID)
		SELECT  LAG(FinancialDataID) OVER (PARTITION BY StockID ORDER BY StockDate ASC) AS FinancialDataID, FinancialDataID AS ParentFinancialDataID, iStockID  FROM FinancialData 
        WHERE StockID = iStockID;

		-- SELECT (FinancialDataID + 1), FinancialDataID, iStockID FROM financialdata WHERE (FinancialDataID + 1) BETWEEN iStartingFinancialDataID AND iLastFinancialDataID AND StockID = iStockID;

-- If this starts to become a problem use this select statement instead --> Cost more to run --> More accurate	
-- SELECT  LAG(FinancialDataID) OVER (PARTITION BY StockID ORDER BY StockDate ASC) AS FinancialDataID, FinancialDataID AS ParentFinancialDataID  FROM FinancialData WHERE StockID = iStockID AND FinancialDataID BETWEEN iStartingFinancialDataID AND iLastFinancialDataID;

    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CreateIndicatorGroupMapping` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CreateIndicatorGroupMapping`()
BEGIN

	DECLARE finished INT DEFAULT 0;
    DECLARE iIndicatorID INT DEFAULT 0;
    
    DECLARE vAllNames VARCHAR(1000) DEFAULT '';
    DECLARE vName VARCHAR(255);
    
    DECLARE iNewQuantityIndicatorID INT DEFAULT 0;
    DECLARE iOldQuantityIndicatorID INT DEFAULT 0;

	DECLARE iIndicatorGroupID INT DEFAULT 0;
    DECLARE iMaxIndicators INT DEFAULT 0;
    
    DECLARE GetAllIndicatorIDs CURSOR FOR SELECT IndicatorID, `Name` FROM stocks.indicator WHERE `Active` = 1 ORDER BY IndicatorID ASC; 
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;
    
    -- Error Handler --
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 @errno = MYSQL_ERRNO, @ErrorMsg = MESSAGE_TEXT;
        insert into errorlog(ObjectName, ErrorNumber, ErrorMessage, CreatedDate)
        VALUES ('CreateIndicatorGroupMapping', @errno, @ErrorMsg, NOW());
    END;
    -- Error Handler End --
    
    CALL CreateTotalQuantityIndicatorGroups(iNewQuantityIndicatorID);
    
    SELECT COUNT(*) INTO iMaxIndicators FROM Indicator WHERE `Active` = 1;
    
	OPEN GetAllIndicatorIDs;
		UpdateAllIndicatorGroups: LOOP
			FETCH GetAllIndicatorIDs INTO iIndicatorID, vName;
				IF finished = 1 THEN
					LEAVE UpdateAllIndicatorGroups;
				ELSE
					SELECT COUNT(IndicatorID) INTO iOldQuantityIndicatorID FROM IndicatorGroupMapping WHERE IndicatorID = iIndicatorID;
                    
                    IF (iOldQuantityIndicatorID <> iNewQuantityIndicatorID) THEN
                    
						-- Adding an entry for the solo indicator
						IF (iOldQuantityIndicatorID = 0) THEN 
							
                            SELECT MAX(IndicatorGroupID) INTO iIndicatorGroupID FROM IndicatorGroup WHERE `Name` LIKE 'NewIndicatorGroup_%';
							
                            UPDATE IndicatorGroup SET `Name` = vName WHERE IndicatorGroupID = iIndicatorGroupID;
                            
							INSERT INTO IndicatorGroupMapping(`IndicatorID`, `IndicatorGroupID`, `Active`)
                            VALUES (iIndicatorID, iIndicatorGroupID, 1);
                            
                            SET iOldQuantityIndicatorID = 1;
						END IF;
                        
                        -- Adding an entry for the maximum number of indicators in a group
						IF (SELECT MAX(COUNT(IndicatorID)) FROM IndicatorGroupMapping WHERE `Active` = 1 GROUP BY IndicatorGroupID <> iMaxIndicators) THEN 
							
							SELECT MAX(IndicatorGroupID) INTO iIndicatorGroupID FROM IndicatorGroup WHERE `Name` LIKE 'NewIndicatorGroup_%';
							
							SELECT GROUP_CONCAT(`Name` SEPARATOR '_') INTO vAllNames FROM Indicator WHERE `Active` = 1;
							
							UPDATE IndicatorGroup SET `Name` = vAllNames WHERE IndicatorGroupID = iIndicatorGroupID;
							
							INSERT INTO IndicatorGroupMapping(`IndicatorID`, `IndicatorGroupID`, `Active`)
							SELECT IndicatorID, iIndicatorGroupID, 1 FROM Indicator WHERE `Active` = 1;
                            
						END IF;
						/*
                        NEEDS FINISHING!!!!
                        SELECT IndicatorGroupID, GROUP_CONCAT(IndicatorID), COUNT(IndicatorID) FROM IndicatorGroupMapping WHERE `Active` = 1 GROUP BY IndicatorGroupID HAVING FIND_IN_SET(iIndicatorID,GROUP_CONCAT(indicatorID)) ORDER BY IndicatorID DESC;
                        
                        IF(iOldQuantityIndicatorID = iMaxIndicators)
							
						END IF;*/
                    
				END IF;
			END IF;
		END LOOP UpdateAllIndicatorGroups;
    CLOSE GetAllIndicatorIDs;  
    
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CreateTotalQuantityIndicatorGroups` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CreateTotalQuantityIndicatorGroups`(IN iCombinationSelection INT,OUT iNumIndicatorID INT)
BEGIN

	-- iCombinationSelection --> 1 = n^2 -1
    -- iCombinationSelection --> 2 = n * 2 -1
    DECLARE iOldTotalIndicatorGroup int DEFAULT 0;
    DECLARE iNewTotalIndicatorGroup int DEFAULT 0;
    DECLARE iNewGroupRequiredCounter int DEFAULT 0;

    -- Error Handler --
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 @errno = MYSQL_ERRNO, @ErrorMsg = MESSAGE_TEXT;
        insert into errorlog(ObjectName, ErrorNumber, ErrorMessage, CreatedDate)
        VALUES ('CreateTotalQuantityIndicatorGroups', @errno, @ErrorMsg, NOW());
    END;
    -- Error Handler End --
	
    SELECT COUNT(IndicatorGroupID) INTO iOldTotalIndicatorGroup FROM IndicatorGroup WHERE `Active` = 1; 
    
    IF (iCombinationSelection = 1) THEN
		-- total new indicator groups should be 2^n - 1 
		-- n = total number of active indactorIDs
		SELECT (POWER(2,COUNT(IndicatorID)) - 1) INTO iNewTotalIndicatorGroup FROM stocks.indicator WHERE `Active` = 1;
        
        SET iNumIndicatorID = (iNewTotalIndicatorGroup + 1) /2;
        
	ELSEIF (iCombinationSelection = 2) THEN
    
		SELECT ((COUNT(IndicatorID) * 2) - 1) INTO iNewTotalIndicatorGroup FROM stocks.indicator WHERE `Active` = 1;
        
		SET iNumIndicatorID = (iNewTotalIndicatorGroup + 1) /2;

	END IF;
    
		SET iNewGroupRequiredCounter = (iNewTotalIndicatorGroup - iOldTotalIndicatorGroup);
		
		IF ( iNewGroupRequiredCounter > 0 ) THEN
			
			NewGroupCreation: WHILE iNewGroupRequiredCounter > 0 DO
			
				INSERT INTO IndicatorGroup(`Name`, `Active`)
				VALUES (CONCAT('NewIndicatorGroup_', iNewGroupRequiredCounter), 1);
				
				SET iNewGroupRequiredCounter = iNewGroupRequiredCounter - 1;
				
			END WHILE NewGroupCreation;
			
		END IF;
			
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CreateUpdateADXTrendChange` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CreateUpdateADXTrendChange`(IN iStockID INT, IN StartDate DATETIME, IN EndDate DATETIME)
BEGIN

    -- DECLARE iSettingsDefaultValue INT;
    
            -- Error Handler --
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 @errno = MYSQL_ERRNO, @ErrorMsg = MESSAGE_TEXT;
        insert into errorlog(ObjectName, ErrorNumber, ErrorMessage, CreatedDate)
        VALUES ('CreateUpdateADXTrendChange', @errno, @ErrorMsg, NOW());
    END;
    -- Error Handler End --

    SET SQL_SAFE_UPDATES = 0;
    
    IF (StartDate IS NULL) THEN
		SELECT StockDate INTO StartDate FROM directionalmovement WHERE StockID = iStockID ORDER BY StockDate ASC LIMIT 1;
	END IF;
    
    IF (EndDate IS NULL) THEN
		SELECT StockDate INTO EndDate FROM directionalmovement WHERE StockID = iStockID ORDER BY StockDate DESC LIMIT 1;
	END IF;
    	
    CREATE TEMPORARY TABLE IF NOT EXISTS t
		SELECT dm.DirectionalMovementID, dm.StockDate, LAG(dm.TrendDirection) OVER (PARTITION BY dm.StockID ORDER BY dm.StockDate DESC) AS LastDirection, TrendDirection AS CurrentDirection
		FROM directionalmovement dm 
        -- INNER JOIN financialdata fd ON dm.FinancialDataID = fd.FinancialDataID
		WHERE 
        -- d.StockID = iStockID AND 
        dm.StockID = iStockID AND TrendDirection > -1 AND dm.StockDate BETWEEN StartDate AND EndDate
		ORDER BY dm.StockDate DESC;

	UPDATE directionalmovement dm  INNER JOIN t ON dm.DirectionalMovementID = t.DirectionalMovementID
		SET dm.TrendChange = 1, dm.UpdatedDate = NOW() 
		WHERE dm.StockID = iStockID AND t.CurrentDirection <> t.LastDirection  AND t.CurrentDirection > - 1 AND t.LastDirection > -1;

	DROP TEMPORARY TABLE IF EXISTS t;
    
    
    
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CreateUpdateADXTrendDirection` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CreateUpdateADXTrendDirection`(IN iStockID INT, IN iUpdatedTime INT, IN StartDateTime TIMESTAMP, IN EndDateTime TIMESTAMP)
BEGIN
-- iUpdatedTime >  0 -->  Calculates all the DirectionalMovement.TrendDirection for the inputted StockID  
-- iUpdatedTime =  0 -->  Calculates the TrendDirection of All FinaicialID's and Inserts into the DirectionalMovement.TrendDirection column.
-- iUpdatedTime = -1 -->  Calculates the TrendDirection of FinaicialID's from (Now - settings.Value Minutes) to Now
-- iUpdatedTime = -2 -->  Calculates The DirectionalMovement TrendDirection for only an entry updated within the last minute. Mainly used for inserting new records


    DECLARE iUpTrendID INT DEFAULT NULL;
	DECLARE iDownTrendID INT DEFAULT NULL;
    DECLARE iSettingsDefaultValue INT;
    
        -- Error Handler --
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 @errno = MYSQL_ERRNO, @ErrorMsg = MESSAGE_TEXT;
        insert into errorlog(ObjectName, ErrorNumber, ErrorMessage, CreatedDate)
        VALUES ('CreateUpdateADXTrendDirection', @errno, @ErrorMsg, NOW());
    END;
    -- Error Handler End --

	SET SQL_SAFE_UPDATES = 0;
    
	CREATE TEMPORARY TABLE IF NOT EXISTS finID (FinancialDataID INT PRIMARY KEY);
	SELECT PickListID INTO iUpTrendID FROM picklist WHERE ColumnName = 'TrendDirection' AND Active = 1 AND picklist.Value = 'Trending Up';
	SELECT PickListID INTO iDownTrendID FROM picklist WHERE ColumnName = 'TrendDirection' AND Active = 1 AND picklist.Value = 'Trending Down';
    SELECT settings.Value INTO iSettingsDefaultValue FROM settings WHERE settings.Name = 'Directional Movement Trend Direction Time' AND settings.Active = 1;

	IF (iUpdatedTime > 0) THEN 
    
		IF (StartDateTime IS NOT NULL AND EndDateTime IS NOT NULL) THEN
			INSERT INTO finID(FinancialDataID)
				SELECT FinancialDataID FROM FinancialData WHERE StockID = iStockID AND StockDate BETWEEN StartDateTime AND EndDateTime;
		ELSEIF (StartDateTime IS NOT NULL AND EndDateTime IS NULL) THEN
			INSERT INTO finID(FinancialDataID)
				SELECT FinancialDataID FROM FinancialData WHERE StockID = iStockID AND StockDate >= StartDateTime;
		ELSEIF (StartDateTime IS NULL AND EndDateTime IS NOT NULL) THEN
			INSERT INTO finID(FinancialDataID)
				SELECT FinancialDataID FROM FinancialData WHERE StockID = iStockID AND StockDate <= EndDateTime;
		ELSE 
			INSERT INTO finID(FinancialDataID)
				SELECT FinancialDataID FROM FinancialData WHERE StockID = iStockID;
		END IF;
        
	ELSEIF (iUpdatedTime = 0) THEN 
    
		IF (StartDateTime IS NOT NULL AND EndDateTime IS NOT NULL) THEN
			INSERT INTO finID(FinancialDataID)
				SELECT FinancialDataID FROM FinancialData WHERE StockDate BETWEEN StartDateTime AND EndDateTime;
		ELSEIF (StartDateTime IS NOT NULL AND EndDateTime IS NULL) THEN
			INSERT INTO finID(FinancialDataID)
				SELECT FinancialDataID FROM FinancialData WHERE StockDate >= StartDateTime;
		ELSEIF (StartDateTime IS NULL AND EndDateTime IS NOT NULL) THEN
			INSERT INTO finID(FinancialDataID)
				SELECT FinancialDataID FROM FinancialData WHERE StockDate <= EndDateTime;
		ELSE 
			INSERT INTO finID(FinancialDataID)
				SELECT FinancialDataID FROM FinancialData;
		END IF;
        
	ELSEIF (iUpdatedTime = -1) THEN
		INSERT INTO finID(FinancialDataID)
			SELECT dm.FinancialDataID AS FinancialDataID FROM directionalmovement dm INNER JOIN FinancialData fd ON dm.FinancialDataID = fd.FinancialDataID
            WHERE dm.UpdatedDate >= DATE_SUB(NOW(), INTERVAL iSettingsDefaultValue MINUTE) AND fd.StockID = iStockID;
            
    ELSEIF (iUpdatedTime = -2) THEN 
		INSERT INTO finID(FinancialDataID)
			SELECT dm.FinancialDataID AS FinancialDataID FROM directionalmovement dm INNER JOIN FinancialData fd ON dm.FinancialDataID = fd.FinancialDataID
            WHERE dm.UpdatedDate >= DATE_SUB(NOW(), INTERVAL 3 MINUTE) AND fd.StockID = iStockID;
    END IF;
    
	UPDATE directionalmovement dm INNER JOIN finID fi ON dm.FinancialDataID = fi.FinancialDataID
		SET dm.TrendDirection = iUpTrendID, UpdatedDate = NOW() 
		WHERE dm.DMIPlus > dm.DMIMinus AND dm.DMIMinus <> 0 AND dm.DMIPlus <> 0;
        
    UPDATE directionalmovement dm INNER JOIN finID fi ON dm.FinancialDataID = fi.FinancialDataID
		SET dm.TrendDirection = iDownTrendID, UpdatedDate = NOW() 
		WHERE dm.DMIPlus < dm.DMIMinus AND dm.DMIMinus <> 0 AND dm.DMIPlus <> 0;

	DROP TEMPORARY TABLE IF EXISTS finID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CreateUpdateBoilerBandWidth` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CreateUpdateBoilerBandWidth`(IN iStockID INT, IN iUpdatedTime INT)
BEGIN
	-- iUpdatedTime >  0 -->  Calculates all the BoilerBand.Width for the inputted StockID  
	-- iUpdatedTime =  0 -->  Calculates the Width of All BoilerBands and Inserts into the boilerband.width column.
    -- iUpdatedTime = -1 -->  Calculates the Width of BoilerBands from Now To now - settings hours
    -- iUpdatedTime = -2 -->  Calculates The BoilerBand Width for only an entry updated within the last minute. Mainly used for inserting new records
    
	DECLARE vBbandHourSettings VARCHAR(255) DEFAULT "";

        -- Error Handler --
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 @errno = MYSQL_ERRNO, @ErrorMsg = MESSAGE_TEXT;
        insert into errorlog(ObjectName, ErrorNumber, ErrorMessage, CreatedDate)
        VALUES ('CreateUpdateBoilerBandWidth', @errno, @ErrorMsg, NOW());
    END;
    -- Error Handler End --
		
        SET SQL_SAFE_UPDATES = 0;
        
        IF iUpdatedTime =  0 THEN 
            UPDATE boilerband SET boilerband.WidthPercentage =  CONVERT((( (boilerband.Upper - boilerband.Lower) / boilerband.Middle ) * 100), decimal(20,5)), boilerband.UpdatedDate = NOW();
            
        ELSEIF iUpdatedTime = -1 THEN
			SELECT settings.Value INTO vBbandHourSettings FROM settings WHERE settings.Name = "Boilerband Width Hours" AND Active = 1;
            UPDATE boilerband SET 
				boilerband.WidthPercentage = CONVERT(( ( (boilerband.Upper - boilerband.Lower) / boilerband.Middle ) * 100), decimal(20,5)), 
                boilerband.UpdatedDate = NOW()
				WHERE UpdatedDate > DATE_SUB(NOW(), INTERVAL vBbandHourSettings HOUR) AND StockID = iStockID;
                -- AND boilerband.FinancialDataID IN (SELECT FinancialDataID from FinancialData WHERE StockID = iStockID);
                
		ELSEIF iUpdatedTime = -2 THEN
			UPDATE boilerband SET 
				boilerband.WidthPercentage = CONVERT(( ( (boilerband.Upper - boilerband.Lower) / boilerband.Middle ) * 100), decimal(20,5)), 
                boilerband.UpdatedDate = NOW()
				WHERE UpdatedDate > DATE_SUB(NOW(), INTERVAL 1 MINUTE) AND StockID = iStockID;
                -- AND boilerband.FinancialDataID IN (SELECT FinancialDataID from FinancialData WHERE StockID = iStockID); 
        ELSE
				UPDATE boilerband 
					SET boilerband.WidthPercentage = CONVERT(( ( (boilerband.Upper - boilerband.Lower) / boilerband.Middle ) * 100), decimal(20,5)), boilerband.UpdatedDate = NOW()
                WHERE boilerband.StockID = iStockID;
        END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CreateUpdateChaikinADCrossZero` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CreateUpdateChaikinADCrossZero`(IN iStockID INT, IN StartDate DATETIME, IN EndDate DATETIME)
BEGIN
    
        -- Error Handler --
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 @errno = MYSQL_ERRNO, @ErrorMsg = MESSAGE_TEXT;
        insert into errorlog(ObjectName, ErrorNumber, ErrorMessage, CreatedDate)
        VALUES ('CreateUpdateChaikinADCrossZero', @errno, @ErrorMsg, NOW());
    END;
    -- Error Handler End --
    
    SET SQL_SAFE_UPDATES = 0;
    
    IF (StartDate IS NULL) THEN
		SELECT StockDate INTO StartDate FROM chaikinoscillator WHERE StockID = iStockID ORDER BY StockDate ASC LIMIT 1;
	END IF;
    
    IF (EndDate IS NULL) THEN
		SELECT StockDate INTO EndDate FROM chaikinoscillator WHERE StockID = iStockID ORDER BY StockDate DESC LIMIT 1;
	END IF;
    
	CREATE TEMPORARY TABLE IF NOT EXISTS t
		SELECT co.ChaikinOscillatorID, co.StockDate, LAG(SIGN(co.ChaikinADLine)) OVER (PARTITION BY co.StockID ORDER BY co.StockDate DESC) AS LastDirection, SIGN(ChaikinADLine) AS CurrentDirection
		FROM chaikinoscillator co WHERE co.StockID = iStockID AND ChaikinADLine > -2 AND co.StockDate BETWEEN StartDate AND EndDate 
        ORDER BY co.StockDate DESC;

	UPDATE chaikinoscillator co  INNER JOIN t ON co.ChaikinOscillatorID = t.ChaikinOscillatorID
		SET co.CrossedZero = 1, co.UpdatedDate = NOW() 
		WHERE co.StockID = iStockID AND t.CurrentDirection <> t.LastDirection  AND t.CurrentDirection > - 2 AND t.LastDirection > -2;

	DROP TEMPORARY TABLE IF EXISTS t;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CreateUpdateMacdTrendChange` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CreateUpdateMacdTrendChange`(IN iStockID INT, IN StartDate DATETIME, IN EndDate DateTime)
BEGIN
    
                -- Error Handler --
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 @errno = MYSQL_ERRNO, @ErrorMsg = MESSAGE_TEXT;
        insert into errorlog(ObjectName, ErrorNumber, ErrorMessage, CreatedDate)
        VALUES ('CreateUpdateMacdTrendChange', @errno, @ErrorMsg, NOW());
    END;
    -- Error Handler End --
    
    SET SQL_SAFE_UPDATES = 0;
    
	IF (StartDate IS NULL) THEN
		SELECT StockDate INTO StartDate FROM macd WHERE StockID = iStockID ORDER BY StockDate ASC LIMIT 1;
	END IF;
    
    IF (EndDate IS NULL) THEN
		SELECT StockDate INTO EndDate FROM macd WHERE StockID = iStockID ORDER BY StockDate DESC LIMIT 1;
	END IF;
    
	CREATE TEMPORARY TABLE IF NOT EXISTS t
	SELECT md.MACDID, md.StockDate, LAG(md.TrendDirection) OVER (PARTITION BY md.StockID ORDER BY md.StockDate DESC) AS LastDirection, md.TrendDirection AS CurrentDirection,
    LAG(md.MACD) OVER (PARTITION BY md.StockID ORDER BY md.StockDate DESC) AS LastMACDDirection, md.MACD AS CurrentMACD
	FROM macd md 
	WHERE md.StockID = iStockID AND md.StockDate BETWEEN StartDate AND EndDate
	ORDER BY md.StockDate DESC;

	UPDATE macd md  INNER JOIN t ON md.MACDID = t.MACDID
		SET md.TrendChange = 1, md.UpdatedDate = NOW() 
		WHERE md.StockID = iStockID AND t.CurrentDirection <> t.LastDirection  AND t.CurrentDirection > - 1 AND t.LastDirection > -1;
	
    UPDATE macd md INNER JOIN t ON md.MACDID = t.MACDID
		SET md.CrossedZero = 1, md.UpdatedDate = NOW() 
        WHERE md.StockID = iStockID AND SIGN(t.LastMACDDirection) <> SIGN(t.CurrentMACD); 
    
	DROP TEMPORARY TABLE IF EXISTS t;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CreateUpdateMacdTrendDirection` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CreateUpdateMacdTrendDirection`(IN iStockID INT, IN iUpdatedTime INT, IN StartDateTime DATETIME, IN EndDateTime DATETIME)
BEGIN
-- iUpdatedTime >  0 -->  Calculates all the macd.TrendDirection for the inputted StockID  
-- iUpdatedTime =  0 -->  Calculates the TrendDirection of All FinaicialID's and Inserts into the macd.TrendDirection column.
-- iUpdatedTime = -1 -->  Calculates the TrendDirection of FinaicialID's from (Now - settings.Value Minutes) to Now
-- iUpdatedTime = -2 -->  Calculates The macd TrendDirection for only an entry updated within the last minute. Mainly used for inserting new records


    DECLARE iUpTrendID INT DEFAULT NULL;
	DECLARE iDownTrendID INT DEFAULT NULL;
    DECLARE iTrendShift INT DEFAULT NULL;
    DECLARE iSettingsDefaultValue INT;
    
        -- Error Handler --
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 @errno = MYSQL_ERRNO, @ErrorMsg = MESSAGE_TEXT;
        insert into errorlog(ObjectName, ErrorNumber, ErrorMessage, CreatedDate)
        VALUES ('CreateUpdateMacdTrendDirection', @errno, @ErrorMsg, NOW());
    END;
    -- Error Handler End --
    
    SET SQL_SAFE_UPDATES = 0;
    
	SELECT PickListID INTO iTrendShift FROM picklist WHERE ColumnName = 'TrendDirection' AND Active = 1 AND picklist.Value = 'Trend Shift';
	SELECT PickListID INTO iUpTrendID FROM picklist WHERE ColumnName = 'TrendDirection' AND Active = 1 AND picklist.Value = 'Trending Up';
	SELECT PickListID INTO iDownTrendID FROM picklist WHERE ColumnName = 'TrendDirection' AND Active = 1 AND picklist.Value = 'Trending Down';
    SELECT settings.Value INTO iSettingsDefaultValue FROM settings WHERE settings.Name = 'MACD Default Time' AND settings.Active = 1;
    
    IF (StartDateTime IS NULL) THEN
		SELECT StockDate INTO StartDateTime FROM macd WHERE StockID = iStockID ORDER BY StockDate ASC LIMIT 1;
	END IF;
    
    IF (EndDateTime IS NULL) THEN
		SELECT StockDate INTO EndDateTime FROM macd WHERE StockID = iStockID ORDER BY StockDate DESC LIMIT 1;
	END IF;
    
    IF (iUpdatedTime > 0) THEN 
    
		CREATE TEMPORARY TABLE IF NOT EXISTS finID
		SELECT FinancialDataID FROM macd WHERE StockID = iStockID AND StockDate BETWEEN StartDateTime AND EndDateTime;

        
	ELSEIF (iUpdatedTime = 0) THEN 
    
		CREATE TEMPORARY TABLE IF NOT EXISTS finID
		SELECT FinancialDataID FROM macd WHERE StockDate BETWEEN StartDateTime AND EndDateTime;
        
	ELSEIF (iUpdatedTime = -1) THEN
		CREATE TEMPORARY TABLE IF NOT EXISTS finID
			SELECT FinancialDataID FROM macd WHERE StockDate BETWEEN DATE_SUB(NOW(), INTERVAL iSettingsDefaultValue MINUTE) AND NOW() AND StockID = iStockID;
	
    ELSEIF (iUpdatedTime = -2) THEN
		CREATE TEMPORARY TABLE IF NOT EXISTS finID
			SELECT FinancialDataID FROM macd WHERE macd.UpdatedDate >= DATE_SUB(NOW(), INTERVAL 1 MINUTE) 
            AND StockID = iStockID;
            -- AND macd.FinancialDataID IN (SELECT FinancialDataID FROM FinancialData WHERE StockID = iStockID);
    END IF;
    
    
    UPDATE macd SET TrendDirection = iUpTrendID, UpdatedDate = NOW() WHERE macd.FinancialDataID IN (SELECT FinancialDataID FROM finID) AND macd.`MACD` > macd.`MACD_Signal`;
    UPDATE macd SET TrendDirection = iDownTrendID, UpdatedDate = NOW() WHERE macd.FinancialDataID IN (SELECT FinancialDataID FROM finID) AND macd.`MACD` < macd.`MACD_Signal`;
	UPDATE macd SET TrendDirection = iTrendShift, UpdatedDate = NOW() WHERE macd.FinancialDataID IN (SELECT FinancialDataID FROM finID) AND macd.`MACD` = macd.`MACD_Signal` AND (macd.`MACD` <> 0 AND macd.`MACD_Signal` <> 0);

    DROP TEMPORARY TABLE IF EXISTS finID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CreateUpdatePriceTrendDirection` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CreateUpdatePriceTrendDirection`(IN iStockID INT, IN StartDateTime TIMESTAMP, IN EndDateTime TIMESTAMP)
BEGIN
-- iStockID >  0 -->  Calculates all the DirectionalMovement.TrendDirection for the inputted StockID  
-- iStockID =  0 -->  Calculates the TrendDirection of All FinaicialID's and Inserts into the DirectionalMovement.TrendDirection column.
-- iStockID = -1 -->  Calculates the TrendDirection of FinaicialID's from (Now - settings.Value Minutes) to Now
-- iStockID = -2 -->  Calculates The DirectionalMovement TrendDirection for only an entry updated within the last minute. Mainly used for inserting new records


    DECLARE iUpTrendID INT DEFAULT NULL;
	DECLARE iDownTrendID INT DEFAULT NULL;
    DECLARE iSettingsDefaultValue INT;
    
        -- Error Handler --
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 @errno = MYSQL_ERRNO, @ErrorMsg = MESSAGE_TEXT;
        insert into errorlog(ObjectName, ErrorNumber, ErrorMessage, CreatedDate)
        VALUES ('CreateUpdatePriceTrendDirection', @errno, @ErrorMsg, NOW());
    END;
    -- Error Handler End --

	SELECT PickListID INTO iUpTrendID FROM picklist WHERE ColumnName = 'TrendDirection' AND Active = 1 AND picklist.Value = 'Trending Up';
	SELECT PickListID INTO iDownTrendID FROM picklist WHERE ColumnName = 'TrendDirection' AND Active = 1 AND picklist.Value = 'Trending Down';
    SELECT settings.Value INTO iSettingsDefaultValue FROM settings WHERE settings.Name = 'Directional Movement Trend Direction Time' AND settings.Active = 1;

	IF (iStockID > 0) THEN 
    
		IF (StartDateTime IS NOT NULL AND EndDateTime IS NOT NULL) THEN
			CREATE TEMPORARY TABLE IF NOT EXISTS finID
				SELECT FinancialDataID FROM financialdata WHERE StockID = iStockID AND StockDate BETWEEN StartDateTime AND EndDateTime;
		ELSEIF (StartDateTime IS NOT NULL AND EndDateTime IS NULL) THEN
			CREATE TEMPORARY TABLE IF NOT EXISTS finID
				SELECT FinancialDataID FROM financialdata WHERE StockID = iStockID AND StockDate >= StartDateTime;
		ELSEIF (StartDateTime IS NULL AND EndDateTime IS NOT NULL) THEN
			CREATE TEMPORARY TABLE IF NOT EXISTS finID
				SELECT FinancialDataID FROM financialdata WHERE StockID = iStockID AND StockDate <= EndDateTime;
		ELSE 
			CREATE TEMPORARY TABLE IF NOT EXISTS finID
				SELECT FinancialDataID FROM financialdata WHERE StockID = iStockID;
		END IF;
        
	ELSEIF (iStockID = 0) THEN 
    
		IF (StartDateTime IS NOT NULL AND EndDateTime IS NOT NULL) THEN
			CREATE TEMPORARY TABLE IF NOT EXISTS finID
				SELECT FinancialDataID FROM financialdata WHERE StockDate BETWEEN StartDateTime AND EndDateTime;
		ELSEIF (StartDateTime IS NOT NULL AND EndDateTime IS NULL) THEN
			CREATE TEMPORARY TABLE IF NOT EXISTS finID
				SELECT FinancialDataID FROM financialdata WHERE StockDate >= StartDateTime;
		ELSEIF (StartDateTime IS NULL AND EndDateTime IS NOT NULL) THEN
			CREATE TEMPORARY TABLE IF NOT EXISTS finID
				SELECT FinancialDataID FROM financialdata WHERE StockDate <= EndDateTime;
		ELSE 
			CREATE TEMPORARY TABLE IF NOT EXISTS finID
				SELECT FinancialDataID FROM financialdata;
		END IF;
        
	ELSEIF (iStockID = -1) THEN
		CREATE TEMPORARY TABLE IF NOT EXISTS finID
			SELECT FinancialDataID FROM financialdata WHERE StockDate BETWEEN DATE_SUB(NOW(), INTERVAL iSettingsDefaultValue MINUTE) AND NOW();
	
    ELSEIF (iStockID = -2) THEN 
		CREATE TEMPORARY TABLE IF NOT EXISTS finID
			SELECT FinancialDataID FROM directionalmovement WHERE directionalmovement.UpdatedDate >= DATE_SUB(NOW(), INTERVAL 1 MINUTE);
    END IF;
    
	UPDATE directionalmovement dm SET dm.TrendDirection = iUpTrendID, UpdatedDate = NOW() WHERE dm.FinancialDataID IN (SELECT FinancialDataID FROM finID) AND dm.DMIPlus > dm.DMIMinus;
    UPDATE directionalmovement dm SET dm.TrendDirection = iDownTrendID, UpdatedDate = NOW() WHERE dm.FinancialDataID IN (SELECT FinancialDataID FROM finID) AND dm.DMIPlus < dm.DMIMinus;

	DROP TEMPORARY TABLE IF EXISTS finID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CreateUpdateSarSlope` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CreateUpdateSarSlope`(IN iStockID INT, IN iNumDataPointsForSlope INT)
BEGIN
-- iStockID >  0 -->  Calculates all the sar.Sar slope for the inputted StockID  
-- iStockID =  0 -->  Calculates the slope of All SarID's and Inserts into the Sar.SarSlope column.
-- iStockID = -1 -->  Calculates the slope of FinaicialID's with the quantity given from settings.Value
-- iStockID = -2 -->  Calculates The Sar Slope for only an entry updated within the last minute. Mainly used for inserting new records

	DECLARE done INT DEFAULT 0; 
    
	DECLARE iSettingsTimeDefaultValue INT;
    DECLARE iSettingsQuantityDefaultValue INT DEFAULT NULL;
        
	DECLARE iFinancialDataID INT DEFAULT NULL;
    DECLARE iSar FLOAT DEFAULT NULL;
    DECLARE iFinIDID INT DEFAULT NULL;
    
    DECLARE iLastFinIDID INT DEFAULT NULL;
    DECLARE iLastSar FLOAT DEFAULT NULL;
    
    DECLARE iMinFinancialDataID INT DEFAULT NULL;
    DECLARE iSumSar FLOAT DEFAULT 0;
    
    DECLARE iSarSlope Float DEFAULT NULL;
    
    DECLARE getSarSlopeCurs CURSOR FOR SELECT `FinancialDataID`, `SAR`, `finIDID` FROM finID ORDER BY FinancialDataID ASC;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

                -- Error Handler --
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 @errno = MYSQL_ERRNO, @ErrorMsg = MESSAGE_TEXT;
        insert into errorlog(ObjectName, ErrorNumber, ErrorMessage, CreatedDate)
        VALUES ('CreateUpdateSarSlope', @errno, @ErrorMsg, NOW());
    END;
    -- Error Handler End --

    SET SQL_SAFE_UPDATES = 0;
    
    SELECT settings.Value INTO iSettingsQuantityDefaultValue FROM settings WHERE settings.Name = 'SAR Slope Default Quantity' AND settings.Active = 1;
    SELECT settings.Value INTO iSettingsTimeDefaultValue FROM settings WHERE settings.Name = 'SAR Default Time' AND settings.Active = 1;
    
    CREATE TEMPORARY TABLE IF NOT EXISTS finID (finIDID INT PRIMARY KEY AUTO_INCREMENT, FinancialDataID FLOAT, SAR FLOAT);
    
    IF (iNumDataPointsForSlope IS NULL or iNumDataPointsForSlope <= 0) THEN
		SET iNumDataPointsForSlope = iSettingsQuantityDefaultValue;
    END IF;
    
    IF (iStockID > 0) THEN
		INSERT INTO finID (FinancialDataID, SAR)
			SELECT fd.FinancialDataID, s.Sar FROM financialdata fd 
            INNER JOIN sar s ON fd.FinancialDataID = s.FinancialDataID
            WHERE fd.StockID = iStockID AND s.Sar > 0 AND s.Sar IS NOT NULL;

	ELSEIF (iStockID = 0) THEN
		INSERT INTO finID (FinancialDataID, SAR)
			SELECT FinancialDataID, sar.Sar FROM sar WHERE sar.Sar IS NOT NULL;
            
	ELSEIF(iStockID = -1) THEN
		INSERT INTO finID (FinancialDataID, SAR)
			SELECT FinancialDataID, sar.Sar FROM sar WHERE UpdatedDate >=DATE_SUB(NOW(), INTERVAL iSettingsTimeDefaultValue MINUTE) AND sar.Sar IS NOT NULL;
    
    ELSEIF (iStockID = -2) THEN
		INSERT INTO finID (FinancialDataID, SAR)
			SELECT FinancialDataID, sar.Sar FROM sar WHERE UpdatedDate >=DATE_SUB(NOW(), INTERVAL 3 MINUTE) AND sar.Sar IS NOT NULL;
    END IF;
	
    SELECT MIN(FinancialDataID) INTO iMinFinancialDataID FROM finID;
    
    
    IF (iStockID < 1) THEN
		
        IF (iMinFinancialDataID > (SELECT (MIN(FinancialDataID) + iNumDataPointsForSlope) FROM sar)) THEN
			INSERT INTO finID(FinancialDataID, SAR)
				SELECT FinancialDataID, sar.Sar AS SAR FROM sar WHERE sar.FinancialDataID < iMinFinancialDataID ORDER BY sar.FinancialDataID DESC LIMIT iNumDataPointsForSlope;
		END IF;
	ELSE 
    
		IF (iMinFinancialDataID > (SELECT (MIN(FinancialDataID) + iNumDataPointsForSlope) FROM sar WHERE sar.FinancialDataID IN (SELECT FinancialDataID from financialdata WHERE StockID = iStockID))) THEN
			INSERT INTO finID(FinancialDataID, SAR)
				SELECT fd.FinancialDataID, s.Sar AS SAR FROM financialdata fd 
				INNER JOIN sar s ON fd.FinancialDataID = s.FinancialDataID
				WHERE s.FinancialDataID < iMinFinancialDataID AND fd.StockID = iStockID 
				ORDER BY s.FinancialDataID DESC LIMIT iNumDataPointsForSlope;
		END IF;
    END IF;
    
	OPEN getSarSlopeCurs;
    GetSarSlope: LOOP
    
		FETCH getSarSlopeCurs INTO iFinancialDataID, iSar, iFinIDID;
        IF (done = 1) THEN 
			LEAVE GetSarSlope;
		END IF;
        
        IF ( (iFinIDID - iNumDataPointsForSlope) > 0) THEN

            SET iLastFinIDID = (iFinIDID - iNumDataPointsForSlope) + 1;
            
            IF (iSumSar IS NULL OR iSumSar = 0) THEN
				SELECT SUM(Sar) INTO iSumSar FROM finID WHERE FinIDID BETWEEN iLastFinIDID AND  iFinIDID;
            ELSE
				SET iSumSar = iSumSar + (SELECT Sar FROM finID WHERE FinIDID = iFinIDID);
            END IF;
            
			SET iSarSlope = iSumSar/(iNumDataPointsForSlope);
				                
			UPDATE sar SET SarSlope = iSarSlope, UpdatedDate = NOW() WHERE sar.FinancialDataID = iFinancialDataID;
            
            SELECT Sar INTO iLastSar FROM finID WHERE FinIDID = iLastFinIDID;
            
            SET iSumSar = iSumSar - iLastSar;
            
        END IF;
	END LOOP GetSarSlope;
    CLOSE getSarSlopeCurs;
    
    DROP TEMPORARY TABLE IF EXISTS finID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CreateUpdateSarTrendChange` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CreateUpdateSarTrendChange`(IN iStockID INT, IN StartDate DATETIME, IN EndDate DATETIME)
BEGIN

                -- Error Handler --
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 @errno = MYSQL_ERRNO, @ErrorMsg = MESSAGE_TEXT;
        insert into errorlog(ObjectName, ErrorNumber, ErrorMessage, CreatedDate)
        VALUES ('CreateUpdateSarTrendChange', @errno, @ErrorMsg, NOW());
    END;
    -- Error Handler End --
    
    SET SQL_SAFE_UPDATES = 0;
    
    IF (StartDate IS NULL) THEN
		SELECT StockDate INTO StartDate FROM sar WHERE StockID = iStockID ORDER BY StockDate ASC LIMIT 1;
	END IF;
    
    IF (EndDate IS NULL) THEN
		SELECT StockDate INTO EndDate FROM sar WHERE StockID = iStockID ORDER BY StockDate DESC LIMIT 1;
	END IF;
        
    	
	DROP TEMPORARY TABLE IF EXISTS t;
	CREATE TEMPORARY TABLE IF NOT EXISTS t
	SELECT s.StockDate, s.SarID, LAG(s.TrendDirection) OVER (PARTITION BY s.StockID ORDER BY s.StockDate DESC) AS LastDirection, s.TrendDirection AS CurrentDirection
	FROM sar s 
    -- INNER JOIN financialdata fd ON s.FinancialDataID = fd.FinancialDataID
	WHERE 
    -- fd.StockID = iStockID AND 
    s.StockID = iStockID AND s.TrendDirection > -1 AND s.StockDate BETWEEN StartDate AND EndDate
	ORDER BY s.StockDate DESC;

	UPDATE sar s  INNER JOIN t ON s.SarID = t.SarID
		SET s.TrendChange = 1, s.UpdatedDate = NOW() 
		WHERE s.StockID = iStockID AND t.CurrentDirection <> t.LastDirection  AND t.CurrentDirection > - 1 AND t.LastDirection > -1;

	DROP TEMPORARY TABLE IF EXISTS t;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CreateUpdateSarTrendDirection` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CreateUpdateSarTrendDirection`(IN iStockID INT, IN iUpdatedTime INT, IN StartDateTime DATETIME, IN EndDateTime DATETIME)
BEGIN
-- iUpdatedTime >  0 -->  Calculates all the sar.TrendDirection for the inputted StockID  
-- iUpdatedTime =  0 -->  Calculates the TrendDirection of All FinaicialID's and Inserts into the sar.TrendDirection column.
-- iUpdatedTime = -1 -->  Calculates the TrendDirection of FinaicialID's from (Now - settings.Value Minutes) to Now
-- iUpdatedTime = -2 -->  Calculates The sar TrendDirection for only an entry updated within the last minute. Mainly used for inserting new records


    DECLARE iUpTrendID INT DEFAULT NULL;
	DECLARE iDownTrendID INT DEFAULT NULL;
    DECLARE iSettingsDefaultValue INT;
    
        -- Error Handler --
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 @errno = MYSQL_ERRNO, @ErrorMsg = MESSAGE_TEXT;
        insert into errorlog(ObjectName, ErrorNumber, ErrorMessage, CreatedDate)
        VALUES ('CreateUpdateSarTrendDirection', @errno, @ErrorMsg, NOW());
    END;
    -- Error Handler End --
    
    SET SQL_SAFE_UPDATES = 0;
    
	SELECT PickListID INTO iUpTrendID FROM picklist WHERE ColumnName = 'TrendDirection' AND Active = 1 AND picklist.Value = 'Trending Up';
	SELECT PickListID INTO iDownTrendID FROM picklist WHERE ColumnName = 'TrendDirection' AND Active = 1 AND picklist.Value = 'Trending Down';
    SELECT settings.Value INTO iSettingsDefaultValue FROM settings WHERE settings.Name = 'SAR Default Time' AND settings.Active = 1;
    
        IF (StartDateTime IS NULL) THEN
		SELECT StockDate INTO StartDateTime FROM sar WHERE StockID = iStockID ORDER BY StockDate ASC LIMIT 1;
	END IF;
    
    IF (EndDateTime IS NULL) THEN
		SELECT StockDate INTO EndDateTime FROM sar WHERE StockID = iStockID ORDER BY StockDate DESC LIMIT 1;
	END IF;
    
    
    IF (iUpdatedTime > 0) THEN 
    
		CREATE TEMPORARY TABLE IF NOT EXISTS finID
		SELECT FinancialDataID FROM sar WHERE StockID = iStockID AND StockDate BETWEEN StartDateTime AND EndDateTime;
        
	ELSEIF (iUpdatedTime = 0) THEN 
    
		CREATE TEMPORARY TABLE IF NOT EXISTS finID
		SELECT FinancialDataID FROM sar WHERE StockDate BETWEEN StartDateTime AND EndDateTime;

        
	ELSEIF (iUpdatedTime = -1) THEN
		CREATE TEMPORARY TABLE IF NOT EXISTS finID
            SELECT FinancialDataID FROM sar WHERE sar.UpdatedDate >= DATE_SUB(NOW(), INTERVAL iSettingsDefaultValue MINUTE) AND sar.StockID = iStockID;
            -- sar.FinancialDataID IN (SELECT FinancialDataID FROM FinancialData WHERE StockID = iStockID);	
    ELSEIF (iUpdatedTime = -2) THEN
		CREATE TEMPORARY TABLE IF NOT EXISTS finID
            SELECT FinancialDataID FROM sar WHERE sar.UpdatedDate >= DATE_SUB(NOW(), INTERVAL 3 MINUTE)
            AND sar.StockID = iStockID;
            -- sar.FinancialDataID IN (SELECT FinancialDataID FROM financialdata WHERE StockID = iStockID);
              
    END IF;
    
    
    UPDATE sar SET TrendDirection = iUpTrendID WHERE sar.FinancialDataID IN (SELECT FinancialDataID FROM finID) AND sar.`Sar` < sar.`WMA`;
    UPDATE sar SET TrendDirection = iDownTrendID WHERE sar.FinancialDataID IN (SELECT FinancialDataID FROM finID) AND sar.`Sar` > sar.`WMA`;
    
    DROP TEMPORARY TABLE IF EXISTS finID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CreateUpdateStock` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `CreateUpdateStock`()
BEGIN
	
    
        -- Error Handler --
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 @errno = MYSQL_ERRNO, @ErrorMsg = MESSAGE_TEXT;
        insert into errorlog(ObjectName, ErrorNumber, ErrorMessage, CreatedDate)
        VALUES ('CreateUpdateStock', @errno, @ErrorMsg, NOW());
    END;
    -- Error Handler End --
	
    SET SQL_SAFE_UPDATES = 0;
    
    IF ( (SELECT COUNT(*) FROM rawStock) > 0 ) THEN
		
        DELETE FROM rawStock WHERE Symbol = CompanyName;
    
		INSERT INTO stock(Symbol, AssetType, CompanyName, StockExchange, CreatedDate)
		SELECT rs.Symbol, rs.AssetType, rs.CompanyName, rs.StockExchange, NOW() 
		FROM rawStock rs LEFT OUTER JOIN stock s ON rs.Symbol = s.Symbol WHERE s.StockID IS NULL;
        
        CREATE TEMPORARY TABLE IF NOT EXISTS NextReportDate
        SELECT Symbol, MIN(reportDate) minReportDate, MIN(fiscalDateEnding) FiscalDateEnd FROM rawStock WHERE reportDate > NOW() GROUP BY Symbol;
        
		UPDATE stock s INNER JOIN NextReportDate nrp ON s.Symbol = nrp.Symbol
			SET s.NextReportDate = nrp.minReportDate, s.NextFiscalDateEnd = nrp.FiscalDateEnd
			WHERE s.NextReportDate IS NULL;
        
        UPDATE stock s INNER JOIN NextReportDate nrp ON s.Symbol = nrp.Symbol
			SET s.NextReportDate = nrp.minReportDate, s.NextFiscalDateEnd = nrp.FiscalDateEnd
			WHERE s.NextReportDate < NOW();
            
        
        DROP TEMPORARY TABLE IF EXISTS NextReportDate;
        
        TRUNCATE TABLE rawStock;
	END IF;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CreateUpdateTrendChange` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CreateUpdateTrendChange`(IN iStockID INT)
BEGIN
-- iStockID >  0 -->  Calculates all the DirectionalMovement.TrendChange for the inputted StockID  
-- iStockID =  0 -->  Calculates the TrendChange of All FinaicialID's and Inserts into the DirectionalMovement.TrendChange column.
-- iStockID = -1 -->  Calculates the TrendChange of FinaicialID's from (Now - settings.Value Minutes) to Now
-- iStockID = -2 -->  Calculates The DirectionalMovement TrendChange for only an entry updated within the last minute. Mainly used for inserting new records
	
    DECLARE done INT DEFAULT 0;
    DECLARE iSettingsDefaultValue INT;
    
    DECLARE iFinancialDataID INT DEFAULT NULL;
    DECLARE iTrendDirection INT DEFAULT NULL;
    DECLARE idmID INT DEFAULT NULL;
    
    DECLARE iMinFinancialDataID INT DEFAULT NULL;
    DECLARE iMinTrendDirection INT DEFAULT NULL;
    
    DECLARE iMaxFinancialDataID INT DEFAULT NULL;
    DECLARE iMaxTrendDirection INT DEFAULT NULL;
    
    DECLARE ThreeTrendDirectionCurs CURSOR FOR SELECT FinancialDataID, TrendDirection, dmIDID  FROM dmID ORDER BY FinancialDataID ASC;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
            -- Error Handler --
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 @errno = MYSQL_ERRNO, @ErrorMsg = MESSAGE_TEXT;
        insert into errorlog(ObjectName, ErrorNumber, ErrorMessage, CreatedDate)
        VALUES ('CreateUpdateTrendChange', @errno, @ErrorMsg, NOW());
    END;
    -- Error Handler End --

    
	SELECT settings.Value INTO iSettingsDefaultValue FROM settings WHERE settings.Name = 'Directional Movement Trend Direction Time' AND settings.Active = 1;

	CREATE TEMPORARY TABLE IF NOT EXISTS dmID(dmIDID INT PRIMARY KEY AUTO_INCREMENT,FinancialDataID INT, TrendDirection INT);
    
    IF (iStockID > 0) THEN
		INSERT INTO dmID (FinancialDataID, TrendDirection)
			SELECT fd.FinancialDataID, dm.TrendDirection FROM financialdata fd 
            INNER JOIN directionalmovement dm ON fd.FinancialDataID = dm.FinancialDataID
            WHERE fd.StockID = iStockID AND dm.TrendDirection > 0;
            
	ELSEIF (iStockID = 0) THEN
		INSERT INTO dmID (FinancialDataID, TrendDirection)
			SELECT FinancialDataID, TrendDirection FROM directionalmovement WHERE TrendDirection > 0;
            
	ELSEIF(iStockID = -1) THEN
		INSERT INTO dmID (FinancialDataID, TrendDirection)
			SELECT FinancialDataID, TrendDirection FROM directionalmovement WHERE UpdatedDate >=DATE_SUB(NOW(), INTERVAL iSettingsDefaultValue MINUTE) AND TrendDirection > 0;
    
    ELSEIF (iStockID = -2) THEN
		INSERT INTO dmID (FinancialDataID, TrendDirection)
			SELECT FinancialDataID, TrendDirection FROM directionalmovement WHERE UpdatedDate >=DATE_SUB(NOW(), INTERVAL 1 MINUTE) AND TrendDirection > 0;
    END IF;
    
    OPEN ThreeTrendDirectionCurs;
    LookAtAboveAndBelow: LOOP
    
		FETCH ThreeTrendDirectionCurs INTO iFinancialDataID, iTrendDirection, idmID;
        IF (done = 1) THEN 
			LEAVE LookAtAboveAndBelow;
		END IF;
        
        IF(idmID >= 2) THEN
			SELECT TrendDirection, FinancialDataID INTO iMinTrendDirection, iMinFinancialDataID FROM dmID WHERE dmIDID = (idmID - 1);
            SELECT TrendDirection, FinancialDataID  INTO iMaxTrendDirection, iMaxFinancialDataID FROM dmID WHERE dmIDID = (idmID + 1);
            
            -- if the middle doesn't equal the max Trend Direction (out of 3)
            IF(iTrendDirection <> iMaxTrendDirection) THEN
            
					-- If the Middle trend direction does not equal the min trend direction than we update the middle financial data ID
                    -- Otherwise we update the Max financial data ID, since the Middle/Min have the same trend direction
					IF(iTrendDirection <> iMinTrendDirection) THEN
						UPDATE directionalmovement SET TrendChange = 1, UpdatedDate = NOW() WHERE FinancialDataID = iFinancialDataID;
					ELSE 
						UPDATE directionalmovement SET TrendChange = 1, UpdatedDate = NOW() WHERE FinancialDataID = iMaxFinancialDataID;
					END IF;
            END IF;
		END IF;
    END LOOP LookAtAboveAndBelow;
    CLOSE ThreeTrendDirectionCurs;
	DROP TEMPORARY TABLE IF EXISTS dmID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetBoilerBandWidth` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetBoilerBandWidth`(IN iStockID INT, StartDateTime DATETIME,IN EndDateTime DATETIME)
BEGIN
	DECLARE iSettingsDefaultValue INT;
    
        -- Error Handler --
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 @errno = MYSQL_ERRNO, @ErrorMsg = MESSAGE_TEXT;
        insert into errorlog(ObjectName, ErrorNumber, ErrorMessage, CreatedDate)
        VALUES ('GetBoilerBandWidth', @errno, @ErrorMsg, NOW());
    END;
    -- Error Handler End --
    
    IF((SELECT COUNT(stock.StockID)  FROM stock WHERE stock.StockID = iStockID) = 0) THEN
			SELECT * FROM stock;
	END IF;
	
    SELECT settings.Value INTO iSettingsDefaultValue FROM settings WHERE Active = 1 AND settings.Name = 'Boilerband Width Hours';
    
	CREATE TEMPORARY TABLE IF NOT EXISTS  financialdataID(FinancialDataID INT PRIMARY KEY,StockID INT);
	CREATE TEMPORARY TABLE IF NOT EXISTS BoilerbandWidthTable(FinancialDataID INT PRIMARY KEY, BoilerBandWidth FLOAT, StockID INT);

    IF (StartDateTime IS NOT NULL AND EndDateTime IS NOT NULL) THEN 
		INSERT INTO financialdataID(FinancialDataID, StockID) 
			SELECT FinancialData.FinancialDataID, iStockID FROM FinancialData WHERE 
			FinancialData.StockID = iStockID AND 
			FinancialData.StockDate BETWEEN StartDateTime AND EndDateTime;
            
	ELSEIF (StartDateTime IS NOT NULL AND EndDateTime IS NULL) THEN 
		INSERT INTO financialdataID(FinancialDataID, StockID) 
			SELECT FinancialData.FinancialDataID, iStockID FROM FinancialData WHERE 
			FinancialData.StockID = iStockID AND 
			FinancialData.StockDate >= StartDateTime;
            
	ELSEIF (StartDateTime IS NULL AND EndDateTime IS NOT NULL) THEN 
		INSERT INTO financialdataID(FinancialDataID, StockID) 
			SELECT FinancialData.FinancialDataID, iStockID FROM FinancialData WHERE 
			FinancialData.StockID = iStockID AND 
			FinancialData.StockDate <= EndDateTime;
	ELSE 
		INSERT INTO financialdataID(FinancialDataID, StockID) 
			SELECT FinancialData.FinancialDataID, iStockID FROM FinancialData WHERE 
			FinancialData.StockID = iStockID AND 
            FinancialData.StockDate BETWEEN DATE_SUB(NOW(), INTERVAL iSettingsDefaultValue HOUR) AND NOW();
	END IF;
    
	 INSERT INTO BoilerbandWidthTable(FinancialDataID, BoilerBandWidth, StockID) 
		SELECT boilerband.FinancialDataID, boilerband.WidthPercentage, iStockID FROM boilerband WHERE
        boilerband.FinancialDataID IN (SELECT FinancialDataID FROM financialdataID);
	
    SELECT * FROM BoilerbandWidthTable;
		
        
	DROP TEMPORARY TABLE IF EXISTS financialdataID;
    DROP TEMPORARY TABLE IF EXISTS BoilerbandWidthTable;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getSetNullValuesFinancialdata` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getSetNullValuesFinancialdata`()
BEGIN
	
    DECLARE iRawFinancialDataID INT;
    DECLARE finished INT DEFAULT 0;
    
	DECLARE setNullCurs CURSOR FOR SELECT `RawFinancialDataID` from rawfinancialdata; -- WHERE -10000000.0 IN 
    -- (SELECT GROUP_CONCAT(`openPrice`, `highPrice`, `lowPrice`, `closePrice`, `volume`,`wma`, `ema`, `MACD`, `MACD_Signal`, `MACD_hist`, `boiler_band_upper`,
    -- `boiler_band_middle`, `boiler_band_lower`, `vwap`, `RoC`, `OBV`, `AD`, `SAR`, `ADX`) from rawfinancialdata);
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;
	
    -- Error Handler --
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 @errno = MYSQL_ERRNO, @ErrorMsg = MESSAGE_TEXT;
        insert into errorlog(ObjectName, ErrorNumber, ErrorMessage, CreatedDate)
        VALUES ('getSetNullValuesFinancialdata', @errno, @ErrorMsg, NOW());
    END;
    -- Error Handler End --
	
    OPEN setNullCurs;
	setNullLoop: LOOP
		FETCH setNullCurs INTO iRawFinancialDataID;
        IF finished = 1 THEN
			LEAVE setNullLoop;
		END IF;
        IF(SELECT openPrice FROM rawfinancialdata WHERE RawFinancialDataID = iRawFinancialDataID = -10000000.0) THEN
			UPDATE rawfinancialdata SET openPrice = NULL WHERE  RawFinancialDataID = iRawFinancialDataID;
		END IF;
        IF(SELECT highPrice FROM rawfinancialdata WHERE RawFinancialDataID = iRawFinancialDataID = -10000000.0) THEN
			UPDATE rawfinancialdata SET highPrice = NULL WHERE  RawFinancialDataID = iRawFinancialDataID;
		END IF;
        IF(SELECT lowPrice FROM rawfinancialdata WHERE RawFinancialDataID = iRawFinancialDataID = -10000000.0) THEN
			UPDATE rawfinancialdata SET lowPrice = NULL WHERE  RawFinancialDataID = iRawFinancialDataID;
		END IF;
        IF(SELECT closePrice FROM rawfinancialdata WHERE RawFinancialDataID = iRawFinancialDataID = -10000000.0) THEN
			UPDATE rawfinancialdata SET closePrice = NULL WHERE  RawFinancialDataID = iRawFinancialDataID;
		END IF;
        IF(SELECT wma FROM rawfinancialdata WHERE RawFinancialDataID = iRawFinancialDataID = -10000000.0) THEN
			UPDATE rawfinancialdata SET wma = NULL WHERE  RawFinancialDataID = iRawFinancialDataID;
		END IF;
        IF(SELECT volume FROM rawfinancialdata WHERE RawFinancialDataID = iRawFinancialDataID = -10000000.0) THEN
			UPDATE rawfinancialdata SET volume = NULL WHERE  RawFinancialDataID = iRawFinancialDataID;
		END IF;
        IF(SELECT ema FROM rawfinancialdata WHERE RawFinancialDataID = iRawFinancialDataID = -10000000.0) THEN
			UPDATE rawfinancialdata SET ema = NULL WHERE  RawFinancialDataID = iRawFinancialDataID;
		END IF;
        IF(SELECT MACD FROM rawfinancialdata WHERE RawFinancialDataID = iRawFinancialDataID = -10000000.0) THEN
			UPDATE rawfinancialdata SET MACD = NULL WHERE  RawFinancialDataID = iRawFinancialDataID;
		END IF;
        IF(SELECT openPrice FROM rawfinancialdata WHERE RawFinancialDataID = iRawFinancialDataID = -10000000.0) THEN
			UPDATE rawfinancialdata SET openPrice = NULL WHERE  RawFinancialDataID = iRawFinancialDataID;
		END IF;
        IF(SELECT MACD_Signal FROM rawfinancialdata WHERE RawFinancialDataID = iRawFinancialDataID = -10000000.0) THEN
			UPDATE rawfinancialdata SET MACD_Signal = NULL WHERE  RawFinancialDataID = iRawFinancialDataID;
		END IF;
        IF(SELECT MACD_hist FROM rawfinancialdata WHERE RawFinancialDataID = iRawFinancialDataID = -10000000.0) THEN
			UPDATE rawfinancialdata SET MACD_hist = NULL WHERE  RawFinancialDataID = iRawFinancialDataID;
		END IF;
        IF(SELECT boiler_band_upper FROM rawfinancialdata WHERE RawFinancialDataID = iRawFinancialDataID = -10000000.0) THEN
			UPDATE rawfinancialdata SET boiler_band_upper = NULL WHERE  RawFinancialDataID = iRawFinancialDataID;
		END IF;
        IF(SELECT boiler_band_lower FROM rawfinancialdata WHERE RawFinancialDataID = iRawFinancialDataID = -10000000.0) THEN
			UPDATE rawfinancialdata SET boiler_band_lower = NULL WHERE  RawFinancialDataID = iRawFinancialDataID;
		END IF;
        IF(SELECT boiler_band_middle FROM rawfinancialdata WHERE RawFinancialDataID = iRawFinancialDataID = -10000000.0) THEN
			UPDATE rawfinancialdata SET boiler_band_middle = NULL WHERE  RawFinancialDataID = iRawFinancialDataID;
		END IF;
         IF(SELECT vwap FROM rawfinancialdata WHERE RawFinancialDataID = iRawFinancialDataID = -10000000.0) THEN
			UPDATE rawfinancialdata SET vwap = NULL WHERE  RawFinancialDataID = iRawFinancialDataID;
		END IF;
         IF(SELECT RoC FROM rawfinancialdata WHERE RawFinancialDataID = iRawFinancialDataID = -10000000.0) THEN
			UPDATE rawfinancialdata SET RoC = NULL WHERE  RawFinancialDataID = iRawFinancialDataID;
		END IF;
		IF(SELECT OBV FROM rawfinancialdata WHERE RawFinancialDataID = iRawFinancialDataID = -10000000.0) THEN
			UPDATE rawfinancialdata SET OBV = NULL WHERE  RawFinancialDataID = iRawFinancialDataID;
		END IF;
        IF(SELECT AD FROM rawfinancialdata WHERE RawFinancialDataID = iRawFinancialDataID = -10000000.0) THEN
			UPDATE rawfinancialdata SET AD = NULL WHERE  RawFinancialDataID = iRawFinancialDataID;
		END IF;
        IF(SELECT SAR FROM rawfinancialdata WHERE RawFinancialDataID = iRawFinancialDataID = -10000000.0) THEN
			UPDATE rawfinancialdata SET SAR = NULL WHERE  RawFinancialDataID = iRawFinancialDataID;
		END IF;
        IF(SELECT ADX FROM rawfinancialdata WHERE RawFinancialDataID = iRawFinancialDataID = -10000000.0) THEN
			UPDATE rawfinancialdata SET ADX = NULL WHERE  RawFinancialDataID = iRawFinancialDataID;
		END IF;
	END LOOP setNullLoop;
    CLOSE setNullCurs;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InserFinDataLow` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `InserFinDataLow`(IN iStockID INT)
BEGIN
	
     -- Error Handler --
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 @errno = MYSQL_ERRNO, @ErrorMsg = MESSAGE_TEXT;
        insert into errorlog(ObjectName, ErrorNumber, ErrorMessage, CreatedDate)
        VALUES ('InserFinDataLow', @errno, @ErrorMsg, NOW());
    END;
    -- Error Handler End --
    
    SET SQL_SAFE_UPDATES = 0;
    
    CREATE TEMPORARY TABLE IF NOT EXISTS allDataForSymbols
	SELECT rfd.*, s.StockID AS StockID FROM rawfinancialdata rfd INNER JOIN stock s ON rfd.StockSymbol = s.Symbol
    WHERE s.StockID = iStockID;
    
    
    UPDATE FinancialData fd INNER JOIN allDataForSymbols ads 
    ON fd.StockID = ads.StockID AND fd.StockDate = ads.StockDateTime 
    SET fd.`Low` = ads.`lowPrice` WHERE fd.StockID = iStockID;
    
    -- DELETE FROM rawfinancialdata WHERE RawFinancialDataID IN (SELECT RawFinancialDataID FROM allDataForSymbol);
    
    DROP TEMPORARY TABLE IF EXISTS allDataForSymbols;
    
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `MassUpdateStockID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `MassUpdateStockID`()
BEGIN
	
    DECLARE iStockID INT;
    DECLARE done INT DEFAULT 0;
	
    DECLARE allStockIDs CURSOR FOR SELECT StockID FROM stocks.stock order by StockID asc;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
       -- Error Handler --
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 @errno = MYSQL_ERRNO, @ErrorMsg = MESSAGE_TEXT;
        insert into errorlog(ObjectName, ErrorNumber, ErrorMessage, CreatedDate)
        VALUES ('MassUpdateStockID', @errno, @ErrorMsg, NOW());
    END;
    -- Error Handler End --
    
    SET SQL_SAFE_UPDATES = 0;
    
		OPEN allStockIDs;
		processAllStocks: LOOP
		
			FETCH allStockIDs INTO iStockID;
				IF (done = 1) THEN 
					LEAVE processAllStocks;
				END IF;
				
                CREATE TEMPORARY TABLE IF NOT EXISTS t
                (StockDate DATETIME, FinancialDataID INT PRIMARY KEY);
                
                INSERT INTO t(StockDate, FinancialDataID)
                SELECT StockDate, FinancialDataID FROM FinancialData WHERE StockID = iStockID;
                
				UPDATE sar sr INNER JOIN t on sr.FinancialDataID = t.FinancialDataID SET sr.StockDate = t.StockDate;
				UPDATE macd md INNER JOIN t on md.FinancialDataID = t.FinancialDataID SET md.StockDate = t.StockDate;
				UPDATE directionalmovement dm INNER JOIN t on dm.FinancialDataID = t.FinancialDataID SET dm.StockDate = t.StockDate;
				UPDATE boilerband bb INNER JOIN t on bb.FinancialDataID = t.FinancialDataID SET bb.StockDate = t.StockDate;
				UPDATE chaikinoscillator co INNER JOIN t on co.FinancialDataID = t.FinancialDataID SET co.StockDate = t.StockDate;
                
                DROP TEMPORARY TABLE IF EXISTS t;
                
                
		END LOOP processAllStocks;
		CLOSE allStockIDs;
		
        SET SQL_SAFE_UPDATES = 0;
        ALTER TABLE `stocks`.`sar` DROP INDEX `FinancialDataID_UNIQUE`, ADD UNIQUE INDEX `FinancialDataID_UNIQUE` (`FinancialDataID`, `StockID`);
        ALTER TABLE `stocks`.`macd` DROP INDEX `FinancialDataID_UNIQUE`, ADD UNIQUE INDEX `FinancialDataID_UNIQUE` (`FinancialDataID`, `StockID`);
        ALTER TABLE `stocks`.`directionalmovement` DROP INDEX `FinancialDataID_UNIQUE`, ADD UNIQUE INDEX `FinancialDataID_UNIQUE` (`FinancialDataID`, `StockID`); 
        ALTER TABLE `stocks`.`chaikinoscillator` DROP INDEX `FinancialDataID_UNIQUE`, ADD UNIQUE INDEX `FinancialDataID_UNIQUE` (`FinancialDataID`, `StockID`);

    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `mdGetAllMinimumsAndMaximums` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `mdGetAllMinimumsAndMaximums`(IN iStockID INT, IN StartDate DATETIME, IN EndDate DATETIME, IN iTimeIndicatorID INT)
BEGIN
	DECLARE vTimeFrame VARCHAR(255) DEFAULT '';
    DECLARE vGroupByDateFormat VARCHAR(255) DEFAULT '';
            
            -- Error Handler --
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 @errno = MYSQL_ERRNO, @ErrorMsg = MESSAGE_TEXT;
        insert into errorlog(ObjectName, ErrorNumber, ErrorMessage, CreatedDate)
        VALUES ('mdGetAllMinimumsAndMaximums', @errno, @ErrorMsg, NOW());
    END;
			-- Error Handler End --
            
	-- Get the Time amount and unit we're using to look at minimums
    SELECT CONCAT(TRIM(AmountOfTimeUnit), ' ', TRIM(TimeUnit)) , GroupByDateFormat INTO vTimeFrame, vGroupByDateFormat FROM TimeIndicator WHERE TimeIndicatorID = iTimeIndicatorID;

	-- Only grabs MACD data that pertains to this stock + time frame
	DROP TEMPORARY TABLE IF EXISTS RelevantMACD;
	CREATE TEMPORARY TABLE IF NOT EXISTS RelevantMACD
	SELECT md.MACDID, md.MACD, md.MACD_Signal, md.CrossedZero, md.TrendDirection, md.TrendChange, md.FinancialDataID, fd.StockDate, fd.`Close` FROM macd md INNER JOIN FinancialData fd ON (md.FinancialDataID = fd.FinancialDataID AND fd.StockID = iStockID)
    WHERE fd.StockDate BETWEEN StartDate AND EndDate;
    
	-- Grabs minimum value in each set time amount and unit
	DROP TEMPORARY TABLE IF EXISTS MACDTimeFrameMins;
    CREATE TEMPORARY TABLE IF NOT EXISTS MACDTimeFrameMins (
    StockDate DATETIME, MACDMin DECIMAL(20,5), MACDID INT PRIMARY KEY,FinancialDataID INT);
    
	INSERT INTO MACDTimeFrameMins (MACDID)
	SELECT DISTINCT FIRST_VALUE(MACDID) OVER (PARTITION BY DATE_FORMAT(StockDate, vGroupByDateFormat) ORDER BY `MACD` ASC) FROM RelevantMACD;
	
    UPDATE MACDTimeFrameMins mtfm LEFT OUTER JOIN RelevantMACD rm ON mtfm.MACDID = rm.MACDID
    SET mtfm.StockDate = rm.StockDate, mtfm.MACDMin = rm.MACD, mtfm.FinancialDataID = rm.FinancialDataID
    WHERE rm.MACDID > 1;

	-- Grabs maximum value in each set time amount and unit
	DROP TEMPORARY TABLE IF EXISTS MACDTimeFrameMaxes;
    CREATE TEMPORARY TABLE IF NOT EXISTS MACDTimeFrameMaxes (
    StockDate DATETIME, MACDMax DECIMAL(20,5), MACDID INT PRIMARY KEY,FinancialDataID INT);
    
	INSERT INTO MACDTimeFrameMaxes (MACDID)
	SELECT DISTINCT FIRST_VALUE(MACDID) OVER (PARTITION BY DATE_FORMAT(StockDate, vGroupByDateFormat) ORDER BY `MACD` DESC) FROM RelevantMACD;
	
    UPDATE MACDTimeFrameMaxes mtfm LEFT OUTER JOIN RelevantMACD rm ON mtfm.MACDID = rm.MACDID
    SET mtfm.StockDate = rm.StockDate, mtfm.MACDMax = rm.MACD, mtfm.FinancialDataID = rm.FinancialDataID
    WHERE rm.MACDID > 1;
    
    -- SELECT * FROM MACDTimeFrameMaxes;
	-- SELECT * FROM MACDTimeFrameMins;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `mdGetLocalMinsAndMaxes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `mdGetLocalMinsAndMaxes`()
BEGIN
	-- Creates Three temporary tables with all local mins and maxes in them.
    -- Temporary Table Names: mdLocalMaxes and mdLocalMins, mdLocalMaxAndMins
    
				-- Error Handler --
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 @errno = MYSQL_ERRNO, @ErrorMsg = MESSAGE_TEXT;
        insert into errorlog(ObjectName, ErrorNumber, ErrorMessage, CreatedDate)
        VALUES ('mdGetLocalMinsAndMaxes', @errno, @ErrorMsg, NOW());
    END;
			-- Error Handler End --
	
	
	DROP TEMPORARY TABLE IF EXISTS mdLocalMaxes;
	CREATE TEMPORARY TABLE IF NOT EXISTS mdLocalMaxes (
    FinancialDataID INT, MACDID INT PRIMARY KEY, StockDate DATETIME, MACDMax DECIMAL(20,5), MacdMaxRank INT, MacdLastMax INT);
	
    SET @iLastMACDMaxRank = 100000000;
    
    -- Gets the ranking of all the MACD Maxes
	INSERT INTO mdLocalMaxes(MacdMaxRank, MACDID, FinancialDataID, StockDate, MACDMax)
	SELECT DENSE_RANK() OVER (ORDER BY MacdMax DESC) as MacdMaxRank,MACDID, FinancialDataID, StockDate, MACDMax
    FROM MACDTimeFrameMaxes 
    WHERE MACDMax IS NOT NULL
	ORDER BY MacdMaxRank ASC;
    
    -- Updates MacdLastMax only if the MACD rank is the lowest seen so far ordered by stock date
    UPDATE mdLocalMaxes SET MacdLastMax = 
		CASE WHEN MacdMaxRank < @iLastMACDMaxRank THEN MacdMaxRank AND @iLastMACDMaxRank := MacdMaxRank 
        ELSE NULL END
        ORDER BY StockDate ASC;
        
	DROP TEMPORARY TABLE IF EXISTS mdLocalMins;
	CREATE TEMPORARY TABLE IF NOT EXISTS mdLocalMins (
    FinancialDataID INT, MACDID INT PRIMARY KEY, StockDate DATETIME, MACDMin DECIMAL(20,5), MacdMinRank INT, MacdLastMin INT);
    
	SET @iLastMACDMinRank = 100000000;
    
    -- Gets the ranking of all the MACD Mins
	INSERT INTO mdLocalMins(MacdMinRank, MACDID, FinancialDataID, StockDate, MACDMin)
	SELECT DENSE_RANK() OVER (ORDER BY MACDMin ASC) AS MacdMinRank, MACDID, FinancialDataID, StockDate, MACDMin
    FROM MACDTimeFrameMins 
    WHERE MACDMin IS NOT NULL
	ORDER BY MacdMinRank ASC;
    
	-- Updates MacdLastMin only if the MACD rank is the lowest seen so far ordered by stock date
    UPDATE mdLocalMins SET MacdLastMin = 
		CASE WHEN MacdMinRank < @iLastMACDMinRank THEN MacdMinRank AND @iLastMACDMinRank := MacdMinRank 
        ELSE NULL END
        ORDER BY StockDate ASC;
	
	DROP TEMPORARY TABLE IF EXISTS mdLocalMaxAndMins;
	CREATE TEMPORARY TABLE IF NOT EXISTS mdLocalMaxAndMins (
    FinancialDataID INT, MACDID INT PRIMARY KEY, StockDate DATETIME, MACDValue DECIMAL(20,5), MinOrMax VARCHAR(255));
	
    INSERT INTO mdLocalMaxAndMins(FinancialDataID, MACDID, StockDate, MACDValue, MinOrMax)
	SELECT FinancialDataID, MACDID, StockDate, MACDMax, 'Max' FROM mdLocalMaxes WHERE MacdLastMax IS NOT NULL ORDER BY StockDate ASC;
    
    INSERT INTO mdLocalMaxAndMins(FinancialDataID, MACDID, StockDate, MACDValue, MinOrMax)
	SELECT FinancialDataID, MACDID, StockDate, MACDMin, 'Min' FROM mdLocalMins WHERE MacdLastMin IS NOT NULL ORDER BY StockDate ASC;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `mdGetSlope` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `mdGetSlope`(IN iStockID INT, IN StartDate DATETIME, IN EndDate DATETIME)
BEGIN
	
    DECLARE finished INT DEFAULT 0;
    DECLARE iMACDID INT;
    DECLARE dtStartRange DATETIME;
    DECLARE dtEndRange DATETIME;
    
    
	DECLARE updateStartEndRange CURSOR FOR SELECT MACDID, StartRange, EndRange FROM MACDTrendRange;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;

        -- Error Handler --
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 @errno = MYSQL_ERRNO, @ErrorMsg = MESSAGE_TEXT;
        insert into errorlog(ObjectName, ErrorNumber, ErrorMessage, CreatedDate)
        VALUES ('mdGetSlope', @errno, @ErrorMsg, NOW());
    END;
    -- Error Handler End --
        
    
    DROP TEMPORARY TABLE IF EXISTS RelevantMACDSlope;
	CREATE TEMPORARY TABLE IF NOT EXISTS RelevantMACDSlope (MACDID INT PRIMARY KEY, StockDate DATETIME, MACD FLOAT, CrossedZero INT, TrendDirection INT, TrendChange INT, StartRange DATETIME, EndRange DATETIME, INDEX StockDt (StockDate) ); -- TrendSlope FLOAT,
    
	INSERT INTO RelevantMACDSlope (MacdID, StockDate, MACD, CrossedZero, TrendDirection, TrendChange) 
	SELECT md.MacdID, fd.StockDate, md.MACD, md.CrossedZero, md.TrendDirection, md.TrendChange
	FROM macd md INNER JOIN FinancialData fd ON md.FinancialDataID = fd.FinancialDataID 
	WHERE fd.StockDate BETWEEN StartDate AND EndDate AND fd.StockID=iStockID ORDER BY fd.StockDate ASC;
    
    
    DROP TEMPORARY TABLE IF EXISTS MACDTrendRange;
	CREATE TEMPORARY TABLE IF NOT EXISTS MACDTrendRange(MACDID INT PRIMARY KEY,StartRange DATETIME, EndRange DATETIME); 
    
	INSERT INTO MACDTrendRange(MACDID, StartRange, EndRange)
	SELECT MACDID, StockDate, LEAD(StockDate) OVER (Order By StockDate ASC) FROM RelevantMACDSlope WHERE TrendChange =  1 ORDER BY StockDate ASC;
	
    OPEN updateStartEndRange;
    UpdateReleventMACDTempTable: LOOP 
		FETCH updateStartEndRange INTO iMACDID, dtStartRange, dtEndRange;
            IF (finished = 1) THEN
				LEAVE UpdateReleventMACDTempTable;
			END IF;
		UPDATE RelevantMACDSlope SET StartRange = dtStartRange, EndRange = dtEndRange WHERE StockDate BETWEEN dtStartRange AND dtEndRange;
	END LOOP;
    CLOSE updateStartEndRange;
    
    DROP TEMPORARY TABLE IF EXISTS MACDSlopeInformation;
    CREATE TEMPORARY TABLE MACDSlopeInformation
    SELECT *, AVG(MACD) OVER (PARTITION BY StartRange, EndRange ORDER BY StockDate ASC) AS TrendSlope FROM RelevantMACDSlope;
    /*
    with getMACDTrendAvg AS (
    SELECT AVG(MACD) OVER (PARTITION BY StartRange, EndRange ORDER BY StockDate ASC) AS WithTrendSlope, MACDID AS WithMACDID FROM RelevantMACDSlope2)
    UPDATE RelevantMACDSlope JOIN getMACDTrendAvg ON MACDID = getMACDTrendAvg.WithMACDID SET RelevantMACDSlope.TrendSlope = getMACDTrendAvg.WithTrendSlope;
    */
    -- UPDATE RelevantMACDSlope SET TrendSlope = AVG(MACD) OVER (PARTITION BY StartRange, EndRange ORDER BY StockDate ASC) FROM RelevantMACDSlope;
    
/*
    SELECT MIN(StartRange) INTO @StartRange FROM MACDTrendRange;
    SELECT MIN(EndRange) INTO @EndRange FROM MACDTrendRange;
    	
    UPDATE RelevantMACDSlope rmds LEFT OUTER JOIN MACDTrendRange mdtr ON rmds.MACDID = mdtr.MACDID
    SET rmds.StartRange = mdtr.StartRange, rmds.EndRange = mdtr.EndRange WHERE rmds.StockDate BETWEEN mdtr.StartRange AND mdtr.EndRange;
    
    UPDATE RelevantMACDSlope SET StartRange = StartRange
    WHERE StockDate BETWEEN StartRange AND EndRange;
    */
    -- CASE WHEN StockDate BETWEEN StartRange AND EndRange THEN StartRange AND @StartRange := EndRange ELSE @StartRange END; 
    -- ,EndRange = CASE WHEN StockDate BETWEEN StartRange AND EndRange THEN EndRange AND @EndRange:= EndRange ELSE @EndRange END;
    -- WHERE StartRange IS NULL;
    -- EndRange = CASE WHEN StockDate BETWEEN StartRange AND EndRange THEN EndRange AND @EndRange:= EndRange) ELSE @EndRange END;
    
	/*
	DROP TEMPORARY TABLE IF EXISTS MACDSlope;
	CREATE TEMPORARY TABLE IF NOT EXISTS MACDSlope(MACDID INT PRIMARY KEY,StockDate DATETIME, MACD FLOAT, CrossedZero INT, TrendDirection INT, TrendChange INT, StartRange DATETIME, EndRange DATETIME); 

    INSERT INTO MACDSlope (MACDID, StockDate, MACD, CrossedZero, TrendDirection, TrendChange, StartRange, EndRange) 
	SELECT rmds.MACDID, rmds.StockDate, rmds.MACD, rmds.CrossedZero, rmds.TrendDirection, rmds.TrendChange, 
	CASE WHEN CAST(rmds.StockDate AS DATETIME) BETWEEN CAST(mdtr.StartRange AS DATETIME) AND mdtr.EndRange THEN CAST(mdtr.StartRange AS DATETIME) AND @StartRange := CAST(mdtr.StartRange AS DATETIME) ELSE CAST(@StartRange AS DATETIME) END AS StartRange,
	CASE WHEN CAST(rmds.StockDate AS DATETIME) BETWEEN CAST(mdtr.StartRange AS DATETIME) AND mdtr.EndRange THEN mdtr.EndRange AND @EndRange:= CAST(mdtr.EndRange AS DATETIME) ELSE CAST(@EndRange AS DATETIME) END AS EndRange
	FROM RelevantMACDSlope rmds LEFT OUTER JOIN MACDTrendRange mdtr ON rmds.MACDID = mdtr.MACDID
	ORDER BY CAST(rmds.StockDate AS DATETIME) ASC; 
	*/
    -- SELECT * FROM RelevantMACDSlope;
    SELECT * FROM MACDSlopeInformation;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ProcessQuarterlyData` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `ProcessQuarterlyData`()
BEGIN
	
     -- Error Handler --
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 @errno = MYSQL_ERRNO, @ErrorMsg = MESSAGE_TEXT;
        insert into errorlog(ObjectName, ErrorNumber, ErrorMessage, CreatedDate)
        VALUES ('ProcessQuarterlyData', @errno, @ErrorMsg, NOW());
    END;
    -- Error Handler End --
    
    
    CALL stocks.RawEarningToEarnings();
	CALL stocks.RawBalanceSheetToBalanceSheet();
	CALL stocks.RawCashFlowToCashFlow();
	CALL stocks.RawIncomeStatementToIncomeStatement();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `processRawTableLoop` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `processRawTableLoop`(IN iTotalThreads INT, IN iRemainder INT)
BEGIN
	
    DECLARE StockSym VARCHAR(45);
    DECLARE done INT DEFAULT 0;
    
    DECLARE iThreadID INT;
    DECLARE vEvent VARCHAR(255);
    DECLARE ieventID INT;
	
    DECLARE ichecker INT DEFAULT 0;
    DECLARE iSymCount INT DEFAULT 0;
    
    DECLARE iStockID INT;
    DECLARE iTransactionID INT;
    DECLARE iRowsInserted INT DEFAULT 0;
    
    DECLARE allSymbolsCurs CURSOR FOR SELECT Symbol FROM rawFinancialDataQueue WHERE RawFinancialDataQueueID % iTotalThreads = iRemainder ORDER BY InsertedTime ASC;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
       -- Error Handler --
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 @errno = MYSQL_ERRNO, @ErrorMsg = MESSAGE_TEXT;
        insert into errorlog(ObjectName, ErrorNumber, ErrorMessage, CreatedDate)
        VALUES ('processRawTableLoop', @errno, @ErrorMsg, NOW());
    END;
    -- Error Handler End --
    
    SELECT PS_CURRENT_THREAD_ID() INTO iThreadID;
	SET vEvent = CONCAT('ProcessRawDataThread', CAST(iRemainder AS CHAR));
	
	IF ( (SELECT COUNT(ProcessThreadManagerID) FROM ProcessThreadManager WHERE `Event` = vEvent) = 0) THEN
		INSERT INTO ProcessThreadManager(ThreadID, `Event`, StartDateTime)
		VALUES (iThreadID, vEvent, NOW());
		
		SELECT LAST_INSERT_ID() INTO ieventID;
	ELSE 
		SELECT ProcessThreadManagerID INTO ieventID FROM ProcessThreadManager WHERE `Event` = vEvent;
        
		UPDATE ProcessThreadManager SET ThreadID = iThreadID, `Table` = NULL, StartDateTime = NOW() WHERE ProcessThreadManagerID = ieventID;
	END IF;
    WHILE (ichecker = 0) DO
		IF ( (SELECT COUNT(ProcessThreadManagerID) FROM ProcessThreadManager WHERE `Table` = 'rawFinancialDataQueue') = 0) THEN

				UPDATE ProcessThreadManager SET `Table` = 'rawFinancialDataQueue', StartDateTime = NOW() WHERE ProcessThreadManagerID = ieventID;
				DO SLEEP(.25);
				
				IF ( (SELECT COUNT(ProcessThreadManagerID) FROM ProcessThreadManager WHERE `Table` = 'rawFinancialDataQueue') = 1) THEN
					SELECT COUNT(Symbol) INTO iSymCount FROM stocks.rawFinancialDataQueue;
					UPDATE ProcessThreadManager SET `Table` = NULL, StartDateTime = NOW() WHERE ProcessThreadManagerID = ieventID;
                    SET ichecker = 1;
				ELSE
					UPDATE ProcessThreadManager SET `Table` = NULL, StartDateTime = NOW() WHERE ProcessThreadManagerID = ieventID;
				END IF;
		END IF;
    END WHILE;
    
    IF ( iSymCount > 0 ) THEN

		OPEN allSymbolsCurs;
		processAllRawStockSymbols: LOOP
		
			FETCH allSymbolsCurs INTO StockSym;
				IF (done = 1) THEN 
					LEAVE processAllRawStockSymbols;
				END IF;
				
                SELECT StockID INTO iStockID FROM stock WHERE Symbol = StockSym;
                
				INSERT INTO raw_data_to_data_transaction(StockID, StartDateTime, CreatedDate) 
				VALUES (iStockID, NOW(), NOW());

                SELECT LAST_INSERT_ID() INTO iTransactionID;
                
				CALL rawFinancialDataToFinancialData(StockSym, ieventID, iRowsInserted);
                
				DELETE FROM rawfinancialdata WHERE StockSymbol = StockSym;
				DELETE FROM rawFinancialDataQueue WHERE Symbol = StockSym;
                
                IF(iRowsInserted > 0) THEN
					UPDATE raw_data_to_data_transaction SET RecordQuantity = iRowsInserted, EndDateTime = NOW() WHERE Raw_Data_To_DataID = iTransactionID;
				ELSE 
					DELETE FROM raw_data_to_data_transaction WHERE Raw_Data_To_DataID = iTransactionID;
                END IF;
				
                
		END LOOP processAllRawStockSymbols;
		CLOSE allSymbolsCurs;
		/*
		SET SQL_SAFE_UPDATES = 0;
        IF ( (SELECT COUNT(ProcessThreadManagerID) FROM ProcessThreadManager WHERE `Table` = 'stock') = 0) THEN

			UPDATE ProcessThreadManager SET `Table` = 'stock', StartDateTime = NOW() WHERE ProcessThreadManagerID = ieventID;

            IF ( (SELECT COUNT(ProcessThreadManagerID) FROM ProcessThreadManager WHERE `Table` = 'stock') = 1) THEN
				UPDATE stock SET NoData = 1 WHERE LastStockDate IS NULL AND CreatedDate < DATE_SUB(NOW(), INTERVAL 1 MONTH);
				UPDATE ProcessThreadManager SET `Table` = NULL, StartDateTime = NOW() WHERE ProcessThreadManagerID = ieventID;
			ELSE
				UPDATE ProcessThreadManager SET `Table` = NULL, StartDateTime = NOW() WHERE ProcessThreadManagerID = ieventID;
            END IF;
		END IF;
		
        IF ((SELECT COUNT(*) FROM rawfinancialdata) > 0) THEN
			
			IF ( (SELECT COUNT(ProcessThreadManagerID) FROM ProcessThreadManager WHERE `Table` = 'rawFinancialDataQueue') = 0) THEN

				UPDATE ProcessThreadManager SET `Table` = 'rawFinancialDataQueue', StartDateTime = NOW() WHERE ProcessThreadManagerID = ieventID;

				IF ( (SELECT COUNT(ProcessThreadManagerID) FROM ProcessThreadManager WHERE `Table` = 'rawFinancialDataQueue') = 1) THEN
				
					INSERT IGNORE INTO rawFinancialDataQueue(Symbol, InsertedTime)
					SELECT distinct StockSymbol, NOW() FROM rawfinancialdata WHERE rawfinancialdata.StockSymbol NOT IN (SELECT Symbol from rawFinancialDataQueue);
					UPDATE ProcessThreadManager SET `Table` = NULL, StartDateTime = NOW() WHERE ProcessThreadManagerID = ieventID;
				ELSE
					UPDATE ProcessThreadManager SET `Table` = NULL, StartDateTime = NOW() WHERE ProcessThreadManagerID = ieventID;
				END IF;
			END IF;
		END IF;
	*/
    ELSE
		DO SLEEP(5);
	END IF;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RawBalanceSheetToBalanceSheet` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `RawBalanceSheetToBalanceSheet`()
BEGIN
        -- Error Handler --
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 @errno = MYSQL_ERRNO, @ErrorMsg = MESSAGE_TEXT;
        insert into errorlog(ObjectName, ErrorNumber, ErrorMessage, CreatedDate)
        VALUES ('RawBalanceSheetToBalanceSheet', @errno, @ErrorMsg, NOW());
    END;
    -- Error Handler End --
    
    SET SQL_SAFE_UPDATES = 0;
    
    IF ( (SELECT COUNT(StockSymbol) FROM RawBalanceSheet) > 0) THEN
        
        
		CREATE TEMPORARY TABLE IF NOT EXISTS NewRecords
			SELECT `rbs`.`StockSymbol`, `co`.`StockID`, `rbs`.`fiscalDateEnding`, `rbs`.`reportedCurrency`,`rbs`.`totalAssets`,`rbs`.`totalCurrentAssets`,`rbs`.`cashAndCashEquivalentsAtCarryingValue`,
			`rbs`.`cashAndShortTermInvestments`,`rbs`.`inventory`,`rbs`.`currentNetReceivables`,`rbs`.`totalNonCurrentAssets`,`rbs`.`propertyPlantEquipment`,`rbs`.`accumulatedDepreciationAmortizationPPE`,
            `rbs`.`intangibleAssets`,`rbs`.`intangibleAssetsExcludingGoodwill`,`rbs`.`goodwill`,`rbs`.`investments`,`rbs`.`longTermInvestments`,`rbs`.`shortTermInvestments`,`rbs`.`otherCurrentAssets`,
            `rbs`.`otherNonCurrentAssets`,`rbs`.`totalLiabilities`,`rbs`.`totalCurrentLiabilities`,`rbs`.`currentAccountsPayable`,`rbs`.`deferredRevenue`,`rbs`.`currentDebt`,`rbs`.`shortTermDebt`,
            `rbs`.`totalNonCurrentLiabilities`,`rbs`.`capitalLeaseObligations`,`rbs`.`longTermDebt`,`rbs`.`currentLongTermDebt`,`rbs`.`longTermDebtNoncurrent`,`rbs`.`shortLongTermDebtTotal`,`rbs`.`otherCurrentLiabilities`,
            `rbs`.`otherNonCurrentLiabilities`,`rbs`.`totalShareholderEquity`,`rbs`.`treasuryStock`,`rbs`.`retainedEarnings`,`rbs`.`commonStock`,`rbs`.`commonStockSharesOutstanding`, NOW() AS `CreatedDate`
            FROM `stocks`.`RawBalanceSheet` rbs
			INNER JOIN CompanyOverview co ON rbs.StockSymbol = co.Symbol
			LEFT OUTER JOIN BalanceSheet bs ON bs.StockID = co.StockID AND bs.`FiscalDateEnding` = `rbs`.`fiscalDateEnding`
			WHERE bs.StockID IS NULL;

		INSERT INTO `stocks`.`BalanceSheet`
			(`StockID`,`FiscalDateEnding`,`ReportedCurrency`,`TotalAssets`,`TotalCurrentAssets`,`CashAndCashEquivalentsAtCarryingValue`,`CashAndShortTermInvestments`,
			`Inventory`,`CurrentNetReceivables`,`TotalNonCurrentAssets`,`PropertyPlantEquipment`,`AccumulatedDepreciationAmortizationPPE`,`IntangibleAssets`,`IntangibleAssetsExcludingGoodwill`,`Goodwill`,`Investments`,
            `LongTermInvestments`,`ShortTermInvestments`,`OtherCurrentAssets`,`OtherNonCurrentAssets`,`TotalLiabilities`,`TotalCurrentLiabilities`,`CurrentAccountsPayable`,`DeferredRevenue`,`CurrentDebt`,`ShortTermDebt`,
            `TotalNonCurrentLiabilities`,`CapitalLeaseObligations`,`LongTermDebt`,`CurrentLongTermDebt`,`LongTermDebtNoncurrent`,`ShortLongTermDebtTotal`,`OtherCurrentLiabilities`,`OtherNonCurrentLiabilities`,`TotalShareholderEquity`,
            `TreasuryStock`,`RetainedEarnings`,`CommonStock`,`CommonStockSharesOutstanding`,`CreatedDate`)
			SELECT `StockID`, `fiscalDateEnding`, `reportedCurrency`,`totalAssets`,`totalCurrentAssets`,`cashAndCashEquivalentsAtCarryingValue`,
			`cashAndShortTermInvestments`,`inventory`,`currentNetReceivables`,`totalNonCurrentAssets`,`propertyPlantEquipment`,`accumulatedDepreciationAmortizationPPE`,
			`intangibleAssets`,`intangibleAssetsExcludingGoodwill`,`goodwill`,`investments`,`longTermInvestments`,`shortTermInvestments`,`otherCurrentAssets`,
			`otherNonCurrentAssets`,`totalLiabilities`,`totalCurrentLiabilities`,`currentAccountsPayable`,`deferredRevenue`,`currentDebt`,`shortTermDebt`,
			`totalNonCurrentLiabilities`,`capitalLeaseObligations`,`longTermDebt`,`currentLongTermDebt`,`longTermDebtNoncurrent`,`shortLongTermDebtTotal`,`otherCurrentLiabilities`,
			`otherNonCurrentLiabilities`,`totalShareholderEquity`,`treasuryStock`,`retainedEarnings`,`commonStock`,`commonStockSharesOutstanding`, `CreatedDate` FROM NewRecords;

		DELETE FROM RawBalanceSheet rbs WHERE rbs.StockSymbol IN (SELECT StockSymbol FROM NewRecords);
		DROP TEMPORARY TABLE IF EXISTS NewRecords;

		UPDATE `stocks`.`BalanceSheet` bs
			INNER JOIN CompanyOverview co ON bs.StockID = co.StockID
			INNER JOIN RawBalanceSheet rbs ON co.Symbol = rbs.StockSymbol
			SET 
				`bs`.`ReportedCurrency` = `rbs`.`reportedCurrency`,`bs`.`TotalAssets` = `rbs`.totalAssets, `bs`.`TotalCurrentAssets` = `rbs`.totalCurrentAssets,
                `bs`.`CashAndCashEquivalentsAtCarryingValue` = `rbs`.cashAndCashEquivalentsAtCarryingValue, `bs`.`CashAndShortTermInvestments` = `rbs`.cashAndShortTermInvestments, `bs`.`Inventory` = `rbs`.inventory,
                `bs`.`CurrentNetReceivables` = `rbs`.currentNetReceivables, `bs`.`TotalNonCurrentAssets` = `rbs`.totalNonCurrentAssets, `bs`.`PropertyPlantEquipment` = `rbs`.propertyPlantEquipment,
                `bs`.`AccumulatedDepreciationAmortizationPPE` = `rbs`.accumulatedDepreciationAmortizationPPE, `bs`.`IntangibleAssets` = `rbs`.intangibleAssets,
                `bs`.`IntangibleAssetsExcludingGoodwill` = `rbs`.intangibleAssetsExcludingGoodwill, `bs`.`Goodwill` = `rbs`.goodwill, `bs`.`Investments` = `rbs`.investments,
                `bs`.`LongTermInvestments` = `rbs`.longTermInvestments, `bs`.`ShortTermInvestments` = `rbs`.shortTermInvestments, `bs`.`OtherCurrentAssets` = `rbs`.otherCurrentAssets, `bs`.`OtherNonCurrentAssets` = `rbs`.otherNonCurrentAssets,
                `bs`.`TotalLiabilities` = `rbs`.totalLiabilities,`bs`.`TotalCurrentLiabilities` = `rbs`.totalCurrentLiabilities,`bs`.`CurrentAccountsPayable` = `rbs`.currentAccountsPayable,`bs`.`DeferredRevenue` = `rbs`.deferredRevenue,
                `bs`.`CurrentDebt` = `rbs`.currentDebt,`bs`.`ShortTermDebt` = `rbs`.shortTermDebt,`bs`.`TotalNonCurrentLiabilities` = `rbs`.totalNonCurrentLiabilities,`bs`.`CapitalLeaseObligations` = `rbs`.capitalLeaseObligations,
                `bs`.`LongTermDebt` = `rbs`.longTermDebt, `bs`.`CurrentLongTermDebt` = `rbs`.currentLongTermDebt, `bs`.`LongTermDebtNoncurrent` = `rbs`.longTermDebtNoncurrent, `bs`.`ShortLongTermDebtTotal` = `rbs`.shortLongTermDebtTotal,
                `bs`.`OtherCurrentLiabilities` = `rbs`.otherCurrentLiabilities, `bs`.`OtherNonCurrentLiabilities` = `rbs`.otherNonCurrentLiabilities, `bs`.`TotalShareholderEquity` = `rbs`.totalShareholderEquity,
                `bs`.`TreasuryStock` = `rbs`.treasuryStock, `bs`.`RetainedEarnings` = `rbs`.retainedEarnings, `bs`.`CommonStock` = `rbs`.commonStock, `bs`.`CommonStockSharesOutstanding` = `rbs`.commonStockSharesOutstanding
			WHERE bs.`FiscalDateEnding` = `rbs`.`fiscalDateEnding` AND rbs.StockSymbol = co.Symbol;
        
        DELETE FROM RawBalanceSheet rbs WHERE rbs.StockSymbol IN (SELECT Symbol FROM CompanyOverview);
		
    END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RawCashFlowToCashFlow` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `RawCashFlowToCashFlow`()
BEGIN
        -- Error Handler --
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 @errno = MYSQL_ERRNO, @ErrorMsg = MESSAGE_TEXT;
        insert into errorlog(ObjectName, ErrorNumber, ErrorMessage, CreatedDate)
        VALUES ('RawCashFlowToCashFlow', @errno, @ErrorMsg, NOW());
    END;
    -- Error Handler End --
    
    SET SQL_SAFE_UPDATES = 0;
    
    IF ( (SELECT COUNT(StockSymbol) FROM RawCashFlow) > 0) THEN
        
        CREATE TEMPORARY TABLE IF NOT EXISTS DuplicatedRecords
			SELECT StockSymbol, fiscalDateEnding, MAX(RawCashFlowID) AS LatestEntry
			FROM RawCashFlow GROUP BY StockSymbol, fiscalDateEnding HAVING COUNT(RawCashFlowID) > 1;
            
		DELETE rcf
			FROM RawCashFlow rcf INNER JOIN DuplicatedRecords dr ON rcf.StockSymbol = dr.StockSymbol AND rcf.fiscalDateEnding = dr.fiscalDateEnding
			WHERE rcf.RawCashFlowID < dr.LatestEntry;
		
		DROP TEMPORARY TABLE IF EXISTS DuplicatedRecords;
        DROP TEMPORARY TABLE IF EXISTS NewRecords;
        
		CREATE TEMPORARY TABLE IF NOT EXISTS NewRecords
			SELECT `co`.`StockID`, `rcf`.`fiscalDateEnding`, `rcf`.`StockSymbol`, `rcf`.`reportedCurrency`,`rcf`.`operatingCashflow`,`rcf`.`paymentsForOperatingActivities`,`rcf`.`proceedsFromOperatingActivities`,
            `rcf`.`changeInOperatingLiabilities`,`rcf`.`changeInOperatingAssets`,`rcf`.`depreciationDepletionAndAmortization`,`rcf`.`capitalExpenditures`,`rcf`.`changeInReceivables`,
            `rcf`.`changeInInventory`,`rcf`.`profitLoss`,`rcf`.`cashflowFromInvestment`,`rcf`.`cashflowFromFinancing`,`rcf`.`proceedsFromRepaymentsOfShortTermDebt`,
            `rcf`.`paymentsForRepurchaseOfCommonStock`,`rcf`.`paymentsForRepurchaseOfEquity`,`rcf`.`paymentsForRepurchaseOfPreferredStock`,`rcf`.`dividendPayout`,
            `rcf`.`dividendPayoutCommonStock`,`rcf`.`dividendPayoutPreferredStock`,`rcf`.`proceedsFromIssuanceOfCommonStock`,`rcf`.`proceedsFromIssuanceOfLongTermDebtAndCapitalSecuritiesNet`,
            `rcf`.`proceedsFromIssuanceOfPreferredStock`,`rcf`.`proceedsFromRepurchaseOfEquity`,`rcf`.`proceedsFromSaleOfTreasuryStock`,
            `rcf`.`changeInCashAndCashEquivalents`,`rcf`.`changeInExchangeRate`, `rcf`.`netIncome`, NOW() AS `CreatedDate` 
            FROM `stocks`.`RawCashFlow` `rcf`
			INNER JOIN CompanyOverview co ON rcf.StockSymbol = co.Symbol
			LEFT OUTER JOIN CashFlow cf ON cf.StockID = co.StockID AND rcf.`fiscalDateEnding` = cf.`FiscalDateEnding`
			WHERE cf.StockID IS NULL;

		INSERT INTO `stocks`.`CashFlow` (`StockID`,`FiscalDateEnding`,`ReportedCurrency`,`OperatingCashflow`,`PaymentsForOperatingActivities`,`ProceedsFromOperatingActivities`,
			`ChangeInOperatingLiabilities`,`ChangeInOperatingAssets`,`DepreciationDepletionAndAmortization`,`CapitalExpenditures`,`ChangeInReceivables`,`ChangeInInventory`,`ProfitLoss`,
            `CashflowFromInvestment`,`CashflowFromFinancing`,`ProceedsFromRepaymentsOfShortTermDebt`,`PaymentsForRepurchaseOfCommonStock`,`PaymentsForRepurchaseOfEquity`,
            `PaymentsForRepurchaseOfPreferredStock`,`DividendPayout`,`DividendPayoutCommonStock`,`DividendPayoutPreferredStock`,`ProceedsFromIssuanceOfCommonStock`,
            `ProceedsFromIssuanceOfLongTermDebtAndCapitalSecuritiesNet`,`ProceedsFromIssuanceOfPreferredStock`,`ProceedsFromRepurchaseOfEquity`,`ProceedsFromSaleOfTreasuryStock`,
            `ChangeInCashAndCashEquivalents`,`ChangeInExchangeRate`,`NetIncome`,`CreatedDate`)
			SELECT `StockID`, `fiscalDateEnding`, `reportedCurrency`,`operatingCashflow`,`paymentsForOperatingActivities`,`proceedsFromOperatingActivities`,
            `changeInOperatingLiabilities`,`changeInOperatingAssets`,`depreciationDepletionAndAmortization`,`capitalExpenditures`,`changeInReceivables`,
            `changeInInventory`,`profitLoss`,`cashflowFromInvestment`,`cashflowFromFinancing`,`proceedsFromRepaymentsOfShortTermDebt`,
            `paymentsForRepurchaseOfCommonStock`,`paymentsForRepurchaseOfEquity`,`paymentsForRepurchaseOfPreferredStock`,`dividendPayout`,
            `dividendPayoutCommonStock`,`dividendPayoutPreferredStock`,`proceedsFromIssuanceOfCommonStock`,`proceedsFromIssuanceOfLongTermDebtAndCapitalSecuritiesNet`,
            `proceedsFromIssuanceOfPreferredStock`,`proceedsFromRepurchaseOfEquity`,`proceedsFromSaleOfTreasuryStock`,
            `changeInCashAndCashEquivalents`,`changeInExchangeRate`, `netIncome`, `CreatedDate` FROM NewRecords;

		DELETE FROM RawCashFlow rcf WHERE rcf.StockSymbol IN (SELECT StockSymbol FROM NewRecords);
		DROP TEMPORARY TABLE IF EXISTS NewRecords;
		
		UPDATE CashFlow cf
			INNER JOIN CompanyOverview co ON cf.StockID = co.StockID
			INNER JOIN RawCashFlow rcf ON co.Symbol = rcf.StockSymbol
			SET
				`cf`.`ReportedCurrency` = `rcf`.`reportedCurrency`, `cf`.`OperatingCashflow` = `rcf`.`operatingCashflow`, `cf`.`PaymentsForOperatingActivities` = `rcf`.`paymentsForOperatingActivities`,
                `cf`.`ProceedsFromOperatingActivities` = `rcf`.`proceedsFromOperatingActivities`, `cf`.`ChangeInOperatingLiabilities` = `rcf`.`changeInOperatingLiabilities`,
                `cf`.`ChangeInOperatingAssets` = `rcf`.`changeInOperatingAssets`, `cf`.`DepreciationDepletionAndAmortization` = `rcf`.`depreciationDepletionAndAmortization`,
                `cf`.`CapitalExpenditures` = `rcf`.`capitalExpenditures`, `cf`.`ChangeInReceivables` = `rcf`.`changeInReceivables`, `cf`.`ChangeInInventory` = `rcf`.`changeInInventory`,
                `cf`.`ProfitLoss` = `rcf`.`profitLoss`, `cf`.`CashflowFromInvestment` = `rcf`.`cashflowFromInvestment`, `cf`.`CashflowFromFinancing` = `rcf`.`cashflowFromFinancing`,
                `cf`.`ProceedsFromRepaymentsOfShortTermDebt` = `rcf`.`proceedsFromRepaymentsOfShortTermDebt`, `cf`.`PaymentsForRepurchaseOfCommonStock` = `rcf`.`paymentsForRepurchaseOfCommonStock`,
                `cf`.`PaymentsForRepurchaseOfEquity` = `rcf`.`paymentsForRepurchaseOfEquity`, `cf`.`PaymentsForRepurchaseOfPreferredStock` = `rcf`.`paymentsForRepurchaseOfPreferredStock`,
                `cf`.`DividendPayout` = `rcf`.`dividendPayout`, `cf`.`DividendPayoutCommonStock` = `rcf`.`dividendPayoutCommonStock`, `cf`.`DividendPayoutPreferredStock` = `rcf`.`dividendPayoutPreferredStock`,
                `cf`.`ProceedsFromIssuanceOfCommonStock` = `rcf`.`proceedsFromIssuanceOfCommonStock`, `cf`.`ProceedsFromIssuanceOfLongTermDebtAndCapitalSecuritiesNet` = `rcf`.`proceedsFromIssuanceOfLongTermDebtAndCapitalSecuritiesNet`,
                `cf`.`ProceedsFromIssuanceOfPreferredStock` = `rcf`.`proceedsFromIssuanceOfPreferredStock`, `cf`.`ProceedsFromRepurchaseOfEquity` = `rcf`.`proceedsFromRepurchaseOfEquity`,
                `cf`.`ProceedsFromSaleOfTreasuryStock` = `rcf`.`proceedsFromSaleOfTreasuryStock`, `cf`.`changeInCashAndCashEquivalents` = `rcf`.`changeInCashAndCashEquivalents`,
                `cf`.`ChangeInExchangeRate` = `rcf`.`changeInExchangeRate`, `cf`.`NetIncome` = `rcf`.`netIncome`
            WHERE rcf.`fiscalDateEnding` = cf.`FiscalDateEnding` AND rcf.StockSymbol = co.Symbol;
        
        DELETE FROM RawCashFlow rcf WHERE rcf.StockSymbol IN (SELECT Symbol FROM CompanyOverview);
		
    END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RawCompanyOverviewToCompanyOverview` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `RawCompanyOverviewToCompanyOverview`()
BEGIN
	
        -- Error Handler --
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 @errno = MYSQL_ERRNO, @ErrorMsg = MESSAGE_TEXT;
        insert into errorlog(ObjectName, ErrorNumber, ErrorMessage, CreatedDate)
        VALUES ('RawCompanyOverviewToCompanyOverview', @errno, @ErrorMsg, NOW());
    END;
    -- Error Handler End --
    
    IF ( (SELECT COUNT(StockSymbol) FROM rawCompanyOverview) > 0) THEN
    
		CREATE TEMPORARY TABLE IF NOT EXISTS DuplicatedRecords
			SELECT StockSymbol, MAX(RawCompanyOverviewID) as LatestEntry 
			FROM rawCompanyOverview GROUP BY StockSymbol HAVING COUNT(RawCompanyOverviewID) > 1;
		
		DELETE rco
			FROM rawCompanyOverview rco INNER JOIN DuplicatedRecords dr ON rco.StockSymbol = dr.StockSymbol
			WHERE rco.RawCompanyOverviewID < dr.LatestEntry;
		
		DROP TEMPORARY TABLE IF EXISTS DuplicatedRecords;
        
		CREATE TEMPORARY TABLE IF NOT EXISTS NewRecords
			SELECT s.`StockID`, s.`Symbol`, rco.`AssetType`, rco.`Name`, IF(rco.`Description` = 'None', NULL, rco.`Description`),
			rco.`CIK`, rco.`Exchange`, rco.`Currency`, rco.`Country`, rco.`Sector`, rco.`Industry`, IF(rco.`Address` = 'NONE', NULL, rco.`Address`), IF(rco.`OfficialSite` = 'None', NULL, rco.`OfficialSite`), IF(rco.`FiscalYearEnd` = 'None', NULL,rco.`FiscalYearEnd`), rco.`LatestQuarter`, rco.`MarketCapitalization`, rco.`EBITDA`, rco.`PERatio`, rco.`PEGRatio`, rco.`BookValue`, rco.`DividendPerShare`, rco.`DividendYield`, rco.`EPS`,
			rco.`RevenuePerShareTTM`, rco.`ProfitMargin`, rco.`OperatingMarginTTM`, rco.`ReturnOnAssetsTTM`, rco.`ReturnOnEquityTTM`, rco.`RevenueTTM`, rco.`GrossProfitTTM`, rco.`DilutedEPSTTM`, rco.`QuarterlyEarningsGrowthYOY`, rco.`QuarterlyRevenueGrowthYOY`, rco.`AnalystTargetPrice`, rco.`AnalystRatingStrongBuy`, rco.`AnalystRatingBuy`, rco.`AnalystRatingHold`, rco.`AnalystRatingSell`,
			rco.`AnalystRatingStrongSell`, rco.`TrailingPE`, rco.`ForwardPE`, rco.`PriceToSalesRatioTTM`, rco.`PriceToBookRatio`, rco.`EVToRevenue`, rco.`EVToEBITDA`, rco.`Beta`, rco.`52WeekHigh`, rco.`52WeekLow`, rco.`50DayMovingAverage`, rco.`200DayMovingAverage`, rco.`SharesOutstanding`, rco.`DividendDate`, rco.`ExDividendDate`,
			NOW() FROM stocks.rawCompanyOverview rco 
			INNER JOIN stock s ON rco.StockSymbol = s.Symbol
			LEFT OUTER JOIN CompanyOverview co ON rco.StockSymbol = co.Symbol
			WHERE co.Symbol IS NULL;
        
		INSERT INTO `stocks`.`CompanyOverview`
			(`StockID`,`Symbol`, `AssetType`, `Name`, `Description`,
			`CIK`,`Exchange`, `Currency`, `Country`,`Sector`, `Industry`, `Address`, `OfficialSite`, `FiscalYearEnd`, `LatestQuarter`, `MarketCapitalization`, `EBITDA`, `PERatio`, `PEGRatio`, `BookValue`, `DividendPerShare`, `DividendYield`, `EPS`,
			`RevenuePerShareTTM`, `ProfitMargin`, `OperatingMarginTTM`, `ReturnOnAssetsTTM`,`ReturnOnEquityTTM`, `RevenueTTM`, `GrossProfitTTM`, `DilutedEPSTTM`, `QuarterlyEarningsGrowthYOY`, `QuarterlyRevenueGrowthYOY`, `AnalystTargetPrice`, `AnalystRatingStrongBuy`, `AnalystRatingBuy`, `AnalystRatingHold`, `AnalystRatingSell`,
			`AnalystRatingStrongSell`, `TrailingPE`, `ForwardPE`, `PriceToSalesRatioTTM`, `PriceToBookRatio`, `EVToRevenue`, `EVToEBITDA`, `Beta`, `52WeekHigh`, `52WeekLow`, `50DayMovingAverage`, `200DayMovingAverage`, `SharesOutstanding`, `DividendDate`, `ExDividendDate`, `CreatedDate`)
			SELECT * FROM NewRecords;

		DELETE FROM rawCompanyOverview rco WHERE rco.StockSymbol IN (SELECT Symbol FROM NewRecords);
		DROP TEMPORARY TABLE IF EXISTS NewRecords;

		UPDATE CompanyOverview co INNER JOIN rawCompanyOverview rco ON co.Symbol = rco.StockSymbol
		SET co.`Description` = rco.`Description`,
			co.`CIK` = rco.`CIK`, co.`Exchange` = rco.`Exchange`, co.`Currency` = rco.`Currency`, co.`Country` = rco.Country, co.`Sector` = rco.Sector,  co.`Industry` = rco.Industry,  co.`Address` = rco.Address,  co.`OfficialSite` = rco.OfficialSite,  co.`FiscalYearEnd` = rco.FiscalYearEnd,  co.`LatestQuarter` = rco.LatestQuarter,  co.`MarketCapitalization` = rco.MarketCapitalization,  co.`EBITDA` = rco.EBITDA,  co.`PERatio` = rco.PERatio,  co.`PEGRatio` = rco.PEGRatio,  co.`BookValue` = rco.BookValue,  
			co.`DividendPerShare` = rco.DividendPerShare,  co.`DividendYield` = rco.DividendYield,  co.`EPS` = rco.EPS, 
			co.`RevenuePerShareTTM` = rco.RevenuePerShareTTM,  co.`ProfitMargin` = rco.ProfitMargin,  co.`OperatingMarginTTM` = rco.OperatingMarginTTM,  co.`ReturnOnAssetsTTM` = rco.ReturnOnAssetsTTM, co.`ReturnOnEquityTTM` = rco.ReturnOnEquityTTM,  co.`RevenueTTM` = rco.RevenueTTM,  co.`GrossProfitTTM` = rco.GrossProfitTTM,  co.`DilutedEPSTTM` = rco.DilutedEPSTTM,  co.`QuarterlyEarningsGrowthYOY` = rco.QuarterlyEarningsGrowthYOY,  co.`QuarterlyRevenueGrowthYOY` = rco.QuarterlyRevenueGrowthYOY,  
			co.`AnalystTargetPrice` = rco.AnalystTargetPrice,  co.`AnalystRatingStrongBuy` = rco.AnalystRatingStrongBuy,  co.`AnalystRatingBuy` = rco.AnalystRatingBuy,  co.`AnalystRatingHold` = rco.AnalystRatingHold,  co.`AnalystRatingSell` = rco.AnalystRatingSell, 
			co.`AnalystRatingStrongSell` = rco.AnalystRatingStrongSell,  co.`TrailingPE` = rco.TrailingPE,  co.`ForwardPE` = rco.ForwardPE,  co.`PriceToSalesRatioTTM` = rco.PriceToSalesRatioTTM,  co.`PriceToBookRatio` = rco.PriceToBookRatio,  co.`EVToRevenue` = rco.EVToRevenue,  co.`EVToEBITDA` = rco.EVToEBITDA,  co.`Beta` = rco.Beta,  co.`52WeekHigh` = rco.`52WeekHigh`,  co.`52WeekLow` = rco.`52WeekLow`,  co.`50DayMovingAverage` = rco.`50DayMovingAverage`,  
			co.`200DayMovingAverage` = rco.`200DayMovingAverage`,  co.`SharesOutstanding` = rco.`SharesOutstanding`,  co.`DividendDate` = rco.DividendDate,  co.`ExDividendDate` = rco.ExDividendDate, co.UpdatedDate = NOW();
        
        DELETE FROM rawCompanyOverview rco WHERE rco.StockSymbol IN (SELECT Symbol FROM CompanyOverview);
		
    END IF;
    
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RawEarningToEarnings` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `RawEarningToEarnings`()
BEGIN
        -- Error Handler --
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 @errno = MYSQL_ERRNO, @ErrorMsg = MESSAGE_TEXT;
        insert into errorlog(ObjectName, ErrorNumber, ErrorMessage, CreatedDate)
        VALUES ('RawEarningToEarnings', @errno, @ErrorMsg, NOW());
    END;
    -- Error Handler End --
    
    SET SQL_SAFE_UPDATES = 0;
    
    IF ( (SELECT COUNT(StockSymbol) FROM RawEarning) > 0) THEN
        
        CREATE TEMPORARY TABLE IF NOT EXISTS DuplicatedRecords
			SELECT StockSymbol, reportedDate, MAX(RawEarningID) AS LatestEntry
			FROM RawEarning GROUP BY StockSymbol, reportedDate HAVING COUNT(RawEarningID) > 1;
            
		DELETE re
			FROM RawEarning re INNER JOIN DuplicatedRecords dr ON re.StockSymbol = dr.StockSymbol AND re.reportedDate = dr.reportedDate
			WHERE re.RawEarningID < dr.LatestEntry;
		
		DROP TEMPORARY TABLE IF EXISTS DuplicatedRecords;
        
		CREATE TEMPORARY TABLE IF NOT EXISTS NewRecords
			SELECT re.`StockSymbol`, co.`StockID`, re.`fiscalDateEnding`, re.`reportedDate`, re.`reportedEPS`, re.`estimatedEPS`,
            re.`surprise`, re.`surprisePercentage`, re.`reportTime`, NOW() AS `CreatedDate`
            FROM stocks.RawEarning re 
			INNER JOIN CompanyOverview co ON re.StockSymbol = co.Symbol
			LEFT OUTER JOIN Earnings e ON e.StockID = co.StockID AND re.`reportedDate` = e.`ReportedDate`
			WHERE e.StockID IS NULL;

		INSERT INTO `stocks`.`Earnings`(`StockID`, `FiscalDateEnding`, `ReportedDate`, `ReportedEPS`,`EstimatedEPS`, `Surprise`, `SurprisePercentage`,`ReportTime`, `CreatedDate`) 
			SELECT `StockID`, `fiscalDateEnding`, `reportedDate`, `reportedEPS`,`estimatedEPS`, `surprise`, `surprisePercentage`,`reportTime`, `CreatedDate` FROM NewRecords;

		DELETE FROM RawEarning re WHERE re.StockSymbol IN (SELECT StockSymbol FROM NewRecords);
		DROP TEMPORARY TABLE IF EXISTS NewRecords;

		UPDATE Earnings e
			INNER JOIN CompanyOverview co ON e.StockID = co.StockID
			INNER JOIN RawEarning re ON co.Symbol = re.StockSymbol
			SET e.`FiscalDateEnding` = re.FiscalDateEnding, e.`ReportedEPS` = re.ReportedEPS, e.`EstimatedEPS` = re.EstimatedEPS, e.`Surprise` = re.Surprise, 
			e.`SurprisePercentage` = re.SurprisePercentage, e.`ReportTime` = re.ReportTime WHERE e.`ReportedDate` = re.`reportedDate` AND re.StockSymbol = co.Symbol;
        
        DELETE FROM RawEarning re WHERE re.StockSymbol IN (SELECT Symbol FROM CompanyOverview);
		
    END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `rawFinancialDataToFinancialData` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `rawFinancialDataToFinancialData`(IN vStockSymbol VARCHAR(45), IN iEventID INT, OUT addedRows INT)
BEGIN
	
    -- DECLARE addedRows INT DEFAULT 0;
    DECLARE iStockID INT DEFAULT 0;
    
    DECLARE iOldMaxFinancialDataID INT DEFAULT 0;
    DECLARE iNewMaxFinancialDataID INT DEFAULT 0;
    
    DECLARE iOldMaxStockDate DATETIME DEFAULT NULL;
    DECLARE iNewMaxStockDate DATETIME DEFAULT NULL;
    
    DECLARE dtStartTime DATETIME;
    
    DECLARE iMinStockDate DATETIME;
    DECLARE ichecker int default 0;
    
    DECLARE iThreadID INT;
    

    -- Error Handler --
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 @errno = MYSQL_ERRNO, @ErrorMsg = MESSAGE_TEXT;
        insert into errorlog(ObjectName, ErrorNumber, ErrorMessage, CreatedDate)
        VALUES ('rawFinancialDataToFinancialData', @errno, @ErrorMsg, NOW());
    END;
    -- Error Handler End --
    
    
    SET SQL_SAFE_UPDATES = 0;
    
    -- Populating variables: iStockID, iThreadID, dtStartTime, addedRows
	SELECT DISTINCT StockID INTO iStockID FROM stock WHERE stock.Symbol = vStockSymbol;
	SELECT PS_CURRENT_THREAD_ID() INTO iThreadID;
    SET dtStartTime = NOW();
    SET addedRows = 0;
    
    CREATE TEMPORARY TABLE IF NOT EXISTS allDataForSymbol
		SELECT *, iStockID AS StockID FROM rawfinancialdata WHERE StockSymbol = vStockSymbol;

    -- Delete any row that already exists in financialdata
    DELETE ads 
    FROM allDataForSymbol ads INNER JOIN FinancialData fd ON ( (fd.StockID =  ads.StockID) AND (fd.StockDate = ads.StockDateTime) )
    WHERE fd.StockID = iStockID AND ads.StockID = iStockID;

    -- Get the smallest Stock date that's not already in financialdata
    SELECT StockDateTime INTO iMinStockDate FROM allDataForSymbol ORDER BY StockDateTime ASC LIMIT 1;
	

    
    WHILE (ichecker = 0) DO
    
		IF ( (SELECT COUNT(ProcessThreadManagerID) FROM ProcessThreadManager WHERE `Table` = 'FinancialData') = 0) THEN

			UPDATE ProcessThreadManager SET `Table` = 'FinancialData', StartDateTime = NOW() WHERE ProcessThreadManagerID = iEventID;

            IF ( (SELECT COUNT(ProcessThreadManagerID) FROM ProcessThreadManager WHERE `Table` = 'FinancialData') = 1) THEN
				
                -- CALL `InserFinDataLow`(iStockID);
                
				INSERT IGNORE INTO FinancialData(StockID, StockDate, `Open`, `Close`, Volume, EMA, VWAP,RateOfChange, High, OnBalanceVolume, `Low`)
					SELECT  iStockID, StockDateTime, 
					IF(openPrice IS NULL, NULL,CONVERT(openPrice, decimal(20,5))), IF(closePrice IS NULL,NULL, CONVERT(closePrice, decimal(20,5))), IF(volume IS NULL, NULL,CONVERT(volume, decimal(20,5))),
					IF(ema IS NULL, NULL,CONVERT(ema, decimal(20,5))), IF(vwap IS NULL, NULL, CONVERT(vwap, decimal(20,5))), IF(RoC IS NULL, NULL, CONVERT(RoC, decimal(20,5))), IF(highPrice IS NULL, NULL, CONVERT(highPrice, decimal(20,5))), 
					IF(OBV IS NULL, NULL, CONVERT(OBV, decimal(20,5))), IF(lowPrice IS NULL, NULL, CONVERT(lowPrice, decimal(20,5))) FROM allDataForSymbol;
					
				SET addedRows = ROW_COUNT();
                
				UPDATE ProcessThreadManager SET `ThreadID` = iThreadID, `Table` = NULL, StartDateTime = NOW() WHERE ProcessThreadManagerID = iEventID;
				SET ichecker = 1;
			ELSE
				UPDATE ProcessThreadManager SET `Table` = NULL, StartDateTime = NOW() WHERE ProcessThreadManagerID = iEventID;
                DO SLEEP(.1);
			END IF;
		ELSE 
			DO SLEEP(.1);
		END IF;
    END WHILE;
    SET ichecker = 0;

     IF (addedRows > 0) THEN
	
        CREATE TEMPORARY TABLE allIndicators 
        SELECT TableName FROM indicator WHERE Active = 1;
        
        CREATE TEMPORARY TABLE IF NOT EXISTS alldata 
			(`FinancialDataID` int NOT NULL, `StockSymbol` varchar(255), `dates` datetime, `times` varchar(250), `openPrice` varchar(250), `highPrice` varchar(250), `lowPrice` varchar(250), `closePrice` varchar(250),
			`volume` varchar(250), `wma` varchar(250),`ema` varchar(250), `MACD` varchar(250), `MACD_Signal` varchar(250), `MACD_hist` varchar(250),
			`boiler_band_upper` varchar(250), `boiler_band_middle` varchar(250), `boiler_band_lower` varchar(250), `vwap` varchar(250), `RoC` varchar(250), `OBV` varchar(250), `AD` varchar(250), `SAR` varchar(250), 
            `ADX` varchar(250), `DX` varchar(255), `PDMI` varchar(255), `MDMI` varchar(255), `StockDateTime` datetime, `StockID` INT,
            PRIMARY KEY (`FinancialDataID`, `StockID`),KEY `stockSym` (`StockSymbol`),KEY `StockDate` (`StockDateTime`));
        
        
        INSERT IGNORE INTO alldata(FinancialDataID, StockSymbol, dates,  times, openPrice, highPrice, lowPrice, closePrice,
			volume, wma, ema, MACD, MACD_Signal, MACD_hist, boiler_band_upper, boiler_band_middle, boiler_band_lower,
			vwap, RoC, OBV, AD, SAR, ADX, DX, PDMI, MDMI, StockDateTime, StockID)
            
		SELECT fd.FinancialDataID, adfs.StockSymbol, adfs.dates,  adfs.times, 
            IF(adfs.openPrice IS NULL, NULL,CONVERT(adfs.openPrice, decimal(20,5))), IF(adfs.highPrice IS NULL, NULL,CONVERT(adfs.highPrice, decimal(20,5))), 
            IF(adfs.lowPrice IS NULL, NULL,CONVERT(adfs.lowPrice, decimal(20,5))), IF(adfs.closePrice IS NULL, NULL,CONVERT(adfs.closePrice, decimal(20,5))),
            IF(adfs.volume IS NULL, NULL,CONVERT(adfs.volume, decimal(20,5))), IF(adfs.wma IS NULL, NULL,CONVERT(adfs.wma, decimal(20,5))),
            IF(adfs.ema IS NULL, NULL,CONVERT(adfs.ema, decimal(20,5))), IF(adfs.MACD IS NULL, NULL,CONVERT(adfs.MACD, decimal(20,5))),
            IF(adfs.MACD_Signal IS NULL, NULL,CONVERT(adfs.MACD_Signal, decimal(20,5))), IF(adfs.MACD_hist IS NULL, NULL,CONVERT(adfs.MACD_hist, decimal(20,5))),
			IF(adfs.boiler_band_upper IS NULL, NULL,CONVERT(adfs.boiler_band_upper, decimal(20,5))), IF(adfs.boiler_band_middle IS NULL, NULL,CONVERT(adfs.boiler_band_middle, decimal(20,5))),
			IF(adfs.boiler_band_lower IS NULL, NULL,CONVERT(adfs.boiler_band_lower, decimal(20,5))), IF(adfs.vwap IS NULL, NULL,CONVERT(adfs.vwap, decimal(20,5))),
			IF(adfs.RoC IS NULL, NULL,CONVERT(adfs.RoC, decimal(20,5))), IF(adfs.OBV IS NULL, NULL,CONVERT(adfs.OBV, decimal(20,5))),
            IF(adfs.AD IS NULL, NULL,CONVERT(adfs.AD, decimal(20,5))), IF(adfs.SAR IS NULL, NULL,CONVERT(adfs.SAR, decimal(20,5))),
			IF(adfs.ADX IS NULL, NULL,CONVERT(adfs.ADX, decimal(20,5))), IF(adfs.DX IS NULL, NULL,CONVERT(adfs.DX, decimal(20,5))),
            IF(adfs.PDMI IS NULL, NULL,CONVERT(adfs.PDMI, decimal(20,5))), IF(adfs.MDMI IS NULL, NULL,CONVERT(adfs.MDMI, decimal(20,5))),
			adfs.StockDateTime, adfs.StockID
			FROM allDataForSymbol adfs INNER JOIN FinancialData fd ON ( (fd.StockID =  adfs.StockID) AND (fd.StockDate = adfs.StockDateTime) )
			WHERE fd.StockID = iStockID AND fd.StockDate >= iMinStockDate;
        
		SELECT FinancialDataID, StockDateTime INTO iOldMaxFinancialDataID, iOldMaxStockDate FROM alldata WHERE StockID = iStockID AND StockDateTime = iMinStockDate ORDER BY StockDateTime ASC LIMIT 1;
        
        SELECT FinancialDataID, StockDateTime INTO iNewMaxFinancialDataID, iNewMaxStockDate FROM alldata WHERE StockID = iStockID ORDER BY StockDateTime DESC LIMIT 1;

        
		CREATE TEMPORARY TABLE IF NOT EXISTS raw_to_bb(`StockID` INT, `StockDate` DATETIME,`FinancialDataID` INT, `Lower` DECIMAL(20,5), `Middle` DECIMAL(20,5), `Upper` DECIMAL(20,5), UpdateTime DATETIME);
        CREATE TEMPORARY TABLE IF NOT EXISTS raw_to_dm(`StockID` INT, `StockDate` DATETIME, `FinancialDataID` INT,`ADX` DECIMAL(20,5), `DX` DECIMAL(20,5), `DMI+` DECIMAL(20,5), `DMI-` DECIMAL(20,5), UpdateTime DATETIME);
        CREATE TEMPORARY TABLE IF NOT EXISTS raw_to_sar(`StockID` INT, `StockDate` DATETIME, `FinancialDataID` INT, `SAR` DECIMAL(20,5), `WMA` DECIMAL(20,5),  UpdateTime DATETIME);
        CREATE TEMPORARY TABLE IF NOT EXISTS raw_to_macd(`StockID` INT, `StockDate` DATETIME, `FinancialDataID` INT, `MACD` DECIMAL(20,5), `MACD_Signal` DECIMAL(20,5), `MACD_hist` DECIMAL(20,5), UpdateTime DATETIME);
        CREATE TEMPORARY TABLE IF NOT EXISTS raw_to_chaikinoscillator(`StockID` INT, `StockDate` DATETIME, `FinancialDataID` INT, `ChaikinADLine` DECIMAL(20,5));
       
       -- Creation of all temporary tables used and the current symbols data from rawFinData table is in alldata
       -- Temporary table allIndicators is used to allow us to process any indicator in any order --> makes sure each iteration processes every indicator
        WHILE ((SELECT COUNT(*) FROM allIndicators) > 0) DO
			
            -- Indicator: MACD
			CASE WHEN ((SELECT FIND_IN_SET('macd' ,TableName) FROM allIndicators ORDER BY FIND_IN_SET('macd' ,TableName) DESC LIMIT 1) > 0 
			AND ((SELECT COUNT(ProcessThreadManagerID) FROM ProcessThreadManager WHERE `Table` = 'macd') = 0) ) THEN
			  
				IF ((SELECT COUNT(ProcessThreadManagerID) FROM ProcessThreadManager WHERE `Table` = 'macd') = 0) THEN

					UPDATE ProcessThreadManager SET `Table` = 'macd', StartDateTime = NOW() WHERE ProcessThreadManagerID = iEventID;

					IF ( (SELECT COUNT(ProcessThreadManagerID) FROM ProcessThreadManager WHERE `Table` = 'macd') = 1) THEN
						
						INSERT INTO raw_to_macd(StockID, StockDate, FinancialDataID, MACD, MACD_Signal, MACD_hist, UpdateTime)
							SELECT ald.StockID, ald.StockDateTime, ald.FinancialDataID, ald.MACD, ald.MACD_Signal, ald.MACD_hist , NOW()            
							FROM alldata ald LEFT OUTER JOIN macd md ON ald.FinancialDataID = md.FinancialDataID
							WHERE ald.StockID = iStockID AND md.FinancialDataID IS NULL;
						
						INSERT INTO macd (StockID, StockDate, FinancialDataID, MACD, MACD_Signal, MACD_Hist, UpdatedDate)
							SELECT StockID, StockDate, FinancialDataID, MACD, MACD_Signal, MACD_hist, UpdateTime FROM raw_to_macd;
						
						DROP TEMPORARY TABLE IF EXISTS raw_to_macd;
						
						CALL CreateUpdateMacdTrendDirection(iStockID, 1, iOldMaxStockDate, iNewMaxStockDate);
						CALL CreateUpdateMacdTrendChange(iStockID, iOldMaxStockDate, iNewMaxStockDate);
						
						DELETE FROM allIndicators WHERE TableName = 'macd';
						
						UPDATE ProcessThreadManager SET `Table` = NULL, StartDateTime = NOW() WHERE ProcessThreadManagerID = iEventID;
					ELSE 
						UPDATE ProcessThreadManager SET `Table` = NULL, StartDateTime = NOW() WHERE ProcessThreadManagerID = iEventID;

					END IF;
				END IF;
			
            -- INDICATOR: Sar
			WHEN ((SELECT FIND_IN_SET('sar' ,TableName) FROM allIndicators ORDER BY FIND_IN_SET('sar' ,TableName) DESC LIMIT 1) > 0 
			AND ((SELECT COUNT(ProcessThreadManagerID) FROM ProcessThreadManager WHERE `Table` = 'sar') = 0) ) THEN
			   
				IF ( (SELECT COUNT(ProcessThreadManagerID) FROM ProcessThreadManager WHERE `Table` = 'sar') = 0) THEN

					UPDATE ProcessThreadManager SET `Table` = 'sar', StartDateTime = NOW() WHERE ProcessThreadManagerID = iEventID;

					IF ( (SELECT COUNT(ProcessThreadManagerID) FROM ProcessThreadManager WHERE `Table` = 'sar') = 1) THEN
                    
						INSERT INTO raw_to_sar (StockID, StockDate, FinancialDataID, SAR, WMA, UpdateTime)
							SELECT ald.StockID, ald.StockDateTime, ald.FinancialDataID, ald.SAR, ald.wma, NOW()  
							FROM alldata ald LEFT OUTER JOIN sar s ON ald.FinancialDataID = s.FinancialDataID
							WHERE ald.StockID = iStockID AND s.FinancialDataID IS NULL;
						
						INSERT INTO sar(StockID, StockDate, FinancialDataID, SAR, WMA, UpdatedDate)
							SELECT StockID, StockDate, FinancialDataID, SAR, WMA, UpdateTime FROM raw_to_sar;
							
						DROP TEMPORARY TABLE IF EXISTS raw_to_sar;
						
						CALL CreateUpdateSarTrendDirection(iStockID, 1, iOldMaxStockDate, iNewMaxStockDate);
						CALL CreateUpdateSarTrendChange(iStockID, iOldMaxStockDate, iNewMaxStockDate);
						
						DELETE FROM allIndicators WHERE TableName = 'sar';
						
						-- Needs to be re-worked
						-- CALL CreateUpdateSarSlope(-2, 3);
                        
						UPDATE ProcessThreadManager SET `Table` = NULL, StartDateTime = NOW() WHERE ProcessThreadManagerID = iEventID;
					ELSE 
						UPDATE ProcessThreadManager SET `Table` = NULL, StartDateTime = NOW() WHERE ProcessThreadManagerID = iEventID;
					END IF;
				END IF;
			
            -- Indicator: ChaikinOscillator
			WHEN ((SELECT FIND_IN_SET('chaikinoscillator' ,TableName) FROM allIndicators ORDER BY FIND_IN_SET('chaikinoscillator' ,TableName) DESC LIMIT 1) > 0 
			AND ((SELECT COUNT(ProcessThreadManagerID) FROM ProcessThreadManager WHERE `Table` = 'chaikinoscillator') = 0) ) THEN
				
				IF ( (SELECT COUNT(ProcessThreadManagerID) FROM ProcessThreadManager WHERE `Table` = 'chaikinoscillator') = 0) THEN

				   UPDATE ProcessThreadManager SET `Table` = 'chaikinoscillator', StartDateTime = NOW() WHERE ProcessThreadManagerID = iEventID;
				   
					IF ( (SELECT COUNT(ProcessThreadManagerID) FROM ProcessThreadManager WHERE `Table` = 'chaikinoscillator') = 1) THEN
                    
						INSERT INTO raw_to_chaikinoscillator(StockID, StockDate, FinancialDataID, ChaikinADLine) 
							SELECT ald.StockID, ald.StockDateTime, ald.FinancialDataID, ald.AD 
							FROM alldata ald LEFT OUTER JOIN chaikinoscillator co ON ald.FinancialDataID = co.FinancialDataID
							WHERE ald.StockID = iStockID AND co.FinancialDataID IS NULL;
                            
						INSERT INTO chaikinoscillator(StockID, StockDate, FinancialDataID, ChaikinADLine)
							SELECT StockID, StockDate, FinancialDataID, ChaikinADLine FROM raw_to_chaikinoscillator;
						
						DROP TEMPORARY TABLE IF EXISTS raw_to_chaikinoscillator;
						CALL CreateUpdateChaikinADCrossZero(iStockID, iOldMaxStockDate, iNewMaxStockDate);
						
						DELETE FROM allIndicators WHERE TableName = 'chaikinoscillator';

						UPDATE ProcessThreadManager SET `Table` = NULL, StartDateTime = NOW() WHERE ProcessThreadManagerID = iEventID;
					ELSE 
						UPDATE ProcessThreadManager SET `Table` = NULL, StartDateTime = NOW() WHERE ProcessThreadManagerID = iEventID;
					END IF;
				END IF;
			
            -- Indicator: BoilerBand
			WHEN ((SELECT FIND_IN_SET('boilerband' ,TableName) FROM allIndicators ORDER BY FIND_IN_SET('boilerband' ,TableName) DESC LIMIT 1) > 0 
			AND ((SELECT COUNT(ProcessThreadManagerID) FROM ProcessThreadManager WHERE `Table` = 'boilerband') = 0) ) THEN
				
				
				IF ( (SELECT COUNT(ProcessThreadManagerID) FROM ProcessThreadManager WHERE `Table` = 'boilerband') = 0) THEN

					UPDATE ProcessThreadManager SET `Table` = 'boilerband', StartDateTime = NOW() WHERE ProcessThreadManagerID = iEventID;

					IF ( (SELECT COUNT(ProcessThreadManagerID) FROM ProcessThreadManager WHERE `Table` = 'boilerband') = 1) THEN
						
						INSERT INTO raw_to_bb(StockID, StockDate, FinancialDataID, `Lower`, `Middle`, `Upper`, UpdateTime)
							SELECT ald.StockID, ald.StockDateTime, ald.FinancialDataID, ald.boiler_band_lower, ald.boiler_band_middle, ald.boiler_band_upper , NOW()
							FROM alldata ald LEFT OUTER JOIN boilerband bb ON ald.FinancialDataID = bb.FinancialDataID
							WHERE ald.StockID = iStockID AND bb.FinancialDataID IS NULL;
                        
						INSERT INTO boilerband(StockID, StockDate, FinancialDataID, `Lower`, `Middle`, `Upper`, UpdatedDate)
							SELECT StockID, StockDate, FinancialDataID, `Lower`, `Middle`, `Upper`, UpdateTime FROM raw_to_bb;
						
						DROP TEMPORARY TABLE IF EXISTS raw_to_bb;
						
						CALL CreateUpdateBoilerBandWidth(iStockID, 1);
						CALL CalculateDeltaBoilerBands(iStockID, iOldMaxStockDate);
						
						DELETE FROM allIndicators WHERE TableName = 'boilerband';
						
						UPDATE ProcessThreadManager SET `Table` = NULL, StartDateTime = NOW() WHERE ProcessThreadManagerID = iEventID;

					ELSE 
						UPDATE ProcessThreadManager SET `Table` = NULL, StartDateTime = NOW() WHERE ProcessThreadManagerID = iEventID;
					END IF;
				END IF;
			
            -- Indicator: DirectionalMovement
			WHEN ((SELECT FIND_IN_SET('directionalmovement' ,TableName) FROM allIndicators ORDER BY FIND_IN_SET('directionalmovement' ,TableName) DESC LIMIT 1) > 0 
			AND ((SELECT COUNT(ProcessThreadManagerID) FROM ProcessThreadManager WHERE `Table` = 'directionalmovement') = 0) ) THEN
				
				IF ( (SELECT COUNT(ProcessThreadManagerID) FROM ProcessThreadManager WHERE `Table` = 'directionalmovement') = 0) THEN
					UPDATE ProcessThreadManager SET `Table` = 'directionalmovement', StartDateTime = NOW() WHERE ProcessThreadManagerID = iEventID;
					
					
                    IF ( (SELECT COUNT(ProcessThreadManagerID) FROM ProcessThreadManager WHERE `Table` = 'directionalmovement') = 1) THEN
						
						INSERT INTO raw_to_dm(StockID, StockDate, `FinancialDataID`, `ADX`, `DX`, `DMI+`, `DMI-`, UpdateTime)
							SELECT ald.StockID, ald.StockDateTime, ald.FinancialDataID, ald.ADX, ald.DX, ald.PDMI, ald.MDMI, NOW() 
							FROM alldata ald LEFT OUTER JOIN directionalmovement dm ON ald.FinancialDataID = dm.FinancialDataID
							WHERE ald.StockID = iStockID AND dm.FinancialDataID IS NULL;
						   
						INSERT INTO directionalmovement(`StockID`, `StockDate`,`FinancialDataID`, `ADX`, `DX`, `DMIPlus`, `DMIMinus`, `UpdatedDate`)
							SELECT `StockID`,`StockDate`, `FinancialDataID`, `ADX`, `DX`, `DMI+`, `DMI-`, UpdateTime FROM raw_to_dm;
						
						DROP TEMPORARY TABLE IF EXISTS raw_to_dm;
                        
						CALL CreateUpdateADXTrendDirection(iStockID, 1, iOldMaxStockDate, iNewMaxStockDate);
						CALL CreateUpdateADXTrendChange(iStockID, iOldMaxStockDate, iNewMaxStockDate);
                        
						DELETE FROM allIndicators WHERE TableName = 'directionalmovement';
						
						UPDATE ProcessThreadManager SET `Table` = NULL, StartDateTime = NOW() WHERE ProcessThreadManagerID = iEventID;
					ELSE 
						UPDATE ProcessThreadManager SET `Table` = NULL, StartDateTime = NOW() WHERE ProcessThreadManagerID = iEventID;
					END IF;
				END IF;
			ELSE 
				DO SLEEP(.25);
			END CASE;
		END WHILE;

        DROP TEMPORARY TABLE IF EXISTS alldata;
        DROP TEMPORARY TABLE IF EXISTS allIndicators;
        
        UPDATE stock SET LastStockDate = iNewMaxStockDate, UpdatedDate = NOW(), NoData = 0 WHERE StockID = iStockID AND LastStockDate < iNewMaxStockDate;
	ELSE
		-- If addRows = 0 --> We update the stock table saying there weren't any results right now.
		UPDATE stock SET UpdatedDate = NOW() WHERE StockID = iStockID;
	END IF;
    DROP TEMPORARY TABLE IF EXISTS allDataForSymbol; 

     
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RawIncomeStatementToIncomeStatement` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `RawIncomeStatementToIncomeStatement`()
BEGIN
-- Error Handler --
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 @errno = MYSQL_ERRNO, @ErrorMsg = MESSAGE_TEXT;
        insert into errorlog(ObjectName, ErrorNumber, ErrorMessage, CreatedDate)
        VALUES ('RawIncomeStatementToIncomeStatement', @errno, @ErrorMsg, NOW());
    END;
    -- Error Handler End --
    
    SET SQL_SAFE_UPDATES = 0;
    
    IF ( (SELECT COUNT(StockSymbol) FROM RawIncomeStatement) > 0) THEN
        
        CREATE TEMPORARY TABLE IF NOT EXISTS DuplicatedRecords
			SELECT StockSymbol, fiscalDateEnding, MAX(RawIncomeStatementID) AS LatestEntry
			FROM RawIncomeStatement GROUP BY StockSymbol, fiscalDateEnding HAVING COUNT(RawIncomeStatementID) > 1;
            
		DELETE ris
			FROM RawIncomeStatement ris INNER JOIN DuplicatedRecords dr ON ris.StockSymbol = dr.StockSymbol AND ris.fiscalDateEnding = dr.fiscalDateEnding
			WHERE ris.RawIncomeStatementID < dr.LatestEntry;
		
		DROP TEMPORARY TABLE IF EXISTS DuplicatedRecords;
        
		CREATE TEMPORARY TABLE IF NOT EXISTS NewRecords
			SELECT `co`.`StockID`,`ris`.`StockSymbol`, `ris`.`fiscalDateEnding`,`ris`.`reportedCurrency`,`ris`.`grossProfit`,`ris`.`totalRevenue`,`ris`.`costOfRevenue`,`ris`.`costofGoodsAndServicesSold`,
            `ris`.`operatingIncome`,`ris`.`sellingGeneralAndAdministrative`,`ris`.`researchAndDevelopment`,`ris`.`operatingExpenses`,`ris`.`investmentIncomeNet`,`ris`.`netInterestIncome`,`ris`.`interestIncome`,
            `ris`.`interestExpense`,`ris`.`nonInterestIncome`,`ris`.`otherNonOperatingIncome`,`ris`.`depreciation`,`ris`.`depreciationAndAmortization`,`ris`.`incomeBeforeTax`,`ris`.`incomeTaxExpense`,
			`ris`.`interestAndDebtExpense`,`ris`.`netIncomeFromContinuingOperations`,`ris`.`comprehensiveIncomeNetOfTax`,`ris`.`ebit`,`ris`.`ebitda`,`ris`.`netIncome`, NOW() AS `CreatedDate`
			FROM `stocks`.`RawIncomeStatement` `ris`
			INNER JOIN CompanyOverview co ON ris.StockSymbol = co.Symbol
			LEFT OUTER JOIN IncomeStatement ins ON ins.StockID = co.StockID AND `ris`.`fiscalDateEnding` = `ins`.`FiscalDateEnding`
			WHERE ins.StockID IS NULL;

		INSERT INTO `stocks`.`IncomeStatement`(`StockID`,`FiscalDateEnding`,`ReportedCurrency`,`GrossProfit`,`TotalRevenue`,`CostOfRevenue`,`CostofGoodsAndServicesSold`,`OperatingIncome`,
			`SellingGeneralAndAdministrative`,`ResearchAndDevelopment`,`OperatingExpenses`,`InvestmentIncomeNet`,`NetInterestIncome`,`InterestIncome`,`InterestExpense`,`NonInterestIncome`,`OtherNonOperatingIncome`,
			`Depreciation`,`DepreciationAndAmortization`,`IncomeBeforeTax`,`IncomeTaxExpense`,`InterestAndDebtExpense`,`NetIncomeFromContinuingOperations`
			,`ComprehensiveIncomeNetOfTax`,`Ebit`,`Ebitda`,`NetIncome`,`CreatedDate`)
			SELECT `StockID`, `fiscalDateEnding`,`reportedCurrency`,`grossProfit`,`totalRevenue`,`costOfRevenue`,`costofGoodsAndServicesSold`,
            `operatingIncome`,`sellingGeneralAndAdministrative`,`researchAndDevelopment`,`operatingExpenses`,`investmentIncomeNet`,`netInterestIncome`,`interestIncome`,
            `interestExpense`,`nonInterestIncome`,`otherNonOperatingIncome`,`depreciation`,`depreciationAndAmortization`,`incomeBeforeTax`,`incomeTaxExpense`,
			`interestAndDebtExpense`,`netIncomeFromContinuingOperations`,`comprehensiveIncomeNetOfTax`,`ebit`,`ebitda`,`netIncome`, `CreatedDate` FROM NewRecords;

		DELETE FROM RawIncomeStatement ris WHERE ris.StockSymbol IN (SELECT StockSymbol FROM NewRecords);
		DROP TEMPORARY TABLE IF EXISTS NewRecords;

		UPDATE IncomeStatement ins
			INNER JOIN CompanyOverview co ON ins.StockID = co.StockID
			INNER JOIN RawIncomeStatement ris ON co.Symbol = ris.StockSymbol
			SET 
				`ins`.`ReportedCurrency` = `ris`.`reportedCurrency`,`ins`.`GrossProfit` = `ris`.`grossProfit`,`ins`.`TotalRevenue` = `ris`.`totalRevenue`,`ins`.`CostOfRevenue` = `ris`.`costOfRevenue`,
                `ins`.`CostofGoodsAndServicesSold` = `ris`.`costofGoodsAndServicesSold`,`ins`.`OperatingIncome` = `ris`.`operatingIncome`,`ins`.`SellingGeneralAndAdministrative` = `ris`.`sellingGeneralAndAdministrative`,
                `ins`.`ResearchAndDevelopment` = `ris`.`researchAndDevelopment`,`ins`.`OperatingExpenses` = `ris`.`operatingExpenses`,`ins`.`InvestmentIncomeNet` = `ris`.`investmentIncomeNet`,
                `ins`.`NetInterestIncome` = `ris`.`netInterestIncome`,`ins`.`InterestIncome` = `ris`.`interestIncome`,`ins`.`InterestExpense` = `ris`.`interestExpense`,`ins`.`NonInterestIncome` = `ris`.`nonInterestIncome`,
                `ins`.`OtherNonOperatingIncome` = `ris`.`otherNonOperatingIncome`,`ins`.`Depreciation` = `ris`.`depreciation`,`ins`.`DepreciationAndAmortization` = `ris`.`depreciationAndAmortization`,`ins`.`IncomeBeforeTax` = `ris`.`incomeBeforeTax`,
                `ins`.`IncomeTaxExpense` = `ris`.`incomeTaxExpense`,`ins`.`InterestAndDebtExpense` = `ris`.`interestAndDebtExpense`,`ins`.`NetIncomeFromContinuingOperations` = `ris`.`netIncomeFromContinuingOperations`,
                `ins`.`ComprehensiveIncomeNetOfTax` = `ris`.`comprehensiveIncomeNetOfTax`,`ins`.`Ebit` = `ris`.`ebit`,`ins`.`Ebitda` = `ris`.`ebitda`,`ins`.`NetIncome` = `ris`.`netIncome` 
            WHERE `ris`.`fiscalDateEnding` = `ins`.`FiscalDateEnding` AND ris.StockSymbol = co.Symbol;
        
        DELETE FROM RawIncomeStatement ris WHERE ris.StockSymbol IN (SELECT Symbol FROM CompanyOverview);
		
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RawNewsToNews` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `RawNewsToNews`()
BEGIN

	DECLARE iRawNewsID INT; 

 -- Error Handler --
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 @errno = MYSQL_ERRNO, @ErrorMsg = MESSAGE_TEXT;
        insert into errorlog(ObjectName, ErrorNumber, ErrorMessage, CreatedDate)
        VALUES ('RawNewsToNews', @errno, @ErrorMsg, NOW());
    END;
    -- Error Handler End --

	SET SQL_SAFE_UPDATES = 0;
	
    IF ( (SELECT COUNT(*) FROM RawNews) > 0) THEN

        CREATE TEMPORARY TABLE IF NOT EXISTS rn(
			`RawNewsID` int NOT NULL, `title` varchar(255) DEFAULT NULL, `url` varchar(255) DEFAULT NULL, `time_published` datetime DEFAULT NULL,
			`authors` varchar(200) DEFAULT NULL, `summary` varchar(800) DEFAULT NULL, `banner_image` varchar(255) DEFAULT NULL, `source` varchar(255) DEFAULT NULL,
			`category_within_source` varchar(255) DEFAULT NULL, `source_domain` varchar(255) DEFAULT NULL, `overall_sentiment_score` decimal(20,10) DEFAULT NULL,
			`overall_sentiment_label` varchar(255) DEFAULT NULL,	`topic` varchar(45) DEFAULT NULL, `topic_relevance_score` decimal(20,10) DEFAULT NULL, `ticker` varchar(45) DEFAULT NULL,
			`ticker_relevance_score` decimal(20,10) DEFAULT NULL, `ticker_sentiment_label` varchar(255) DEFAULT NULL, `ticker_sentiment_score` decimal(20,10) DEFAULT NULL,
			PRIMARY KEY (`RawNewsID`), KEY `Idx1` (`url`), KEY `Idx2` (`topic`),KEY `Idx3` (`ticker`));
          
		INSERT INTO rn
			(`RawNewsID`, `title`, `url`, `time_published`, `authors`, `summary`, `banner_image`, `source`,
			`category_within_source`, `source_domain`, `overall_sentiment_score`, `overall_sentiment_label`,
			`topic`, `topic_relevance_score`, `ticker`, `ticker_relevance_score`, `ticker_sentiment_label`, `ticker_sentiment_score`)
			SELECT * FROM RawNews;
        
		INSERT INTO NewsArticle (Title, Authors, `Source`, SourceCategory, SourceDomain, Link, `Summary`, Sentiment, SentimentScore, PublishDate)
			SELECT `rs`.`title`, `rs`.`authors`, `rs`.`source`, `rs`.`category_within_source`, `rs`.`source_domain`, `rs`.`url`, `rs`.`summary`, 
			`rs`.`overall_sentiment_label`, `rs`.`overall_sentiment_score`, `rs`.`time_published`
			FROM rn rs LEFT OUTER JOIN  NewsArticle ON rs.`url` = NewsArticle.`Link` WHERE NewsArticle.NewsArticleID IS NULL 
			GROUP BY `rs`.`url`;

		INSERT INTO NewsArticleToTopic(NewsArticleID, NewsTopicID, Relevance)
			SELECT na.NewsArticleID, nt.NewsTopicID, ra.topic_relevance_score
			FROM NewsArticle na INNER JOIN rn ra ON na.Link = ra.`url` INNER JOIN NewsTopic nt ON nt.Name = ra.topic
			LEFT OUTER JOIN NewsArticleToTopic natt ON na.NewsArticleID = natt.NewsArticleID AND nt.NewsTopicID = natt.NewsTopicID
			WHERE natt.NewsArticleToTopicID IS NULL
			GROUP BY na.NewsArticleID, nt.NewsTopicID;

		INSERT INTO NewsArticleToStock(NewsArticleID, StockID, Relevance, Sentiment, SentimentScore)
			SELECT na.NewsArticleID, s.StockID, ra.ticker_relevance_score, ra.ticker_sentiment_label, ra.ticker_sentiment_score
			FROM NewsArticle na INNER JOIN rn ra ON na.Link = ra.`url` INNER JOIN stock s ON s.Symbol = ra.ticker
			LEFT OUTER JOIN NewsArticleToStock nats ON na.NewsArticleID = nats.NewsArticleID AND s.StockID = nats.StockID
			WHERE nats.NewsArticleToStockID IS NULL
			GROUP BY na.NewsArticleID, nats.StockID;
		
		
		DELETE RawNews FROM RawNews INNER JOIN rn ON RawNews.RawNewsID = rn.RawNewsID;
        
        DROP TEMPORARY TABLE IF EXISTS rn;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ReCalculateAllDeltaBoilerBand` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ReCalculateAllDeltaBoilerBand`()
BEGIN
	DECLARE finished INT DEFAULT 0;
    DECLARE iFinancialDataID INT DEFAULT 0;
    DECLARE iClosePrice FLOAT DEFAULT 0;
    
    DECLARE OpenMiddleClosePrice CURSOR FOR SELECT FinancialDataID, `Close` FROM financialdata;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;
    
    -- Error Handler --
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 @errno = MYSQL_ERRNO, @ErrorMsg = MESSAGE_TEXT;
        insert into errorlog(ObjectName, ErrorNumber, ErrorMessage, CreatedDate)
        VALUES ('ReCalculateAllDeltaBoilerBand', @errno, @ErrorMsg, NOW());
    END;
    -- Error Handler End --

	CREATE TEMPORARY TABLE IF NOT EXISTS difFromMaxLow (FinancialDataID INT, `Close` FLOAT, iStdDevOutPercentage FLOAT DEFAULT 0);

	INSERT INTO difFromMaxLow (FinancialDataID, `Close`)
	SELECT FinancialDataID, `Close` FROM FinancialData;
    
    OPEN OpenMiddleClosePrice;
    UpdatingiStdDevOutPercentage: LOOP
		FETCH OpenMiddleClosePrice INTO iFinancialDataID, iClosePrice;
			IF finished = 1 THEN
				LEAVE UpdatingiStdDevOutPercentage;
			ELSE
				IF (iClosePrice > (SELECT `Upper` FROM boilerband WHERE boilerband.FinancialDataID = iFinancialDataID)) THEN
					UPDATE difFromMaxLow SET iStdDevOutPercentage = ((1 - ((SELECT `Upper` FROM boilerband WHERE boilerband.FinancialDataID = difFromMaxLow. FinancialDataID)/iClosePrice)) * 100) 
					WHERE difFromMaxLow.FinancialDataID = iFinancialDataID; 
                ELSEIF (iClosePrice < (SELECT `Lower` FROM boilerband WHERE boilerband.FinancialDataID = iFinancialDataID)) THEN
					UPDATE difFromMaxLow SET iStdDevOutPercentage = ((1 - (iClosePrice/(SELECT `Lower` FROM boilerband WHERE boilerband.FinancialDataID = difFromMaxLow. FinancialDataID))) * -100)
                    WHERE difFromMaxLow.FinancialDataID = iFinancialDataID; 
				END IF;
			END IF;
		END LOOP UpdatingiStdDevOutPercentage;
    CLOSE OpenMiddleClosePrice;  
	    
     UPDATE boilerband bb INNER JOIN difFromMaxLow dfml ON bb.FinancialDataID = dfml.FinancialDataID
		SET bb.OutsideStdDev = 1, AmountOutStdDev = dfml.iStdDevOutPercentage, bb.UpdatedDate = NOW()
        WHERE bb.FinancialDataID = dfml.FinancialDataID; 

    DROP TABLE IF EXISTS difFromMaxLow;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdatePresentationStocks` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `UpdatePresentationStocks`()
BEGIN
	
    
    
            -- Error Handler --
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 @errno = MYSQL_ERRNO, @ErrorMsg = MESSAGE_TEXT;
        insert into errorlog(ObjectName, ErrorNumber, ErrorMessage, CreatedDate)
        VALUES ('UpdatePresentationStocks', @errno, @ErrorMsg, NOW());
    END;
    -- Error Handler End --
    
	SET SQL_SAFE_UPDATES = 0;
    
    DELETE FROM PresentationStock;
    
    CREATE TEMPORARY TABLE IF NOT EXISTS tempPresStocks
	SELECT co.StockID 
    FROM raw_data_to_data_transaction rdt 
    INNER JOIN CompanyOverview co ON rdt.StockID = co.StockID
    INNER JOIN NewsArticleToStock nats ON co.StockID = nats.StockID
    GROUP BY rdt.StockID HAVING SUM(rdt.RecordQuantity) > 10000 ORDER BY RAND() LIMIT 10;

	INSERT INTO PresentationStock(StockID, StockExchange)
	SELECT s.StockID, s.StockExchange FROM stock s WHERE s.StockID IN (SELECT StockID FROM tempPresStocks);
	
    CREATE TEMPORARY TABLE IF NOT EXISTS tempDatePressStocks
    SELECT ps.StockID, ps.StockExchange, MIN(fd.StockDate) AS MinDate, MAX(fd.StockDate) as MaxDate FROM PresentationStock ps INNER JOIN FinancialData fd ON ps.StockID = fd.StockID GROUP BY fd.StockID;
    
	UPDATE PresentationStock ps INNER JOIN tempDatePressStocks tdps ON ps.StockID = tdps.StockID
	SET ps.StartDate = tdps.MinDate, ps.EndDate = tdps.MaxDate, ps.UpdatedDate = NOW(), ps.Active = 1;
	
	DROP TEMPORARY TABLE IF EXISTS tempPresStocks;
	DROP TEMPORARY TABLE IF EXISTS tempDatePressStocks;
    
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `PresentationBalanceSheet`
--

/*!50001 DROP VIEW IF EXISTS `PresentationBalanceSheet`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `PresentationBalanceSheet` AS select `bs`.`BalanceSheetID` AS `BalanceSheetID`,`bs`.`StockID` AS `StockID`,`bs`.`FiscalDateEnding` AS `FiscalDateEnding`,`bs`.`ReportedCurrency` AS `ReportedCurrency`,`bs`.`TotalAssets` AS `TotalAssets`,`bs`.`TotalCurrentAssets` AS `TotalCurrentAssets`,`bs`.`CashAndCashEquivalentsAtCarryingValue` AS `CashAndCashEquivalentsAtCarryingValue`,`bs`.`CashAndShortTermInvestments` AS `CashAndShortTermInvestments`,`bs`.`Inventory` AS `Inventory`,`bs`.`CurrentNetReceivables` AS `CurrentNetReceivables`,`bs`.`TotalNonCurrentAssets` AS `TotalNonCurrentAssets`,`bs`.`PropertyPlantEquipment` AS `PropertyPlantEquipment`,`bs`.`AccumulatedDepreciationAmortizationPPE` AS `AccumulatedDepreciationAmortizationPPE`,`bs`.`IntangibleAssets` AS `IntangibleAssets`,`bs`.`IntangibleAssetsExcludingGoodwill` AS `IntangibleAssetsExcludingGoodwill`,`bs`.`Goodwill` AS `Goodwill`,`bs`.`Investments` AS `Investments`,`bs`.`LongTermInvestments` AS `LongTermInvestments`,`bs`.`ShortTermInvestments` AS `ShortTermInvestments`,`bs`.`OtherCurrentAssets` AS `OtherCurrentAssets`,`bs`.`OtherNonCurrentAssets` AS `OtherNonCurrentAssets`,`bs`.`TotalLiabilities` AS `TotalLiabilities`,`bs`.`TotalCurrentLiabilities` AS `TotalCurrentLiabilities`,`bs`.`CurrentAccountsPayable` AS `CurrentAccountsPayable`,`bs`.`DeferredRevenue` AS `DeferredRevenue`,`bs`.`CurrentDebt` AS `CurrentDebt`,`bs`.`ShortTermDebt` AS `ShortTermDebt`,`bs`.`TotalNonCurrentLiabilities` AS `TotalNonCurrentLiabilities`,`bs`.`CapitalLeaseObligations` AS `CapitalLeaseObligations`,`bs`.`LongTermDebt` AS `LongTermDebt`,`bs`.`CurrentLongTermDebt` AS `CurrentLongTermDebt`,`bs`.`LongTermDebtNoncurrent` AS `LongTermDebtNoncurrent`,`bs`.`ShortLongTermDebtTotal` AS `ShortLongTermDebtTotal`,`bs`.`OtherCurrentLiabilities` AS `OtherCurrentLiabilities`,`bs`.`OtherNonCurrentLiabilities` AS `OtherNonCurrentLiabilities`,`bs`.`TotalShareholderEquity` AS `TotalShareholderEquity`,`bs`.`TreasuryStock` AS `TreasuryStock`,`bs`.`RetainedEarnings` AS `RetainedEarnings`,`bs`.`CommonStock` AS `CommonStock`,`bs`.`CommonStockSharesOutstanding` AS `CommonStockSharesOutstanding`,`bs`.`CreatedDate` AS `CreatedDate` from (`BalanceSheet` `bs` join `PresentationStocks` `ps` on((`bs`.`StockID` = `ps`.`StockID`))) where (`bs`.`FiscalDateEnding` >= '2020-01-01 00:00:00') order by `bs`.`FiscalDateEnding` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `PresentationBoilerBand`
--

/*!50001 DROP VIEW IF EXISTS `PresentationBoilerBand`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `PresentationBoilerBand` AS select `bb`.`BoilerBandID` AS `BoilerBandID`,`bb`.`StockID` AS `StockID`,`bb`.`FinancialDataID` AS `FinancialDataID`,`bb`.`StockDate` AS `StockDate`,`bb`.`Lower` AS `Lower`,`bb`.`Middle` AS `Middle`,`bb`.`Upper` AS `Upper`,`bb`.`WidthPercentage` AS `WidthPercentage`,`bb`.`OutsideStdDev` AS `OutsideStdDev`,`bb`.`AmountOutStdDev` AS `AmountOutStdDev`,`bb`.`UpdatedDate` AS `UpdatedDate` from (`boilerband` `bb` join `PresentationFinancialData` `pfd` on((`pfd`.`FinancialDataID` = `bb`.`FinancialDataID`))) where ((`bb`.`StockDate` >= '2020-01-01 00:00:00') and (`bb`.`StockDate` <= (now() - interval 25 minute))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `PresentationCashFlow`
--

/*!50001 DROP VIEW IF EXISTS `PresentationCashFlow`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `PresentationCashFlow` AS select `cf`.`CashFlowID` AS `CashFlowID`,`cf`.`StockID` AS `StockID`,`cf`.`FiscalDateEnding` AS `FiscalDateEnding`,`cf`.`ReportedCurrency` AS `ReportedCurrency`,`cf`.`OperatingCashflow` AS `OperatingCashflow`,`cf`.`PaymentsForOperatingActivities` AS `PaymentsForOperatingActivities`,`cf`.`ProceedsFromOperatingActivities` AS `ProceedsFromOperatingActivities`,`cf`.`ChangeInOperatingLiabilities` AS `ChangeInOperatingLiabilities`,`cf`.`ChangeInOperatingAssets` AS `ChangeInOperatingAssets`,`cf`.`DepreciationDepletionAndAmortization` AS `DepreciationDepletionAndAmortization`,`cf`.`CapitalExpenditures` AS `CapitalExpenditures`,`cf`.`ChangeInReceivables` AS `ChangeInReceivables`,`cf`.`ChangeInInventory` AS `ChangeInInventory`,`cf`.`ProfitLoss` AS `ProfitLoss`,`cf`.`CashflowFromInvestment` AS `CashflowFromInvestment`,`cf`.`CashflowFromFinancing` AS `CashflowFromFinancing`,`cf`.`ProceedsFromRepaymentsOfShortTermDebt` AS `ProceedsFromRepaymentsOfShortTermDebt`,`cf`.`PaymentsForRepurchaseOfCommonStock` AS `PaymentsForRepurchaseOfCommonStock`,`cf`.`PaymentsForRepurchaseOfEquity` AS `PaymentsForRepurchaseOfEquity`,`cf`.`PaymentsForRepurchaseOfPreferredStock` AS `PaymentsForRepurchaseOfPreferredStock`,`cf`.`DividendPayout` AS `DividendPayout`,`cf`.`DividendPayoutCommonStock` AS `DividendPayoutCommonStock`,`cf`.`DividendPayoutPreferredStock` AS `DividendPayoutPreferredStock`,`cf`.`ProceedsFromIssuanceOfCommonStock` AS `ProceedsFromIssuanceOfCommonStock`,`cf`.`ProceedsFromIssuanceOfLongTermDebtAndCapitalSecuritiesNet` AS `ProceedsFromIssuanceOfLongTermDebtAndCapitalSecuritiesNet`,`cf`.`ProceedsFromIssuanceOfPreferredStock` AS `ProceedsFromIssuanceOfPreferredStock`,`cf`.`ProceedsFromRepurchaseOfEquity` AS `ProceedsFromRepurchaseOfEquity`,`cf`.`ProceedsFromSaleOfTreasuryStock` AS `ProceedsFromSaleOfTreasuryStock`,`cf`.`ChangeInCashAndCashEquivalents` AS `ChangeInCashAndCashEquivalents`,`cf`.`ChangeInExchangeRate` AS `ChangeInExchangeRate`,`cf`.`NetIncome` AS `NetIncome`,`cf`.`CreatedDate` AS `CreatedDate` from (`CashFlow` `cf` join `PresentationStocks` `ps` on((`cf`.`StockID` = `ps`.`StockID`))) where (`cf`.`FiscalDateEnding` >= '2020-01-01 00:00:00') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `PresentationChaikinOscillator`
--

/*!50001 DROP VIEW IF EXISTS `PresentationChaikinOscillator`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `PresentationChaikinOscillator` AS select `co`.`ChaikinOscillatorID` AS `ChaikinOscillatorID`,`co`.`StockID` AS `StockID`,`co`.`FinancialDataID` AS `FinancialDataID`,`co`.`StockDate` AS `StockDate`,`co`.`ChaikinADLine` AS `ChaikinADLine`,`co`.`CrossedZero` AS `CrossedZero`,`co`.`UpdatedDate` AS `UpdatedDate` from (`chaikinoscillator` `co` join `PresentationFinancialData` `pfd` on((`co`.`FinancialDataID` = `pfd`.`FinancialDataID`))) where ((`co`.`StockDate` >= '2020-01-01 00:00:00') and (`co`.`StockDate` <= (now() - interval 25 minute))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `PresentationCompanyOverview`
--

/*!50001 DROP VIEW IF EXISTS `PresentationCompanyOverview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `PresentationCompanyOverview` AS select `co`.`CompanyOverviewID` AS `CompanyOverviewID`,`co`.`StockID` AS `StockID`,`co`.`Symbol` AS `Symbol`,`co`.`AssetType` AS `AssetType`,`co`.`Name` AS `Name`,`co`.`Description` AS `Description`,`co`.`CIK` AS `CIK`,`co`.`Exchange` AS `Exchange`,`co`.`Currency` AS `Currency`,`co`.`Country` AS `Country`,`co`.`Sector` AS `Sector`,`co`.`Industry` AS `Industry`,`co`.`Address` AS `Address`,`co`.`OfficialSite` AS `OfficialSite`,`co`.`FiscalYearEnd` AS `FiscalYearEnd`,`co`.`LatestQuarter` AS `LatestQuarter`,`co`.`MarketCapitalization` AS `MarketCapitalization`,`co`.`EBITDA` AS `EBITDA`,`co`.`PERatio` AS `PERatio`,`co`.`PEGRatio` AS `PEGRatio`,`co`.`BookValue` AS `BookValue`,`co`.`DividendPerShare` AS `DividendPerShare`,`co`.`DividendYield` AS `DividendYield`,`co`.`EPS` AS `EPS`,`co`.`RevenuePerShareTTM` AS `RevenuePerShareTTM`,`co`.`ProfitMargin` AS `ProfitMargin`,`co`.`OperatingMarginTTM` AS `OperatingMarginTTM`,`co`.`ReturnOnAssetsTTM` AS `ReturnOnAssetsTTM`,`co`.`ReturnOnEquityTTM` AS `ReturnOnEquityTTM`,`co`.`RevenueTTM` AS `RevenueTTM`,`co`.`GrossProfitTTM` AS `GrossProfitTTM`,`co`.`DilutedEPSTTM` AS `DilutedEPSTTM`,`co`.`QuarterlyEarningsGrowthYOY` AS `QuarterlyEarningsGrowthYOY`,`co`.`QuarterlyRevenueGrowthYOY` AS `QuarterlyRevenueGrowthYOY`,`co`.`AnalystTargetPrice` AS `AnalystTargetPrice`,`co`.`AnalystRatingStrongBuy` AS `AnalystRatingStrongBuy`,`co`.`AnalystRatingBuy` AS `AnalystRatingBuy`,`co`.`AnalystRatingHold` AS `AnalystRatingHold`,`co`.`AnalystRatingSell` AS `AnalystRatingSell`,`co`.`AnalystRatingStrongSell` AS `AnalystRatingStrongSell`,`co`.`TrailingPE` AS `TrailingPE`,`co`.`ForwardPE` AS `ForwardPE`,`co`.`PriceToSalesRatioTTM` AS `PriceToSalesRatioTTM`,`co`.`PriceToBookRatio` AS `PriceToBookRatio`,`co`.`EVToRevenue` AS `EVToRevenue`,`co`.`EVToEBITDA` AS `EVToEBITDA`,`co`.`Beta` AS `Beta`,`co`.`52WeekHigh` AS `52WeekHigh`,`co`.`52WeekLow` AS `52WeekLow`,`co`.`50DayMovingAverage` AS `50DayMovingAverage`,`co`.`200DayMovingAverage` AS `200DayMovingAverage`,`co`.`SharesOutstanding` AS `SharesOutstanding`,`co`.`DividendDate` AS `DividendDate`,`co`.`ExDividendDate` AS `ExDividendDate`,`co`.`UpdatedDate` AS `UpdatedDate`,`co`.`CreatedDate` AS `CreatedDate` from (`CompanyOverview` `co` join `PresentationStock` `ps` on((`co`.`StockID` = `ps`.`StockID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `PresentationDirectionalMovement`
--

/*!50001 DROP VIEW IF EXISTS `PresentationDirectionalMovement`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `PresentationDirectionalMovement` AS select `dm`.`DirectionalMovementID` AS `DirectionalMovementID`,`dm`.`StockID` AS `StockID`,`dm`.`FinancialDataID` AS `FinancialDataID`,`dm`.`StockDate` AS `StockDate`,`dm`.`ADX` AS `ADX`,`dm`.`DX` AS `DX`,`dm`.`DMIPlus` AS `DMIPlus`,`dm`.`DMIMinus` AS `DMIMinus`,`dm`.`TrendDirection` AS `TrendDirection`,`dm`.`TrendChange` AS `TrendChange`,`dm`.`UpdatedDate` AS `UpdatedDate` from (`directionalmovement` `dm` join `PresentationFinancialData` `pfd` on((`dm`.`FinancialDataID` = `pfd`.`FinancialDataID`))) where ((`dm`.`StockDate` >= '2020-01-01 00:00:00') and (`dm`.`StockDate` <= (now() - interval 25 minute))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `PresentationEarnings`
--

/*!50001 DROP VIEW IF EXISTS `PresentationEarnings`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `PresentationEarnings` AS select `e`.`EarningsID` AS `EarningsID`,`e`.`StockID` AS `StockID`,`e`.`FiscalDateEnding` AS `FiscalDateEnding`,`e`.`ReportedDate` AS `ReportedDate`,`e`.`ReportedEPS` AS `ReportedEPS`,`e`.`EstimatedEPS` AS `EstimatedEPS`,`e`.`Surprise` AS `Surprise`,`e`.`SurprisePercentage` AS `SurprisePercentage`,`e`.`ReportTime` AS `ReportTime`,`e`.`CreatedDate` AS `CreatedDate` from (`Earnings` `e` join `PresentationStocks` `ps` on((`e`.`StockID` = `ps`.`StockID`))) where (`e`.`FiscalDateEnding` >= '2020-01-01 00:00:00') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `PresentationFinancialData`
--

/*!50001 DROP VIEW IF EXISTS `PresentationFinancialData`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `PresentationFinancialData` AS select `fd`.`FinancialDataID` AS `FinancialDataID`,`fd`.`StockID` AS `StockID`,`fd`.`StockDate` AS `StockDate`,`fd`.`Open` AS `Open`,`fd`.`Low` AS `Low`,`fd`.`High` AS `High`,`fd`.`Close` AS `Close`,`fd`.`Volume` AS `Volume`,`fd`.`EMA` AS `EMA`,`fd`.`VWAP` AS `VWAP`,`fd`.`RateOfChange` AS `RateOfChange`,`fd`.`OnBalanceVolume` AS `OnBalanceVolume` from (`FinancialData` `fd` join `PresentationStock` `ps` on((`fd`.`StockID` = `ps`.`StockID`))) where ((`fd`.`StockDate` >= '2020-01-01 00:00:00') and (`fd`.`StockDate` <= (now() - interval 25 minute))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `PresentationIncomeStatement`
--

/*!50001 DROP VIEW IF EXISTS `PresentationIncomeStatement`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `PresentationIncomeStatement` AS select `ics`.`IncomeStatementID` AS `IncomeStatementID`,`ics`.`StockID` AS `StockID`,`ics`.`FiscalDateEnding` AS `FiscalDateEnding`,`ics`.`ReportedCurrency` AS `ReportedCurrency`,`ics`.`GrossProfit` AS `GrossProfit`,`ics`.`TotalRevenue` AS `TotalRevenue`,`ics`.`CostOfRevenue` AS `CostOfRevenue`,`ics`.`CostofGoodsAndServicesSold` AS `CostofGoodsAndServicesSold`,`ics`.`OperatingIncome` AS `OperatingIncome`,`ics`.`SellingGeneralAndAdministrative` AS `SellingGeneralAndAdministrative`,`ics`.`ResearchAndDevelopment` AS `ResearchAndDevelopment`,`ics`.`OperatingExpenses` AS `OperatingExpenses`,`ics`.`InvestmentIncomeNet` AS `InvestmentIncomeNet`,`ics`.`NetInterestIncome` AS `NetInterestIncome`,`ics`.`InterestIncome` AS `InterestIncome`,`ics`.`InterestExpense` AS `InterestExpense`,`ics`.`NonInterestIncome` AS `NonInterestIncome`,`ics`.`OtherNonOperatingIncome` AS `OtherNonOperatingIncome`,`ics`.`Depreciation` AS `Depreciation`,`ics`.`DepreciationAndAmortization` AS `DepreciationAndAmortization`,`ics`.`IncomeBeforeTax` AS `IncomeBeforeTax`,`ics`.`IncomeTaxExpense` AS `IncomeTaxExpense`,`ics`.`InterestAndDebtExpense` AS `InterestAndDebtExpense`,`ics`.`NetIncomeFromContinuingOperations` AS `NetIncomeFromContinuingOperations`,`ics`.`ComprehensiveIncomeNetOfTax` AS `ComprehensiveIncomeNetOfTax`,`ics`.`Ebit` AS `Ebit`,`ics`.`Ebitda` AS `Ebitda`,`ics`.`NetIncome` AS `NetIncome`,`ics`.`CreatedDate` AS `CreatedDate` from (`IncomeStatement` `ics` join `PresentationStocks` `ps` on((`ics`.`StockID` = `ps`.`StockID`))) where (`ics`.`FiscalDateEnding` >= '2020-01-01 00:00:00') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `PresentationMACD`
--

/*!50001 DROP VIEW IF EXISTS `PresentationMACD`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `PresentationMACD` AS select `md`.`MACDID` AS `MACDID`,`md`.`StockID` AS `StockID`,`md`.`FinancialDataID` AS `FinancialDataID`,`md`.`StockDate` AS `StockDate`,`md`.`MACD` AS `MACD`,`md`.`MACD_Signal` AS `MACD_Signal`,`md`.`MACD_Hist` AS `MACD_Hist`,`md`.`CrossedZero` AS `CrossedZero`,`md`.`TrendDirection` AS `TrendDirection`,`md`.`TrendChange` AS `TrendChange`,`md`.`UpdatedDate` AS `UpdatedDate` from (`macd` `md` join `PresentationFinancialData` `pfd` on((`md`.`FinancialDataID` = `pfd`.`FinancialDataID`))) where ((`md`.`StockDate` >= '2020-01-01 00:00:00') and (`md`.`StockDate` <= (now() - interval 25 minute))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `PresentationNewsArticle`
--

/*!50001 DROP VIEW IF EXISTS `PresentationNewsArticle`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `PresentationNewsArticle` AS select `na`.`NewsArticleID` AS `NewsArticleID`,`na`.`Title` AS `Title`,`na`.`Authors` AS `Authors`,`na`.`Source` AS `Source`,`na`.`SourceCategory` AS `SourceCategory`,`na`.`SourceDomain` AS `SourceDomain`,`na`.`Link` AS `Link`,`na`.`Summary` AS `Summary`,`na`.`Sentiment` AS `Sentiment`,`na`.`SentimentScore` AS `SentimentScore`,`na`.`PublishDate` AS `PublishDate`,`nt`.`NewsTopicID` AS `NewsTopicID`,`nt`.`DisplayName` AS `DisplayName`,`natt`.`Relevance` AS `TopicRelevance` from (((`NewsArticleToTopic` `natt` join `NewsArticle` `na` on((`natt`.`NewsArticleID` = `na`.`NewsArticleID`))) join `PresentationNewsArticleToStocks` `pnats` on((`pnats`.`NewsArticleID` = `natt`.`NewsArticleID`))) join `NewsTopic` `nt` on((`natt`.`NewsTopicID` = `nt`.`NewsTopicID`))) where (`na`.`PublishDate` >= '2020-01-01 00:00:00') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `PresentationNewsArticleToStocks`
--

/*!50001 DROP VIEW IF EXISTS `PresentationNewsArticleToStocks`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `PresentationNewsArticleToStocks` AS select `na`.`NewsArticleID` AS `NewsArticleID`,`na`.`Title` AS `Title`,`na`.`Authors` AS `Authors`,`na`.`Source` AS `Source`,`na`.`SourceCategory` AS `SourceCategory`,`na`.`SourceDomain` AS `SourceDomain`,`na`.`Link` AS `Link`,`na`.`Summary` AS `Summary`,`na`.`Sentiment` AS `ArticleSentiment`,`na`.`SentimentScore` AS `ArticleSentimentScore`,`na`.`PublishDate` AS `PublishDate`,`nats`.`Relevance` AS `StockRelevance`,`nats`.`Sentiment` AS `StockSentiment`,`nats`.`SentimentScore` AS `StockSentimentScore`,`ps`.`CompanyName` AS `CompanyName`,`ps`.`Symbol` AS `Symbol`,`ps`.`AssetType` AS `AssetType`,`ps`.`StockExchange` AS `StockExchange`,`ps`.`StockID` AS `StockID` from ((`NewsArticleToStock` `nats` join `PresentationStocks` `ps` on((`nats`.`StockID` = `ps`.`StockID`))) join `NewsArticle` `na` on((`na`.`NewsArticleID` = `nats`.`NewsArticleID`))) where (`na`.`PublishDate` >= '2020-01-01 00:00:00') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `PresentationSar`
--

/*!50001 DROP VIEW IF EXISTS `PresentationSar`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `PresentationSar` AS select `sar`.`SarID` AS `SarID`,`sar`.`StockID` AS `StockID`,`sar`.`FinancialDataID` AS `FinancialDataID`,`sar`.`StockDate` AS `StockDate`,`sar`.`Sar` AS `Sar`,`sar`.`WMA` AS `WMA`,`sar`.`TrendDirection` AS `TrendDirection`,`sar`.`TrendChange` AS `TrendChange`,`sar`.`UpdatedDate` AS `UpdatedDate` from (`sar` join `PresentationFinancialData` `pfd` on((`sar`.`FinancialDataID` = `pfd`.`FinancialDataID`))) where ((`sar`.`StockDate` >= '2020-01-01 00:00:00') and (`sar`.`StockDate` <= (now() - interval 25 minute))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `PresentationStocks`
--

/*!50001 DROP VIEW IF EXISTS `PresentationStocks`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `PresentationStocks` AS select `s`.`StockID` AS `StockID`,`s`.`CompanyName` AS `CompanyName`,`s`.`Symbol` AS `Symbol`,`s`.`AssetType` AS `AssetType`,`s`.`StockExchange` AS `StockExchange`,`s`.`NoData` AS `NoData`,`s`.`LastStockDate` AS `LastStockDate`,`s`.`NextReportDate` AS `NextReportDate`,`s`.`NextFiscalDateEnd` AS `NextFiscalDateEnd`,`s`.`LastNewsRetrieval` AS `LastNewsRetrieval`,`s`.`UpdatedDate` AS `UpdatedDate`,`s`.`CreatedDate` AS `CreatedDate` from (`stock` `s` join `PresentationStock` `ps` on((`s`.`StockID` = `ps`.`StockID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-23 16:36:48
