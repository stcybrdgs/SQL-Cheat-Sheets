/*
**  Understanding Transactions
**  When you make changes to to your data, SQL Server can keep track of your changes that you make
**  so that you can undo them if you need to... but only if you remember to wrap your changes in a transaction
*/


-- ///////////////////////////////////////
-- In this simple example, you may highlight and execute the BEGIN TRAN statement and start logging your activity;
-- afterward, you may either ROLLBACK or COMMIT any changes that you make
USE [H+Active];

-- return customers who haven't bought anything
SELECT CustomerID
FROM Customers
EXCEPT
SELECT CustomerID
FROM Invoices;

-- start a transaction and delete a customer
BEGIN TRAN
DELETE FROM Customers
WHERE CustomerID = 10054

-- delete all customers who haven't bought anything
DELETE FROM Customers 
WHERE CustomerID IN (
	SELECT CustomerID
	FROM Customers
	EXCEPT
	SELECT CustomerID
	FROM Invoices
)

-- review the result set
SELECT * FROM Customers

-- to undo the delete:
ROLLBACK

-- to finalize the delete:
COMMIT
