--Checking the data -- 5719877 rows detected
SELECT * 
FROM cyclistic2023;

SELECT DISTINCT ride_id
FROM cyclistic2023;      

--DATA CLEANING
--Duplicate Values found - 12
SELECT ride_id, COUNT(ride_id)
FROM cyclistic2023
GROUP BY ride_id
HAVING COUNT(ride_id) > 1;

WITH CTE AS
	(SELECT ride_id, ROW_NUMBER() OVER (PARTITION BY ride_id ORDER BY ride_id) AS ri
	FROM cyclistic2023)
DELETE FROM cyclistic2023
WHERE ride_id IN
		(SELECT ride_id FROM CTE WHERE ri > 1);

--CHECKING FOR THE CONSISTENCY OF STRINGS -- 255 rows were found
SELECT *, LENGTH(ride_id) AS str_length
FROM cyclistic2023
WHERE LENGTH(ride_id) <> 16;


DELETE FROM cyclistic2023
WHERE LENGTH(ride_id) <> 16;

--CHECKING THE DISTINCT rideable_type
SELECT DISTINCT rideable_type
FROM cyclistic2023;

--1388115 nulls were found
SELECT *
FROM cyclistic2023
WHERE started_at IS NULL OR ended_at IS NULL OR start_station_name IS NULL 
	  OR start_station_id IS NULL OR end_station_name IS NULL
	  OR end_station_id IS NULL OR start_lat IS NULL OR start_lng IS NULL
	  OR end_lat IS NULL OR end_lng IS NULL OR member_casual IS NULL;

--Deleting Nulls
DELETE FROM cyclistic2023
WHERE started_at IS NULL OR ended_at IS NULL OR start_station_name IS NULL 
	  OR start_station_id IS NULL OR end_station_name IS NULL
	  OR end_station_id IS NULL OR start_lat IS NULL OR start_lng IS NULL
	  OR end_lat IS NULL OR end_lng IS NULL OR member_casual IS NULL;

--DATA PROFILING - For the cleaned to 4331495
ALTER TABLE cyclistic2023
ADD COLUMN month text,
ADD COLUMN day text,
ADD COLUMN ride_length numeric;

UPDATE cyclistic2023
SET month = TO_CHAR(started_at, 'Month'),
	day = TO_CHAR(started_at, 'Day'),
	ride_length = EXTRACT(EPOCH FROM (ended_at - started_at));

ALTER TABLE cyclistic2023
ADD COLUMN distance_travelled numeric

UPDATE cyclistic2023
SET distance_travelled = 2 * 6371 *
						  ASIN(SQRT(POWER(SIN(RADIANS(end_lat - start_lat)/2), 2) +
						  COS(RADIANS(start_lat)) * COS(RADIANS(end_lat)) * 
						  POWER(SIN(RADIANS(end_lng - start_lng) / 2), 2)))
--Check which rideabletype is used most  --Marked
SELECT rideable_type, COUNT(*) AS no_of_riders, 
	   ROUND(AVG(distance_travelled), 2) AS avg_dist,
	   ROUND(AVG(ride_length)) AS avg_ridelength
FROM cyclistic2023
GROUP BY rideable_type
ORDER BY COUNT(*) DESC, avg_dist DESC, avg_ridelength DESC;

--Check the most prevalent start_stations -- Marked
SELECT start_station_name, COUNT(start_station_name) AS freq_of_start_station
FROM cyclistic2023
GROUP BY start_station_name
ORDER BY COUNT(start_station_name) DESC
LIMIT 10;

--Check the most prevalent end_stations --Marked
SELECT end_station_name, COUNT(end_station_name) AS freq_of_end_station
FROM cyclistic2023
GROUP BY end_station_name
ORDER BY COUNT(end_station_name) DESC
LIMIT 10;

--By months see how different riders used Bikes --Marked
SELECT month, COUNT(*) AS no_of_riders, ROUND(AVG(ride_length), 2) AS avg_ride_length
FROM cyclistic2023
GROUP BY month
ORDER BY COUNT(*) DESC;

--Check which set of bike users usedbikes the most
SELECT member_casual, rideable_type, COUNT(*) AS no_of_riders, 
	   ROUND(AVG(distance_travelled), 2) AS avg_dist,
	   ROUND(AVG(ride_length))AS avg_ridelength
FROM cyclistic2023
GROUP BY member_casual, rideable_type
ORDER BY avg_dist DESC, avg_ridelength DESC, COUNT(*) DESC;

--Check which bike users (overall) use bikes the most
SELECT member_casual, COUNT(*) AS no_of_riders, 
	   ROUND(AVG(distance_travelled), 2) AS avg_dist,
	   ROUND(AVG(ride_length))AS avg_ridelength
FROM cyclistic2023
GROUP BY member_casual
ORDER BY avg_dist DESC, avg_ridelength DESC, COUNT(*) DESC;

--Check how different bike riders work in the day
SELECT day, COUNT(*) AS no_of_riders, ROUND(AVG(ride_length)) AS avg_ridelength
FROM cyclistic2023
GROUP BY day
ORDER BY COUNT(*) DESC, avg_ridelength DESC;

--Checking for the Average Speed of each rideable_type 
SELECT rideable_type, ROUND(AVG(speed), 2) AS avg_speed
FROM (SELECT *, ROUND(((distance_travelled/ride_length) * 1000), 2) AS speed
	  FROM cyclistic2023
	  WHERE ride_length <> 0)
GROUP BY rideable_type 
ORDER BY avg_speed DESC;

--Check for Average Speed for Each member type
SELECT member_casual, ROUND(AVG(speed), 2) AS avg_speed
FROM (SELECT *, ROUND(((distance_travelled/ride_length) * 1000), 2) AS speed
	  FROM cyclistic2023
	  WHERE ride_length <> 0)
GROUP BY member_casual 
ORDER BY avg_speed DESC;

--I noticed there are zero ridelength, let's see those who had them
SELECT member_casual, COUNT(*) AS no_of_zero_riders
FROM 	(SELECT *
	 FROM cyclistic2023
	 WHERE ride_length = 0)
GROUP BY member_casual
ORDER BY COUNT(*) DESC;

--CHECK FOR THE TOP TEN RIDERS BY TOTAL BISTANCE COVERED
SELECT ride_id, member_casual, ROUND(distance_travelled, 2) AS dist_travelled, rideable_type
FROM cyclistic2023
ORDER BY distance_travelled DESC
LIMIT 10;

--Member types with TOP 10 highest ride_length
SELECT ride_id, member_casual, ride_length
FROM cyclistic2023
ORDER BY ride_length DESC
LIMIT 10;


--Export file
COPY (SELECT * FROM cyclistic2023) TO 'C:/tmp/output.csv' WITH CSV HEADER;