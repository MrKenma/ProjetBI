USE master
GO
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'BlablaCoSalesDB')
CREATE DATABASE [BlablaCoSalesDB]
GO
ALTER DATABASE [BlablaCoSalesDB] SET QUERY_STORE=ON
GO

USE [BlablaCoSalesDB]
GO

DROP TABLE IF EXISTS [dbo].[FactOrderDetails];
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
	[ProductName] NVARCHAR(40) NOT NULL,
	[CategoryFrenchName] NVARCHAR(20) NOT NULL,
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
	[LastName] NVARCHAR(20) NOT NULL,
	[FirstName] NVARCHAR(10) NOT NULL
)
GO

CREATE TABLE [DimShipper] (
	[ShipperID] INT PRIMARY KEY IDENTITY (1, 1),
	[ShipperAltID] INT NOT NULL,
	[CompanyName] NVARCHAR(40) NOT NULL
)
GO

CREATE TABLE [dbo].[FactOrderDetails] (
	[OrderID] INT NOT NULL,
	[ProductID] INT FOREIGN KEY REFERENCES dimProduct(productID) NOT NULL,
	[CustomerID] INT FOREIGN KEY REFERENCES dimCustomer(customerID) NOT NULL,
	[EmployeeID] INT FOREIGN KEY REFERENCES dimEmployee(employeeID) NOT NULL,
	[ShipperID] INT FOREIGN KEY REFERENCES dimShipper(shipperID) NOT NULL,
	[ShippedDate] INT FOREIGN KEY REFERENCES dimDate(dateID) NOT NULL,
	[OrderDate] INT FOREIGN KEY REFERENCES dimDate(dateID) NOT NULL,
	[UnitPrice] MONEY NOT NULL,
	[Quantity] SMALLINT NOT NULL,
	[Discount] REAL NOT NULL,
	[IsOnline] BIT NOT NULL,
	CONSTRAINT PK_OrderDetails PRIMARY KEY (OrderID, ProductID)
)
GO
