-- IMPORT PARQUET FILES TO EXTERNAL TABLE
CREATE OR REPLACE EXTERNAL TABLE `de-zoomcamp-2024-412715.ny_taxi.green_tripdata_external`
OPTIONS (
  format = 'PARQUET',
  uris = ['gs://de-zc-2024-hw03/green_tripdata_2022-*.parquet']
);

-- IMPORT DATA TO INTERNAL TABLE
CREATE OR REPLACE TABLE `de-zoomcamp-2024-412715.ny_taxi.green_tripdata` AS
SELECT * FROM `de-zoomcamp-2024-412715.ny_taxi.green_tripdata_external`;

-- Q1
SELECT COUNT(*)
FROM `de-zoomcamp-2024-412715.ny_taxi.green_tripdata`;
-- R: 840402

-- Q2
SELECT COUNT (DISTINCT PULocationID)
FROM `de-zoomcamp-2024-412715.ny_taxi.green_tripdata_external`;
-- 0B for external

SELECT COUNT (DISTINCT PULocationID)
FROM `de-zoomcamp-2024-412715.ny_taxi.green_tripdata`;
-- 6.41MB

-- Q3
SELECT COUNT (*)
FROM `de-zoomcamp-2024-412715.ny_taxi.green_tripdata_external`
WHERE fare_amount = 0;
-- 1,622

-- Q4
-- Partition by lpep_pickup_datetime Cluster on PUlocationID
CREATE OR REPLACE TABLE `de-zoomcamp-2024-412715.ny_taxi.green_tripdata_partitioned`
PARTITION BY DATE(lpep_pickup_datetime)
CLUSTER BY PULocationID AS
SELECT * FROM `de-zoomcamp-2024-412715.ny_taxi.green_tripdata_external`;

-- Q5
--Write a query to retrieve the distinct PULocationID between lpep_pickup_datetime 06/01/2022 and 06/30/2022 (inclusive)
SELECT DISTINCT PULocationID
FROM `de-zoomcamp-2024-412715.ny_taxi.green_tripdata`
WHERE lpep_pickup_datetime >= TIMESTAMP('2022-06-01') 
  AND lpep_pickup_datetime < TIMESTAMP('2022-07-01');

SELECT DISTINCT PULocationID
FROM `de-zoomcamp-2024-412715.ny_taxi.green_tripdata_partitioned`
WHERE lpep_pickup_datetime >= TIMESTAMP('2022-06-01') 
  AND lpep_pickup_datetime < TIMESTAMP('2022-07-01');
-- 12.82 MB for non-partitioned table and 1.12 MB for the partitioned table

-- Q6
--GCP Bucket

-- Q7
-- False

