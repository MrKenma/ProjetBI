USE master
GO
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'BlablaCoSalesDB')
CREATE DATABASE [BlablaCoSalesDB]
GO
ALTER DATABASE [BlablaCoSalesDB] SET QUERY_STORE=ON
GO

USE [BlablaCoSalesDB]
GO

DROP TABLE IF EXISTS [dbo].[FactSales];
DROP TABLE IF EXISTS [dbo].[DimDate];
DROP TABLE IF EXISTS [dbo].[DimProduct];
DROP TABLE IF EXISTS [dbo].[DimCustomer];
DROP TABLE IF EXISTS [dbo].[DimEmployee];
DROP TABLE IF EXISTS [dbo].[DimShipper];
GO

CREATE TABLE [DimDate] (
	[DateID] INT PRIMARY KEY,
	[Year] INT NOT NULL,
	[Month] INT NOT NULL,
	[Week] INT NOT NULL,
	[DayOfMonth] INT NOT NULL,
	[MonthEnglishName] NVARCHAR(15) NOT NULL,
	[MonthFrenchName] NVARCHAR(15) NOT NULL,
	[DayEnglishName] NVARCHAR(15) NOT NULL,
	[DayFrenchName] NVARCHAR(15) NOT NULL
)
GO

CREATE TABLE [DimProduct] (
	[ProductID] INT PRIMARY KEY IDENTITY (1, 1),
	[ProductAltID] INT NOT NULL,
	[ProductName] NVARCHAR(50) NOT NULL,
	[CategoryFrenchName] NVARCHAR(50) NOT NULL,
	[CategoryEnglishName] NVARCHAR(20) NOT NULL,
)
GO

CREATE TABLE [DimCustomer] (
	[CustomerID] INT PRIMARY KEY IDENTITY (1, 1),
	[CustomerAltID] NCHAR(5) NOT NULL,
	[CompanyName] NVARCHAR(40) NOT NULL,
	[CountryFrench] NVARCHAR(50) NOT NULL,
	[CountryEnglish] NVARCHAR(50) NOT NULL,
	[CityFrench] NVARCHAR(50) NOT NULL,
	[CityEnglish] NVARCHAR(50) NOT NULL
)
GO

CREATE TABLE [DimEmployee] (
	[EmployeeID] INT PRIMARY KEY IDENTITY (1, 1),
	[EmployeeAltID] INT NOT NULL,
	[FirstName] NVARCHAR(10) NOT NULL,
	[LastName] NVARCHAR(20) NOT NULL
)
GO

CREATE TABLE [DimShipper] (
	[ShipperID] INT PRIMARY KEY IDENTITY (1, 1),
	[ShipperAltID] INT NOT NULL,
	[CompanyName] NVARCHAR(40) NOT NULL
)
GO

CREATE TABLE [dbo].[FactSales] (
	[OrderIDKEY] INT NOT NULL,
	[ProductIDKEY] INT NOT NULL,
	[DBName] NCHAR(15) NOT NULL,
	[ProductID] INT FOREIGN KEY REFERENCES dimProduct(productID),
	[CustomerID] INT FOREIGN KEY REFERENCES dimCustomer(customerID),
	[EmployeeID] INT FOREIGN KEY REFERENCES dimEmployee(employeeID),
	[ShipperID] INT FOREIGN KEY REFERENCES dimShipper(shipperID),
	[ShippedDateID] INT FOREIGN KEY REFERENCES dimDate(dateID),
	[OrderDateID] INT FOREIGN KEY REFERENCES dimDate(dateID),
	[UnitPrice] MONEY NOT NULL,
	[Quantity] SMALLINT NOT NULL,
	[Discount] REAL NOT NULL,
	[IsOnline] BIT NOT NULL,
	CONSTRAINT PK_OrderDetails PRIMARY KEY (OrderIDKEY, ProductIDKEY, DBName)
)
GO
