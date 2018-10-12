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


-- ///////////////////////////////////////////
-- in SQL, you can save your query as a VIEW and 
-- re-use that view as if it were a table

-- create the VIEW
CREATE VIEW trackView AS 
SELECT id, album_id, title, track_number, duration, duration/60 AS min, duration%60 AS s 
FROM track;
SELECT * FROM trackView;
SELECT name FROM sqlite_master WHERE type = 'view';

-- use the VIEW in a JOIN query
SELECT a.title AS Album, t.track_number AS TrkNum, t.title AS Track, t.duration AS Secs
FROM album AS a
JOIN trackView AS t 
ON a.id = t.album_id
WHERE t.duration < 90
ORDER BY Album, Track;

-- use the VIEW in a JOIN query with SUBSTR() to create MM:SS format in 'duration' column
SELECT a.title AS Album, t.track_number AS TrkNum, t.title AS Track, 
t.min || ':' || SUBSTR('00' || t.s, -2, 2) AS duration
FROM album AS a
JOIN trackView AS t 
ON a.id = t.album_id
-- WHERE t.duration < 90
ORDER BY Album, Track;

-- create a joined VIEW
CREATE VIEW joinedAlbum AS
SELECT a.artist AS artist,
       a.title AS album,
       t.title AS track,
       t.track_number AS trackno,
       t.duration / 60 AS m,
       t.duration % 60 AS s
FROM track AS t
JOIN album AS a
ON a.id = t.album_id;

-- use DROP to drop a VIEW just as you would with any table
DROP VIEW trackView;
DROP VIEW IF EXISTS trackView;
DROP VIEW joinedAlbum;
DROP VIEW IF EXISTS joinedAlbum;

-- simple JOIN without aliases
SELECT * FROM people JOIN states
ON people.state = states.state_abbrev
WHERE people.first_name LIKE 'j%'
AND states.region = 'South';

-- use LEFT (OUTER) JOIN to reveal state codes that 
-- do not exist in the people table
SELECT DISTINCT p.state AS PState, s.state_abbrev AS SState  
FROM states AS s
LEFT JOIN people AS p 
ON p.state = s.state_abbrev
ORDER BY PState;

-- create a view to aid in calculating % of contestants from each state
CREATE VIEW myView AS
SELECT state, COUNT(first_name) AS totalQPs
FROM people
GROUP BY state
ORDER BY totalQPs DESC;
-- calculate % of contestants from each state
SELECT state, totalQPs, (totalQPs/1000.0)*100 AS percent
FROM myView;

-- show which cities had 3 or more contestants that
-- scored the max number of quiz_points
SELECT city, COUNT(city) AS tot, state FROM people 
WHERE quiz_points = (SELECT MAX(quiz_points) FROM people)
GROUP BY city HAVING tot >= 3
ORDER BY tot DESC, state, city;



