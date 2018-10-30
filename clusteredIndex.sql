/*
** This example code creates a "Clustered Index" on a table that doesn'e already have one. 
** However, SSMS automatically (default behavior) places a Clustered Index on 
** all of the PK fields in your tables, so identifying the PK when you create a new table
** is all you really need to do because SSMS will then create the Clustered Index for you
*/

-- create a new table 
CREATE TABLE ClusteredExample(
	ExampleID int,
	FirstName char(50)
);

-- create a Clustered Index on a field in the new table
CREATE CLUSTERED INDEX 
IX_ClusteredExample_ExampleID    -- name of index = IX_Table_Field
ON
ClusteredExample(ExampleID)      -- Table(Field)
;

-- retrieve the indexes that exist on the ClusteredExample table
USE [Practice List]
EXECUTE sp_helpindex ClusteredExample;
-- Result set:
-----------------------------------------------------------------------------------
-- index_name                     |  index_description             |  index_keys
-----------------------------------------------------------------------------------
-- IX_ClusteredExample_ExampleID  |  clustered located on PRIMARY  |  ExampleID
-----------------------------------------------------------------------------------

/*
** This example code creates a "Non-Clustered Index" on a table that doesn'e already have one. 
*/
-- use DDL commands to create a non-clustered index
-- appy the index to the State field within the Customers table
CREATE NONCLUSTERED INDEX IX_Customers_State
ON Customers(State);

USE [Practice List]
EXECUTE sp_helpindex Customers;

-- Result set:
-------------------------------------------------------------------------------------------------
-- IX_Customers_State  |  nonclustered located on PRIMARY                      |  State
-------------------------------------------------------------------------------------------------
-- LastName            |  nonclustered located on PRIMARY	                   |  LastName
-------------------------------------------------------------------------------------------------
-- PK_Customers	       |  clustered, unique, primary key located on PRIMARY	   |  CustomerID
-------------------------------------------------------------------------------------------------