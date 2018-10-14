-- MySQL REFRESHER 
-- sets 11-20

-- ///////////////////////////////////////////
-- USING LIKE, IN, DISTINCT, MAX, MIN
-- There are two unique operators in SQL for filtering results: LIKE and IN
-- Q1
SELECT Name, Continent, Population
FROM Country
WHERE name LIKE '%island%'
ORDER BY Name;
-- Q2
SELECT Name, Continent, Population
FROM Country
WHERE Continent IN ( 'Europe', 'Asia' )
ORDER BY Name;

-- If you want to know the different values that exist in a column,
-- without duplication, use SELECT DISTINCT
SELECT * FROM Country LIMIT 1;
SELECT DISTINCT Continent FROM Country;
SELECT DISTINCT Region FROM Country;

-- Technique for getting the MAX or MIN of a particular value:
SELECT Name, SurfaceArea FROM Country ORDER BY SurfaceArea ASC LIMIT 1;  -- smallest area of land
SELECT Name, SurfaceArea FROM Country ORDER BY SurfaceArea DESC LIMIT 1; -- largest area of land

-- ///////////////////////////////////////////
-- USING ORDER BY
-- Examples of using ORDER BY to sort different column combinations:
SELECT Name, Continent 
FROM Country 
ORDER BY Continent, Name;

SELECT Name, Continent, Region 
FROM Country 
ORDER BY Continent DESC, Region, Name;

-- Examples of using ORDER BY to sort different column combinations:
SELECT Name, Continent 
FROM Country 
ORDER BY Continent, Name;

SELECT Name, Continent, Region 
FROM Country 
ORDER BY Continent DESC, Region, Name;

-- ///////////////////////////////////////////
-- USING CASE WHEN
-- use CASE WHEN to test cell against a value:
SELECT 
 CASE WHEN a = 1 THEN 'small'
        WHEN a < 1 THEN 'tiny'
        WHEN a > 1 AND a < 3 THEN 'medium'
        ELSE 'large' END as testA,
 CASE WHEN b = 1 THEN 'small'
        WHEN a < 1 THEN 'tiny'
        WHEN b > 1 AND b < 3 THEN 'medium'
        ELSE 'large' END as testB
 FROM booltest
;

-- ///////////////////////////////////////////
-- USING JOINS WITH ALIASES
-- widgetCustomer: item_id, customer_id, date, price, quantity
-- widgetLog:      item_id, customer_id, quan, price, stamp
UPDATE right SET id = 4 WHERE id = 6;
SELECT * FROM left;
SELECT * FROM right;
SELECT 
  l.id AS l_id, l.description AS l_val, 
  r.id AS r_id, r.description AS r_val,
  l.id - r.id AS offset
FROM left AS l
JOIN right AS r
ON l.description = r.description
;

SELECT * FROM sale;
SELECT * FROM item;
SELECT s.customer_id AS customerID, s.quantity, s.date, i.name AS itemName
FROM sale AS s
JOIN item as i  
ON s.item_id = i.id
ORDER BY customerID, date;

-- widgetCustomer: item_id, customer_id, date, price, quantity
-- widgetLog:      item_id, customer_id, quan, price, stamp
-- SELECT name from sqlite_master WHERE type='table';
SELECT * FROM customer;
SELECT * FROM sale;
SELECT * FROM item;

-- ///////////////////////////////////////////
-- USING STRING FUNCTIONS
-- A string literal:
SELECT 'this here''s a literal' AS myLiteral;

-- Concatenation in standard SQL:
SELECT name || ' / ' || city AS 'Name / City' FROM customer;
SELECT 'this' || ' & ' || 'that' as myLiteral;

-- Concatenation in MySQL:
SELECT CONCAT('This', ' & ', 'that');

-- Concatenation in MS SQL Server:
SELECT 'This' + ' & ' + 'that';

-- Other types of String functions
-- (remember see your system documentation)
SUBSTR( string, start, length );
LENGTH( string );
TRIM( string );
UPPER( string );
LOWER( string );

SELECT SUBSTR('this string', 6);
SELECT SUBSTR('this string', 6, 3);
SELECT title, artist,
 SUBSTR( released, 1, 4 ) AS year,
 SUBSTR( released, 6, 2 ) AS month,a
 SUBSTR( released, 9, 2 ) AS day
FROM album
ORDER BY released;

-- ///////////////////////////////////////////
-- USING DATE/TIME FUNCTIONS
-- :memory:
SELECT DATETIME('now');
SELECT DATE('now');
SELECT TIME('now');
SELECT DATETIME('now', '+1 day');
SELECT DATETIME('now', '+3 days');
SELECT DATETIME('now', '-1 month');
SELECT DATETIME('now', '+1 year');
SELECT DATETIME('now', '+3 hours', '+27 minutes', '-1 day', '+3 years');
SELECT DATETIME('now', '+27 minutes', '+3 hours', '+3 years', '-1 day');

