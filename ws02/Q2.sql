CREATE MATERIALIZED VIEW trip_stats_2 AS
SELECT 
    tz1.zone AS pickup_zone,
    tz2.zone AS dropoff_zone,
    AVG(tpep_dropoff_datetime - tpep_pickup_datetime) AS avg_trip_time,
    MIN(tpep_dropoff_datetime - tpep_pickup_datetime) AS min_trip_time,
    MAX(tpep_dropoff_datetime - tpep_pickup_datetime) AS max_trip_time,
    COUNT(*) AS num_trips
FROM 
    trip_data t1
LEFT JOIN taxi_zone tz1 ON t1.PULocationID = tz1.location_id
LEFT JOIN taxi_zone tz2 ON t1.DOLocationID = tz2.location_id
GROUP BY 
    tz1.zone, tz2.zone;

SELECT pickup_zone, dropoff_zone, avg_trip_time, num_trips FROM trip_stats_2 ORDER BY 3 DESC LIMIT 1;