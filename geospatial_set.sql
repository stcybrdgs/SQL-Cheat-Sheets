/*
  GEOSPATIAL SET
  here, we're working with SQL Server on:
  *  lattitude / longitude
  *  geography as data type
  *  the internal spatial reference system
  * claculating distances based on geospatial info
*/

-- crete small table to hold lattitude, longitude, and geography data
USE [H+Active];
CREATE TABLE Locations (
    City varchar(50),
    Lat float,
    Lon float,
    Geo geography
);
GO

-- insert some lattitude / longitude data
INSERT INTO Locations (City, Lat, Lon)
VALUES  ('Carpinteria', 34.398, -119.518),
        ('New York', 40.71, -74.005);
GO

-- convert lattitude and longitude to geography set using internal spatial ref system
UPDATE Locations
SET Geo = GEOGRAPHY::Point(Lat, Lon, 4326);

-- check out the spatial ref system and the 4326 record
Select * from sys.spatial_reference_systems;
Select * from sys.spatial_reference_systems WHERE spatial_reference_id = 4326;

-- create geography variables based on spatial conversion
-- for use in calculating distance
DECLARE @c geography;
DECLARE @n geography;
SET @c = (SELECT Geo FROM Locations WHERE City = 'Carpinteria');
SET @n = (SELECT Geo FROM Locations WHERE City = 'New York');

-- calculate distance
SELECT @c.STDistance(@n) as [Distance in Meters], @c.STDistance(@n)*0.0006213712 as [Distance in Miles];