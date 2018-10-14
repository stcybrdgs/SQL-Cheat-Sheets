-- MySQL REFRESHER 
-- sets 1-10

-- ///////////////////////////////////////////
-- SELECT w/arithmetic operators and concept that NULL is not a value 
SELECT COUNT(*) AS "Tot # Rows", COUNT(LifeExpectancy) AS "# LE Rows", (COUNT(*) - COUNT(LifeExpectancy)) AS "Diff" FROM Country;

-- use SELECT with OFFSET and LIMIT to pull a specific range; rem: syntax puts LIMIT and OFFSET at the end of the statement 
SELECT Name, Region AS Reg, Continent AS Cont From Country ORDER BY Name DESC LIMIT 5 OFFSET 5;

-- use AS to create a custom column in the results table
SELECT COUNT() AS "# of Rows" FROM Country;

-- use conditions to restrict content in the results table
SELECT Name, Continent, Region FROM Country WHERE Continent = 'Europe';
SELECT Name, Continent, Region FROM Country WHERE Continent = 'Europe' AND Population > 1000000;
SELECT COUNT(*) FROM Country WHERE Population > 1000000 AND Continent = 'Europe';

-- return names of all tables in the local database
SELECT name FROM sqlite_master WHERE type='table';

-- use UPDATE and INSERT to add rows to an existing table
UPDATE customer SET address = '123 Guitar Street' WHERE id =5;
INSERT INTO customer (name, address, city, state, zip) VALUES ('Stacy Bridges', '604 Country Aire Dr', 'Round Rock', 'TX', '78664');
SELECT * FROM customer;

-- ///////////////////////////////////////////
-- USING CREATE, INSERT, DELETE
-- rem syntax requires: ( colName dataType, colName dataType, ... )
CREATE TABLE books(
 Title TEXT,
 Author TEXT,
 Year INTEGER 
);

-- populate new table with values
INSERT INTO books VALUES('Stacy', 'Book One', 2018);
INSERT INTO books VALUES('Tobey', 'SciFi Thriller', 2018);
SELECT * FROM books;

-- use DELETE FROM to remove rows from the target table
DELETE FROM books WHERE Author = 'Stacy'

-- use DROP TABLE to delete a table from the local database
DROP TABLE IF EXISTS books;
SELECT * FROM books;

-- use DELETE to remove rows from existing table
DELETE FROM customer WHERE id > 7;
DELETE FROM customer WHERE id = 3;

-- use UPDATE and SET to modify data in existing row
UPDATE customer SET name ='0',address = '0' WHERE id = 7;

-- use nested SELECT to copy info from neighboring row into target row
UPDATE customer SET name = 'Jazz Winston', address = (SELECT address FROM customer WHERE id = 6) WHERE id = 7;
SELECT * FROM customer;

-- ///////////////////////////////////////////
-- USING CREATE AND ALTER
-- Remember that NULL is not a value, it is the lack of a value
-- CREATE and INSERT
CREATE TABLE test3(
 a INTEGER NOT NULL, -- NULL constraint
 b TEXT NOT NULL,    -- NULL constraint
 c TEXT              -- may be NULL
);
INSERT INTO test3 VALUES ( 1, 'this', 'that');
SELECT * FROM test3;

-- CREATE and INSERT
SELECT name FROM sqlite_master WHERE type='table';
CREATE TABLE test1 ( a TEXT, b TEXT, c TEXT );
INSERT INTO test1 VALUES ( 'one', 'four', 'seven' );
INSERT INTO test1 VALUES ( 'two', 'five', 'eight' );
INSERT INTO test1 VALUES ( 'three', 'six', 'nine' );

-- use ALTER TABLE to add columns to an existing database:
ALTER TABLE test1 ADD d TEXT;
ALTER TABLE test1 ADD e TEXT;
SELECT * FROM test1;

-- ///////////////////////////////////////////
-- USING BOOLEAN EXPRESSIONS
-- use AND, OR to combine Boolean expressions together
SELECT Name, Continent, Population
FROM Country
WHERE Population < 100000 -- Boolean expression evaluates as either T or F
OR Population IS NULL     -- OR is a Boolean operator that combines Boolean expressions together
ORDER BY Population DESC;

SELECT Name, Continent, Population
FROM Country
WHERE Population < 100000 -- Boolean expression evaluates as either T or F
AND Continent = 'Oceania' -- AND is also a Boolean operator
ORDER BY Population DESC;
