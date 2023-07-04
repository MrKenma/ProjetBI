USE DataWarehouse;

WITH Products AS (     
	SELECT ProductID, SUM(Quantity) as TotalQuantity     
	FROM FactSales     
	WHERE IsOnline = 1     
	GROUP BY ProductID 
)  

SELECT TOP 5 DimProduct.ProductName, Products.TotalQuantity 
FROM Products 
JOIN DimProduct ON DimProduct.ProductId = Products.ProductID 
ORDER BY Products.TotalQuantity DESC

---------------------------------------------------------------

WITH CommercialSales AS (
	SELECT SUM(Total) as ComTotal
	FROM FactSales
	JOIN DimDate ON FactSales.OrderDateKey = DimDate.DateKey
	WHERE isOnline = 1 AND DimDate.Year BETWEEN 1996 AND 1997
),

OnlineSales AS (
	SELECT SUM(Total) as OnlineTotal
	FROM FactSales
	JOIN DimDate ON FactSales.OrderDateKey = DimDate.DateKey
	WHERE isOnline = 0 AND DimDate.Year BETWEEN 1996 AND 1997
)

SELECT 
	(SELECT OnlineTotal FROM OnlineSales) as OnlineTot,
	(SELECT ComTotal FROM CommercialSales) as CommercialTot


