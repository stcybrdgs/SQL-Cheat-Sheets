-- SQL REFRESHER w/ MySQL | Apache (see XAMP installation /SID/sid.php) 

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

SELECT name FROM sqlite_master WHERE type='table';
SELECT * FROM customer;
UPDATE customer SET address = '123 Guitar Street' WHERE id =5;
INSERT INTO customer (name, address, city, state, zip) VALUES ('Stacy Bridges', '604 Country Aire Dr', 'Round Rock', 'TX', '78664');
DELETE FROM customer WHERE id > 7;
UPDATE customer SET name ='0',address = '0' WHERE id = 7;
SELECT * FROM customer;

UPDATE customer SET name = 'Jazz Winston', address = (SELECT address FROM customer WHERE id = 6) WHERE id = 7;

DELETE FROM customer WHERE id = 3;

SELECT * FROM customer;

CREATE TABLE test (
 a INTEGER, -- col 1, data type
 b TEXT -- col 2, data type
);

INSERT INTO test VALUES ( 1, 'a' );

INSERT INTO test VALUES ( 2, 'b' );

INSERT INTO test VALUES ( 3, 'c' );

SELECT * FROM test;

CREATE TABLE books(
 Title TEXT,
 Author TEXT,
 Year INTEGER 
);
INSERT INTO books VALUES('Stacy', 'Book One', 2018);
INSERT INTO books VALUES('Tobey', 'SciFi Thriller', 2018);
SELECT * FROM books;

CREATE TABLE books(
 Author TEXT,
 Title TEXT,
 Year INTEGER 
);
INSERT INTO books VALUES('Stacy', 'Book One', 2018);
INSERT INTO books VALUES('Tobey', 'SciFi Thriller', 2018);
SELECT * FROM books;
SELECT * FROM books WHERE Author = 'Stacy';
DROP TABLE IF EXISTS books;
SELECT * FROM books;

-- CREATE TABLE test2 ( a INTEGER, b TEXT, c TEXT );
-- INSERT INTO test2 VALUES( 1, 'This', 'is it!' );
-- INSERT INTO test2 VALUES( 2, 'Check', 'it out!' );
-- SELECT * FROM test2;
-- INSERT INTO test2 (a, c) VALUES ( 120, 'to town!' );
-- INSERT INTO test2 DEFAULT VALUES; -- insert null cells
-- SELECT name FROM sqlite_master WHERE type='table';
-- INSERT INTO test2 ( a, b, c ) SELECT id, name, description FROM item;
-- DELETE FROM test2 WHERE a = 13 AND ( b = 'This' OR b = 'Check' );
-- DELETE FROM test2 WHERE c IS NULL;
SELECT * FROM test2;

-- Remember that NULL is not a value, it is the lack of a value
CREATE TABLE test3(
 a INTEGER NOT NULL, -- NULL constraint
 b TEXT NOT NULL,    -- NULL constraint
 c TEXT              -- may be NULL
);
INSERT INTO test3 VALUES ( 1, 'this', 'that');
SELECT * FROM test3;

SELECT name FROM sqlite_master WHERE type='table';
CREATE TABLE test1 ( a TEXT, b TEXT, c TEXT );
INSERT INTO test1 VALUES ( 'one', 'four', 'seven' );
INSERT INTO test1 VALUES ( 'two', 'five', 'eight' );
INSERT INTO test1 VALUES ( 'three', 'six', 'nine' );
use ALTER TABLE to add columns to an existing database:
ALTER TABLE test1 ADD d TEXT;
ALTER TABLE test1 ADD e TEXT;
SELECT * FROM test1;

SELECT Name, Continent, Population
FROM Country
WHERE Population < 100000 -- BOOLEAN expression evaluates as either T or F
OR Population IS NULL     -- OR is a BOOLEAN operator that BOOLEAN expressions together
ORDER BY Population DESC;

SELECT Name, Continent, Population
FROM Country
WHERE Population < 100000 -- BOOLEAN expression evaluates as either T or F
AND Continent = 'Oceania' -- AND is also a BOOLEAN operator
ORDER BY Population DESC;
