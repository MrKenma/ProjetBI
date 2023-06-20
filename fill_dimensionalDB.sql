USE [BlablaCoSalesDB]
GO
DROP TABLE factOrderDetails;
DROP TABLE dimProduct;
DROP TABLE dimDate;
DROP TABLE dimCustomer;
DROP TABLE dimEmployee;
DROP TABLE dimShipper;
GO
CREATE TABLE [dimProduct] (
	[productID] INT PRIMARY KEY IDENTITY (1, 1),
	[productName] NVARCHAR(40) NOT NULL,
	[categoryName] NVARCHAR(15) NOT NULL
)
GO
CREATE TABLE [dimDate] (
	[dateID] INT PRIMARY KEY,
	[year] INT NOT NULL,
	[month] INT NOT NULL,
	[week] INT NOT NULL,
	[day] INT NOT NULL,
	[monthEnglishName] NVARCHAR(15) NOT NULL,
	[monthFrenchName] NVARCHAR(15) NOT NULL,
	[dayEnglishName] NVARCHAR(15) NOT NULL,
	[dayFrenchName] NVARCHAR(15) NOT NULL
)
GO
CREATE TABLE [dimCustomer] (
	[customerID] INT PRIMARY KEY IDENTITY (1, 1),
	[companyName] NVARCHAR(40) NOT NULL,
	[country] NVARCHAR(15) NOT NULL,
	[city] NVARCHAR(15) NOT NULL
)
GO
CREATE TABLE [dimEmployee] (
	[employeeID] INT PRIMARY KEY IDENTITY (1, 1),
	[lastName] NVARCHAR(20) NOT NULL,
	[firstName] NVARCHAR(10) NOT NULL
)
GO
CREATE TABLE [dimShipper] (
	[shipperID] INT PRIMARY KEY IDENTITY (1, 1),
	[companyName] NVARCHAR(40) NOT NULL
)
GO
CREATE TABLE [factOrderDetails] (
	[orderID] INT NOT NULL,
	[productID] INT FOREIGN KEY REFERENCES dimProduct(productID) NOT NULL,
	[customerID] INT FOREIGN KEY REFERENCES dimCustomer(customerID) NOT NULL,
	[employeeID] INT FOREIGN KEY REFERENCES dimEmployee(employeeID) NOT NULL,
	[shipperID] INT FOREIGN KEY REFERENCES dimShipper(shipperID) NOT NULL,
	[shippedDate] INT FOREIGN KEY REFERENCES dimDate(dateID) NOT NULL,
	[orderDate] INT FOREIGN KEY REFERENCES dimDate(dateID) NOT NULL,
	[unitPrice] MONEY NOT NULL,
	[quantity] SMALLINT NOT NULL,
	[discount] REAL NOT NULL,
	[isOnline] BIT NOT NULL,
	CONSTRAINT PK_OrderDetails PRIMARY KEY (orderID, productID)
)
GO