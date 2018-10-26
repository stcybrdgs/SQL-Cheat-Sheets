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
