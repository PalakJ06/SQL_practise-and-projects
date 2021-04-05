/* SQL Joins test yourself*/

SELECT t.passenger_name , b.book_date
FROM Bookings b
JOIN Tickets t
ON b.book_ref = t.book_ref
JOIN Boarding_passes bp
ON t.Ticket_no = bp.ticket_no
JOIN Flights f
ON f.flight_id = bp.flight_id 
WHERE f.departure_airport = 'SVO' AND f.arrival_airport = 'OVB'
AND f.scheduled_departure::date = public.now()::date - INTERVAL '1 day'
AND seat_no = '1A';

/* Find the most disciplined passengers who checked in first for 
all their flights. Take into account only those passengers who 
took at least two flights ? */

SELECT t.passenger_name , t.ticket_no
FROM tickets t
JOIN Boarding_passes b
ON t.ticket_no = b.ticket_no
GROUP BY t.passenger_name , t.ticket_no
HAVING max(b.boarding_no) = 1 AND count(*) >1;

/* to check */
SELECT * FROM boarding_passes
WHERE boarding_no = 1 ;

/* Calculate the number of passengers and number of flights 
departing from one airport (SVO) during each hour on the 
indicated day 2017-08-02 ? */

SELECT date_part('hour', f.scheduled_departure) as hour ,
	   count(ticket_no) as passengers_count,
	   count(DISTINCT f.flight_id) as flights_cnt 
FROM Flights f
JOIN Boarding_passes bp
ON bp.flight_id = f.flight_id 
WHERE departure_airport = 'SVO'
AND f.scheduled_departure >= '2017-08-02' :: date
AND f.scheduled_departure <'2017-08-03' :: date
GROUP BY date_part ('hour', f.scheduled_departure);

/* Test yourself 6 , subqueries and CTE's section */
/* 1. How many people can be included into a single booking 
according to the available data? */

SELECT tt.bookings_no,count(*)passengers_no
FROM (SELECT t.book_ref, count(*) bookings_no FROM tickets t GROUP BY t.book_ref) tt
GROUP BY tt.bookings_no
ORDER BY tt.bookings_no;

/* 2. Which combinations of first and last names occur most often? 
What is the ratio of the passengers with such names to the 
total number of passengers? */

SELECT passenger_name,round( 100* cnt / sum(cnt) OVER (), 2) AS percent
FROM (SELECT passenger_name, count(*) cnt  FROM tickets GROUP BY passenger_name) sub
ORDER BY percent DESC;


SELECT passenger_name, count(*) cnt  FROM tickets GROUP BY passenger_name;

/* SQL Sub-query CTE Challenge */
/* 1. What are the maximum and minimum ticket prices in all directions? */

WITH air AS (SELECT (SELECT city ->> 'en' FROM airports WHERE airport_code = f.departure_airport) AS departure_city,
			 (SELECT city ->> 'en' FROM airports WHERE airport_code = f.arrival_airport) AS arrival_city,
			  max(tf.amount), min(tf.amount)
			  FROM flights f
			  JOIN Ticket_flights tf
			  ON tf.flight_id = f.flight_id
			  GROUP BY 1, 2
			  ORDER BY 1, 2)
SELECT * FROM air;


SELECT (SELECT city ->> 'en' FROM airports WHERE airport_code = f.departure_airport) AS departure_city, (SELECT city ->> 'en' FROM airports WHERE airport_code = f.arrival_airport) AS arrival_city, max (tf.amount), min (tf.amount)
FROM flights f
JOIN ticket_flights tf
ON f.flight_id = tf.flight_id
GROUP BY 1, 2
ORDER BY 1, 2;




