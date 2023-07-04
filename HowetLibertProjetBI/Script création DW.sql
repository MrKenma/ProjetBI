USE DataWarehouse;

DROP TABLE IF EXISTS [dbo].[DimDate];
CREATE TABLE [dbo].[DimDate](
	[DateKey] [int] NOT NULL PRIMARY KEY,
	[DayFrenchName] [nvarchar](100) NOT NULL,
	[DayEnglishName] [nvarchar](100) NOT NULL,
	[MonthFrenchName] [nvarchar](100) NOT NULL,
	[MonthEnglishName] [nvarchar](100) NOT NULL,
	[Year] [int] NOT NULL,
	[WeekNumber] [int] NOT NULL,
	[DayOfWeekNumber] [int] NOT NULL,
	[DayOfYearNumber] [int] NOT NULL
)

DROP TABLE IF EXISTS [dbo].[DimEmployee];
CREATE TABLE [dbo].[DimEmployee](
	[EmployeeId] [int] NOT NULL IDENTITY(0,1) PRIMARY KEY,
	[EmployeeDBId] [int] NOT NULL,
	[EmployeeLastName] [nvarchar](20) NOT NULL,
	[EmployeeFirstName] [nvarchar](20) NOT NULL,
	[TitleFrench] [nvarchar](40) NOT NULL,
	[TitleEnglsih] [nvarchar](30) NOT NULL,
	[CityFrench] [nvarchar](50) NOT NULL,
	[CityEnglish][nvarchar](50) NOT NULL,
	[CountryFrench] [nvarchar](50) NOT NULL,
	[CountryEnglish][nvarchar](50) NOT NULL,
)


DROP TABLE IF EXISTS [dbo].[DimSupplier];
CREATE TABLE [dbo].[DimSupplier](
	[SupplierId] [int] NOT NULL IDENTITY(0,1) PRIMARY KEY,
	[SupplierDBId] [int] NOT NULL, 
	[CompanyName] [nvarchar](40) NOT NULL,
	[CityFrench] [nvarchar](50) NOT NULL ,
	[CityEnglish][nvarchar](50) NOT NULL ,
	[CountryFrench] [nvarchar](50) NOT NULL,
	[CountryEnglish][nvarchar](50) NOT NULL,
)



DROP TABLE IF EXISTS [dbo].[DimShipper];
CREATE TABLE [dbo].[DimShipper](
	[ShipperId] [int] NOT NULL IDENTITY(0,1) PRIMARY KEY,
	[ShipperDBId] [int] NOT NULL,
	[CompanyName] [nvarchar](40) NOT NULL,
)




DROP TABLE IF EXISTS [dbo].[DimCustomer];
CREATE TABLE [dbo].[DimCustomer](
	[CustomerId] [int] NOT NULL IDENTITY(0,1) PRIMARY KEY,
	[CustomerDBId] [nchar](5) NOT NULL,
	[CompanyName] [nvarchar](40) NOT NULL,
	[ContactName] [nvarchar](30)NOT NULL ,
	[CityFrench] [nvarchar](50) NOT NULL  ,
	[CityEnglish][nvarchar](50) NOT NULL  ,
	[CountryFrench] [nvarchar](50) NOT NULL  ,
	[CountryEnglish][nvarchar](50) NOT NULL  ,
)




DROP TABLE IF EXISTS [dbo].[DimProduct];
CREATE TABLE [dbo].[DimProduct](
	[ProductId] [int] NOT NULL IDENTITY(0,1) PRIMARY KEY,
	[ProductDBId] [int] NOT NULL, 
	[ProductName] [nvarchar](40),
	[CategoryNameFrench] [nvarchar](30) NOT NULL,
	[CategoryNameEnglish] [nvarchar](15) NOT NULL,
	[UnitPrice][money] NOT NULL ,
	[QuantityPerUnit][nvarchar](20)NOT NULL ,
)

DROP TABLE IF EXISTS [dbo].[FactSales];
CREATE TABLE [dbo].[FactSales](
	[SaleId] [int] NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[OrderId] [int] NOT NULL,
	[ProductId] [int] FOREIGN KEY REFERENCES [dbo].[DimProduct](ProductId),
	[CustomerId] [int] FOREIGN KEY REFERENCES [dbo].[DimCustomer](CustomerId),
	[EmployeeId] [int] FOREIGN KEY REFERENCES [dbo].[DimEmployee](EmployeeId),
	[ShipperId] [int] FOREIGN KEY REFERENCES [dbo].[DimShipper](ShipperId),
	[SupplierId] [int] FOREIGN KEY REFERENCES [dbo].[DimSupplier](SupplierId),
	[OrderDateKey] [int] FOREIGN KEY REFERENCES [dbo].[DimDate](DateKey),
	[RequiredDateKey] [int] FOREIGN KEY REFERENCES [dbo].[DimDate](DateKey),
	[ShippedDateKey] [int] FOREIGN KEY REFERENCES [dbo].[DimDate](DateKey),
	[Freight] [money] NOT NULL,
	[Total] [money] NOT NULL,
	[Discount] [real] NOT NULL,
	[Quantity] [smallint] NOT NULL,
	[isOnline] [bit] NOT NULL,
)

/*
INSERT INTO  [dbo].[DimDate]
VALUES (0, 'Non défini','Not Available','Non défini','Not Available', 0, 0, 0)

INSERT INTO  [dbo].[DimEmployee] 
VALUES (0, 'Inconnu/Unknown','Inconnu/Unknown', 'Inconnu', 'Unknown','Inconnue','Unknown','Inconnu', 'Unknown')

INSERT INTO  [dbo].[DimSupplier]
VALUES (0, 'Inconnu/Unknown', 'Inconnue','Unknown','Inconnu', 'Unknown')

INSERT INTO  [dbo].[DimShipper]
VALUES (0, 'Inconnu/Unknown')

INSERT INTO  [dbo].[DimCustomer]
VALUES ('00000', 'Inconnu/Unknown', 'Inconnu/Unknown','Inconnue', 'Unknown', 'Inconnu', 'Unknown')

INSERT INTO  [dbo].[DimProduct]
VALUES (0, 'Inconnu/Unknown', 'Inconnu', 'Unknown', 0, 'Inconnu/Unknown')
*/