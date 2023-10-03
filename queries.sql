CREATE OR REPLACE TABLE uber_data_new.tbl_analytics AS (
SELECT 
  f.trip_id,
  f.VendorID,
  d.tpep_pickup_datetime,
  d.tpep_dropoff_datetime,
  p.passenger_count,
  t.trip_distance,
  r.rate_code_name,
  pick.pickup_latitude,
  pick.pickup_longitude,
  drop.dropoff_latitude,
  drop.dropoff_longitude,
  pay.payment_type_name,
  f.fare_amount,
  f.extra,
  f.mta_tax,
  f.tip_amount,
  f.tolls_amount,
  f.improvement_surcharge,
  f.total_amount
FROM 
  uber_data_new.fact_table f
JOIN 
  uber_data_new.datetime_dim d  ON f.datetime_id=d.datetime_id
JOIN 
  uber_data_new.passenger_count_dim p  ON p.passenger_count_id=f.passenger_count_id  
JOIN 
  uber_data_new.trip_distance_dim t  ON t.trip_distance_id=f.trip_distance_id  
JOIN 
  uber_data_new.rate_code_dim r ON r.rate_code_id=f.rate_code_id  
JOIN 
  uber_data_new.pickup_location_dim pick ON pick.pickup_location_id=f.pickup_location_id
JOIN 
  uber_data_new.dropoff_location_dim drop ON drop.dropoff_location_id=f.dropoff_location_id
JOIN 
  uber_data_new.payment_type_dim pay ON pay.payment_type_id=f.payment_type_id
);

#Top 10 Pickup Locations Based on the Number of Trips
SELECT 
  pickup_location_id,
  COUNT(trip_id) AS trip_count
FROM 
  uber_data_new.fact_table
GROUP BY 
  pickup_location_id
ORDER BY 
  trip_count DESC
LIMIT 10;

#Total Number of Trips by Passenger Count
SELECT 
  passenger_count_id,
  COUNT(trip_id) AS trip_count
FROM 
  uber_data_new.fact_table
GROUP BY 
  passenger_count_id;
