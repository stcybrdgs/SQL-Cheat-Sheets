/* MISCL Database Foundations Material in SSMS */


--//////////////////////////////////////////////////////////////////
/*
Rem: the use of brackets in SQL Server is meant to avoid errors on table names, db names, and fields
in case the string contains special characters or key words reserved by SQL. If there are no 
special characters or keywords in the strings, then the brackets are unnecessary. However, all of
your auto-generated code in SSMS will include the brackets as best practice.

Note that the following two SELECT statements are equivalent, although one uses brackets and the other does not.
*/
--
-- Example 1:
SELECT TOP 10 [EmployeeID]
      ,[FirstName]
      ,[LastName]
      ,[Position]
      ,[Email]
  FROM [H+Active].[dbo].[Employees]
-- 
-- Example 2:
USE [H+Active];
SELECT TOP 10 EmployeeID
      ,FirstName
      ,LastName
      ,Position
      ,Email
  FROM Employees;



--//////////////////////////////////////////////////////////////////
/*
  Drop and rebuild the Departments table in SSMS using T-SQL instead of GUI features
*/
USE [H+Active];

DROP TABLE [dbo].[Departments];

CREATE TABLE Departments (
	DepartmentID char(3) NOT NULL,
	DepartmentName char(30) NOT NULL,
	DepartmentHead INT NOT NULL,
	BuildingNumber SMALLINT NOT NULL,
	ModificationDate TIMESTAMP NOT NULL,
	CONSTRAINT PK_Departments PRIMARY KEY CLUSTERED (DepartmentID)
);

INSERT INTO Departments (
	DepartmentID, DepartmentName, DepartmentHead, BuildingNumber
)
VALUES('mkt', 'Marketing', 4, 3 );

ALTER TABLE Departments
ADD CONSTRAINT CK_BuildingNumber
CHECK (BuildingNumber >= 1 AND BuildingNumber <= 5);

CREATE UNIQUE INDEX IX_Departments ON Departments(DepartmentName);



--//////////////////////////////////////////////////////////////////
/*
  to find out if a record has a matching record in a related table (or not), use EXCEPT and INTERSECT
*/
-- Show all CustomerIDs that exist in both the
-- Customers table and the Invoices table
SELECT CustomerID 
FROM Customers
INTERSECT
SELECT CustomerID
FROM Invoices;

-- Show all CuatomerIDs that exist in the Customers table
-- but not in the Invoices table
-- (ie, show all customers who have not placed an order)
SELECT CustomerID 
FROM Customers
EXCEPT
SELECT CustomerID
FROM Invoices;

/*
  Remember you can use NOT whenever you want to exclude results;
  The following examples are equivalent
*/
 -- example with NOT
 SELECT * FROM Customers WHERE NOT State = 'FL';

-- example with <>
SELECT * FROM Customers WHERE State <> 'FL';



--//////////////////////////////////////////////////////////////////
/*
-- write a T-SQL query to create a view
-- to provide an aggregate function
-- that adds up the number of each product sold
*/
CREATE VIEW vwNumProductsSold
AS
SELECT	SUM(li.Quantity) AS Qty, pl.ProductID, pl.Item, pl.Description
FROM	LineItems AS li INNER JOIN
        Invoices ON li.InvoiceID = Invoices.InvoiceID INNER JOIN
        ProductOptions AS po ON li.OptionID = po.OptionID INNER JOIN
        ProductListing AS pl ON po.ProductID = pl.ProductID
GROUP BY pl.ProductID, pl.Item, pl.Description
ORDER BY Qty DESC



--//////////////////////////////////////////////////////////////////
/*
** use T-SQL to create a view to show which colors of items in the 
** product list have sold the most and which have sold the least
*/
-- CREATE VIEW AS vwMaxMinNumColorsSold
SELECT	po.Color, SUM(li.Quantity) AS Qty
FROM	ProductOptions AS po INNER JOIN
        LineItems AS li ON po.OptionID = li.OptionID INNER JOIN
        Invoices ON li.InvoiceID = Invoices.InvoiceID
GROUP BY po.Color
ORDER BY Qty DESC