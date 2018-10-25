/*
  MERGE Exercise in SQL Server Management Studio (SSMS):
  Create a temporary table of Customer updates 
  and merge it into the existing Customers table
*/
-- switch to the H+Active database
USE [H+Active];

-- create a new table to hold only the fields that
-- are to be updated in the target table (ie, the Customers table)
CREATE TABLE CustomerUpdates (
    CustomerID int NOT NULL,
    FirstName nvarchar(50),
    LastName nvarchar(50),
    Phone nchar(13),
    Address nvarchar(255),
    City nvarchar(50),
    State nchar(2),
    Zip nchar(5)
);
GO

-- populate the updates table with the data that is to be
-- updated into the Customers table
INSERT INTO CustomerUpdates (CustomerID, Address, City, State, Zip)
VALUES  (10051,'4515 West Elm','Newark','NJ','07102');
INSERT INTO CustomerUpdates (CustomerID, LastName)
VALUES  (10054,'Piper');
INSERT INTO CustomerUpdates (CustomerID, Phone)
VALUES  (10053,'(555)555-5555');
INSERT INTO CustomerUpdates
VALUES  (10066,'Elizabeth','Janson','(555)413-2094','1214 Barkley St','Tampa','FL','33601')

-- take a look at the updates and make sure they're correct
SELECT *
FROM CustomerUpdates;

-- BEGIN MERGE ///////////////////////////////////////////////
-- when IDs match and there's a FirstName in the updates table
-- then copy it into the target table
MERGE Customers
USING CustomerUpdates
ON Customers.CustomerID = CustomerUpdates.CustomerID
WHEN MATCHED AND
  CustomerUpdates.FirstName IS NOT NULL THEN
  UPDATE
  SET Customers.FirstName = CustomerUpdates.FirstName;

-- when IDs match and there's a LastName in the updates table
-- then copy it into the target table
MERGE Customers
USING CustomerUpdates
ON Customers.CustomerID = CustomerUpdates.CustomerID
WHEN MATCHED AND
  CustomerUpdates.LastName IS NOT NULL THEN
  UPDATE
  SET Customers.LastName = CustomerUpdates.LastName;

-- when IDs match and there's a Phone in the updates table
-- then copy it into the target table
MERGE Customers
USING CustomerUpdates
ON Customers.CustomerID = CustomerUpdates.CustomerID
WHEN MATCHED AND
  CustomerUpdates.Phone IS NOT NULL THEN
  UPDATE
  SET Customers.Phone = CustomerUpdates.Phone;

-- when IDs match and there's an Address in the updates table
-- then copy it into the target table
MERGE Customers
USING CustomerUpdates
ON Customers.CustomerID = CustomerUpdates.CustomerID
WHEN MATCHED AND
  CustomerUpdates.Address IS NOT NULL THEN
  UPDATE
  SET Customers.Address = CustomerUpdates.Address;

-- when IDs match and there's a City in the updates table
-- then copy it into the target table
MERGE Customers
USING CustomerUpdates
ON Customers.CustomerID = CustomerUpdates.CustomerID
WHEN MATCHED AND
  CustomerUpdates.City IS NOT NULL THEN
  UPDATE
  SET Customers.City = CustomerUpdates.City;

-- when IDs match and there's a State in the updates table
-- then copy it into the target table
MERGE Customers
USING CustomerUpdates
ON Customers.CustomerID = CustomerUpdates.CustomerID
WHEN MATCHED AND
  CustomerUpdates.State IS NOT NULL THEN
  UPDATE
  SET Customers.State = CustomerUpdates.State;

-- when IDs match and there's a ZIP in the updates table
-- then copy it into the target table
MERGE Customers
USING CustomerUpdates
ON Customers.CustomerID = CustomerUpdates.CustomerID
WHEN MATCHED AND
  CustomerUpdates.ZIP IS NOT NULL THEN
  UPDATE
  SET Customers.ZIP = CustomerUpdates.ZIP;
  
-- when there is no ID match, then copy the entire record
-- from the updates table into the target table
MERGE Customers
USING CustomerUpdates
ON Customers.CustomerID = CustomerUpdates.CustomerID
WHEN NOT MATCHED BY TARGET THEN
  INSERT (FirstName, LastName, Phone, Address, City, State, Zip)
  VALUES (CustomerUpdates.FirstName, CustomerUpdates.LastName, CustomerUpdates.Phone, CustomerUpdates.Address, CustomerUpdates.City, CustomerUpdates.State, CustomerUpdates.Zip);
