/*
	Quick exercise in SSMS for new Practice database
*/

-- Remove and rebuild original table in SSMS using DDL
USE [Practice List];

DROP TABLE [Practice List];

CREATE TABLE PracticeList(
	TuneID int IDENTITY (1,1) NOT NULL,
	TuneName varchar(50) NOT NULL,
	TuneKey varchar(20) NOT NULL,
	Genre varchar(20),
	TuneStatus varchar(12),
	Duration time
);

SELECT * FROM [PracticeList];

-- Write an Alter statement to add a new column to the table
ALTER TABLE PracticeList
ADD Composer varchar(50);

-- Populate a row
INSERT INTO PracticeList (
	TuneName, 
	TuneKey, 
	Genre, 
	TuneStatus, 
	Duration, 
	Composer
	)
VALUES (
	'Misty',		-- TuneName
	'A Minor',		-- TuneL=Key
	'Jazz',			-- Genre
	'Finished',		-- TuneStatus
	'03:25:00',		-- Duration
	'Stacy'			-- Composer
	);

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