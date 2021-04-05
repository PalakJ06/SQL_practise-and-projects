/* SQL aggregate challenge */

SELECT (SELECT city ->> 'en' FROM airports WHERE airport_code =departure_airport) AS departure_city, COUNT(*)
FROM flights
GROUP BY (SELECT city ->> 'en' FROM airports WHERE airport_code =departure_airport)
HAVING count (*)>= 50
ORDER BY Count DESC;

SELECT f.flight_no,f.scheduled_departure :: time AS dep_time,
f.departure_airport AS departures,f.arrival_airport AS arrivals,
count (flight_id)AS flight_count
FROM flights f
WHERE f.departure_airport = 'KZN'
AND f.scheduled_departure >= '2017-08-28' :: date
AND f.scheduled_departure <'2017-08-29' :: date
GROUP BY 1,2,3,4,f.scheduled_departure
ORDER BY flight_count DESC,f.arrival_airport,f.scheduled_departure;

/* Section - 11 , SQL conditional */

SELECT * ,
CASE WHEN age >= '50' THEN 'old'
	 WHEN age isnull THEN 'unknown'
	 ELSE 'young' END is_old
FROM pilots;

SELECT DATE_PART('month',book_date)AS month, SUM(total_amount)AS bookings,
CASE WHEN SUM(total_amount) > 695000 THEN 'the most'
	 WHEN SUM(total_amount) < 695000 THEN 'the least'
	 ELSE 'the medium' END booking_qty
FROM bookings
GROUP BY month;

/* Null if function */

SELECT COUNT(NULLIF(actual_departure,NULL)) as dept,
	   COUNT(NULLIF(actual_arrival,NULL)) as arriv
FROM flights;

/* collesce function */

SELECT status, COALESCE(actual_departure,current_timestamp) as dept,
COALESCE(actual_arrival,current_timestamp) as arriv
FROM flights;

SELECT model,range,
CASE WHEN range < 2000 THEN 'Short_range'
     WHEN range > 2000 and range < 5000 THEN 'Middle_range'
ELSE 'Long_range' END ranges
FROM aircrafts
ORDER BY model;


SELECT f.flight_no, (f.Scheduled_arrival - f.Scheduled_departure) AS scheduled_duration,
min(f.Scheduled_arrival - f.Scheduled_departure), max(f.Scheduled_arrival - f.Scheduled_departure),
sum(CASE WHEN f.actual_departure > f.scheduled_departure + INTERVAL '1 hour' THEN 1 ELSE 0 END) delays
FROM flights f
WHERE (SELECT city ->> 'en' FROM airports WHERE airport_code = departure_airport) = 'Moscow'
AND (SELECT city ->> 'en' FROM airports WHERE airport_code = arrival_airport) = 'St. Petersburg'
AND f.status = 'Arrived'
GROUP BY f.flight_no, (f.Scheduled_arrival - f.Scheduled_departure);


SELECT public.now()

SELECT DATE_TRUNC('day',book_date),DATE_PART('day',book_date),
EXTRACT('day' FROM book_date) as date_part_extract,
CURRENT_DATE
FROM bookings;






