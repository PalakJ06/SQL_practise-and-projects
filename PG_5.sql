SELECT aircraft_code, model, sum(range)FROM aircrafts
GROUP BY GROUPING sets (aircraft_code, model);

/* view example */

CREATE VIEW cities AS 
SELECT (SELECT city ->> 'en' FROM airports WHERE airport_code =departure_airport) AS departure_city, 
(SELECT city ->> 'en' FROM airports WHERE airport_code =arrival_airport) AS arrival_city
FROM flights
 
SELECT departure_city, count (*)
FROM cities
GROUP BY departure_city
HAVING departure_city IN (SELECT city->> 'en' FROM airports )
ORDER BY count DESC;

/* String functions */

SELECT POSITION ('SQL' IN 'POSTGRESQL')

SELECT LEFT (passenger_name, -1)
FROM tickets;
