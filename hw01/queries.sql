/* Question 3. Count records */
SELECT COUNT(*)
FROM green_taxi_trips
WHERE DATE(lpep_pickup_datetime) = '2019-09-18' AND 
	  DATE(lpep_dropoff_datetime) = '2019-09-18'
/* ANSWER: 15612 */


/* Question 4. Largest trip for each day */
SELECT DATE(lpep_pickup_datetime)
FROM green_taxi_trips
ORDER BY trip_distance DESC
LIMIT 1
/* ANSWER: 2019-09-26 */

/* Question 5. Three biggest pick up Boroughs */
SELECT "Borough", SUM(total_amount)
FROM green_taxi_trips gtt
LEFT JOIN zone_lookup zl on gtt."PULocationID" = zl."LocationID"
WHERE DATE(lpep_pickup_datetime) = '2019-09-18' AND "Borough" <> 'Unknown'
GROUP BY 1
HAVING SUM(total_amount) > 50000
ORDER BY 2 DESC
/* ANSWER: "Brooklyn" "Manhattan" "Queens" */

/* Question 6. Largest tip */
SELECT dol."Zone", MAX(tip_amount)
FROM green_taxi_trips gtt
LEFT JOIN zone_lookup pul on gtt."PULocationID" = pul."LocationID"
LEFT JOIN zone_lookup dol on gtt."DOLocationID" = dol."LocationID"
WHERE DATE_TRUNC('month', lpep_pickup_datetime) = '2019-09-01'::date
AND pul."Zone" = 'Astoria'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1
/* ANSWER: JFK Airport */