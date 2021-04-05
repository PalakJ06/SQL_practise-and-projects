SELECT s.seat_no, s.fare_conditions,a.model ->> 'en' AS model,
a.range as range_A, AVG(a.range) OVER(partition by model) avg_range
FROM seats s
JOIN aircrafts a
USING (aircraft_code);


