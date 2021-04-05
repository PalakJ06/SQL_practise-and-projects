SELECT * FROM aircrafts; 
/* SELECT * FROM airports; */
/* SELECT DISTINCT timezone FROM airports; */
/* SELECT airport_code,airport_name,city
FROM airports
WHERE city ->> 'en' = 'Moscow'; */

/* SELECT passenger_name 
FROM tickets
WHERE passenger_name LIKE '___%'; */

SELECT * FROM boarding_passes   /* this query will select next 10 rows */
OFFSET 10 ROWS
FETCH FIRST 10 ROWS ONLY;

/* Agregrations functions ## */

CREATE Table pilots(
		id serial PRIMARY KEY,
		name TEXT NOT NULL,
		speciality TEXT NOT NULL,
		age TEXT);
		
INSERT INTO pilots (name, speciality, age)
VALUES ('John','pilot',50),
		('Sara','co_pilot',35),
		('David','pilot',null);
		
SELECT * FROM pilots;

SELECT book_date, Sum(total_amount) AS sales
FROM bookings
GROUP BY 1
ORDER BY 2
LIMIT 1;

SELECT city ->> 'en' FROM airports;

SELECT '01-01-2020' :: DATE /* cast date as DATE datatype */
		
		
		


