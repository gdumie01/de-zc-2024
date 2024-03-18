CREATE MATERIALIZED VIEW trip_stats_3 AS
WITH latest AS (
    SELECT MAX(tpep_pickup_datetime) AS latest_pickup_time
    FROM trip_data
)
SELECT tz1.zone, COUNT(*) AS trips_num
FROM trip_data t1
LEFT JOIN latest ON 1=1
LEFT JOIN taxi_zone tz1 ON t1.PULocationID = tz1.location_id
WHERE tpep_pickup_datetime > (latest_pickup_time - INTERVAL '17 hours')
GROUP BY tz1.zone;

SELECT * FROM trip_stats_3 ORDER BY trips_num DESC LIMIT 3;

