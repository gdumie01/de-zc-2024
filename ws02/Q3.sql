CREATE MATERIALIZED VIEW trip_stats_3 AS
WITH latest AS (
    SELECT MAX(tpep_pickup_datetime) AS latest_pickup_time
    FROM trip_data
)
SELECT tz1.zone, COUNT(*) 
FROM trip_data t1, latest
LEFT JOIN taxi_zone tz1 ON t1.PULocationID = tz1.location_id
WHERE tpep_pickup_datetime > DATE_SUB(latest_pickup_time, INTERVAL '17' HOUR)
GROUP BY 1;

