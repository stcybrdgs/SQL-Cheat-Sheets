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