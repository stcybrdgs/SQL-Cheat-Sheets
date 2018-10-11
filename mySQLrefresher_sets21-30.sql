-- MySQL REFRESHER 
-- sets 21-30


-- ///////////////////////////////////////////
-- SELECT name FROM sqlite_master where type='table';
-- SELECT * FROM album LIMIT 1;
-- SELECT * FROM track LIMIT 1;
-- Album         |  Tracks
-- Kind of Blue  |  5
SELECT a.title AS Album, COUNT(t.track_number) as Tracks 
FROM album AS a
JOIN track AS t
ON a.id=t.album_id
GROUP BY a.id
ORDER BY Tracks DESC, Album;


--|  Album         |  Tracks
--|  Kind of Blue  |  5
-- SELECT * FROM album LIMIT 10;
-- SELECT * FROM track LIMIT 1;
-- This query shows how to use WHERE and HAVING in the same query
-- Note that the WHERE clause comes after JOIN and before GROUP BY 
-- and the HAVING clause comes after GROUP BY
-- so that the WHERE clause operates on data before the aggregation
-- and the HAVING clause operates on data after the aggregation

SELECT a.title AS Album, COUNT(t.track_number) AS Tracks
FROM album AS a
JOIN track AS t
ON a.id = t.album_id
WHERE a.artist = "The Beatles"
GROUP BY a.title
HAVING Tracks >= 10
ORDER BY Tracks DESC, Album;

-- Common aggregate functions:
SELECT Region,
       AVG(Population) AS avgPopulation,
       MIN(Population) AS minPopulation,
       MAX(Population) AS maxPopulation,
       SUM(Population) AS sumPopulation
FROM Country 
GROUP BY Region ORDER BY sumPopulation DESC;


-- ///////////////////////////////////////////
-- Nested Queries
-- use a nested query to create a 'sub-select' 
-- (rem: the result of a SELECT statement is a table that may be used like any db table)
-- here, create a table with packed data for state and country codes:
CREATE TABLE t ( a TEXT, b TEXT );
INSERT INTO t VALUES ( 'NY0123', 'US4567' );
INSERT INTO t VALUES ( 'AZ9437', 'GB1234' );
INSERT INTO t VALUES ( 'CA1279', 'FR5678' );
SELECT * FROM t;

-- next, use SUBSTR() functions to unpack the data from the table:
SELECT SUBSTR(a, 1, 2) AS State, SUBSTR(a, 3) AS SCode, 
       SUBSTR(b, 1, 2) AS Country, SUBSTR(b, 3) AS CCode FROM t;

-- next, turn the previous query into a 'sub-select' 
-- pull Name from Country table and CCode from sub-select table
SELECT co.Name, ss.CCode FROM(
  SELECT SUBSTR(a, 1, 2) AS State, SUBSTR(a, 3) AS SCode, 
         SUBSTR(b, 1, 2) AS Country, SUBSTR(b, 3) AS CCode FROM t
  ) AS ss
JOIN Country AS co 
ON co.Code2 = ss.Country;


-- ///////////////////////////////////////////
-- two techniques to get a list of albums with tracks where duration <= 90;
--
-- Technique # 1
SELECT a.title AS Album, t.track_number AS TrkNum, t.title AS Track, t.duration AS Secs
FROM album AS a
JOIN track AS t 
ON a.id = t.album_id
WHERE t.duration < 90
ORDER BY Album, Track;
--
-- Technique # 2 (use nested query)
SELECT a.title AS Album, t.track_number AS TrkNum, t.title AS Track, t.duration AS Secs
FROM album AS a
JOIN (
  SELECT album_id, track_number, duration, title
  FROM track
  WHERE duration <= 90 
) AS t
ON a.id = t.album_id
ORDER BY a.title, t.track_number;



