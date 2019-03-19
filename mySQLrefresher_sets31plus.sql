-- mySQL REFRESHER
-- sets 31 +

-- SSMS transformations for Northwind Data Set
-- CREATE new test table
CREATE TABLE MyAddress(
 DelAddress TEXT
);
UPDATE MyAddress SET DelAddress = (SELECT ShipAddress FROM Orders) WHERE 
SELECT ShipAddress FROM Orders

-- CREATE mock-up of target joined table
-- ie, joining the Northwind tables Orders and [Order Details]
CREATE TABLE Orders_OrderDetails(
    CustomerID nchar(5),
	OrderDate datetime,
	ShipCity nvarchar(15),
	ShipRegion nvarchar(15),
	ShipCountry nvarchar(15),
	ProductID int,
	UnitPrice money,
	Qty smallint,
	Discount real
);

-- INSERTS for Northwind mock-up table
SELECT * INTO Orders_OrderDetails2 
FROM(
	SELECT 
	-- o
	o.OrderID as OrderID, o.CustomerID as CustomerID, o.OrderDate as OrderDate, o.ShipCity as ShipCity, 
	o.ShipRegion as ShipRegion, o.ShipCountry as ShipCountry,
	-- od
	od.ProductID as ProductID, od.UnitPrice as UnitPrice, 
	od.Quantity as Qty, od.Discount as Discount
	FROM Orders AS o
	JOIN [Order Details] as od
	ON o.OrderID = od.OrderID
)

-- JOIN Orders to [Order Details]
-- while creating inferred data columns for Fiscal Qtr
SELECT o.CustomerID as CustomerID, 	   
       FORMAT(o.OrderDate, 'yyyy') as OrderYear,
       CASE 
	       WHEN FORMAT(o.OrderDate, 'MM') in (1,2,3) THEN 'Q1'
		   WHEN FORMAT(o.OrderDate, 'MM') in (4,5,6) THEN 'Q2'
		   WHEN FORMAT(o.OrderDate, 'MM') in (7,8,9) THEN 'Q3'
		   WHEN FORMAT(o.OrderDate, 'MM') in (10,22,12) THEN 'Q4'
	   END AS FiscalQuarter,
	   ROUND(SUM(od.UnitPrice * od.Quantity),2) AS TotalPurchase 
FROM Orders as o
JOIN [Order Details] as od
ON o.OrderID = od.OrderID
GROUP BY o.CustomerID, 
         FORMAT(o.OrderDate, 'yyyy'), 
		 CASE 
	       WHEN FORMAT(o.OrderDate, 'MM') in (1,2,3) THEN 'Q1'
		   WHEN FORMAT(o.OrderDate, 'MM') in (4,5,6) THEN 'Q2'
		   WHEN FORMAT(o.OrderDate, 'MM') in (7,8,9) THEN 'Q3'
		   WHEN FORMAT(o.OrderDate, 'MM') in (10,22,12) THEN 'Q4'
	     END
ORDER BY TotalPurchase DESC;

