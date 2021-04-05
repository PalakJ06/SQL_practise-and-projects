COPY(SELECT passenger_name, DATE_Part('day',book_date) AS day,
			 DATE_Part('month',book_date) AS month, 
	 		(SELECT city->>'en' FROM airports WHERE airport_code = f.departure_airport) AS departure_city,
	 		(SELECT city->>'en' FROM airports WHERE airport_code = f.arrival_airport) AS arrival_city,
	 		SUM(total_amount) AS sales
	 		FROM bookings b
	 		JOIN tickets t
	 		ON b.book_Ref = t.book_ref
	 		JOIN ticket_flights tf
	 		ON tf.ticket_no = t.ticket_no
	 		JOIN flights f
	 		ON tf.flight_id = f.flight_id
	 		GROUP BY 1,2,3,4,5
	 		ORDER BY 3,2,6) to 'C:\Users\palak\Google Drive\CSV\airlines.csv' DELIMITER ',' CSV HEADER;
			
/* Final Exam */

/* 3. Which flights had the longest delays? */

SELECT flight_id , flight_no ,actual_arrival,(actual_arrival - scheduled_arrival) AS delay
FROM Flights
WHERE actual_arrival IS NOT NULL
ORDER BY delay;

SELECT flight_id , flight_no ,actual_departure,scheduled_departure,(actual_departure - scheduled_departure) AS delay
FROM Flights
WHERE actual_departure IS NOT NULL
ORDER BY delay;
