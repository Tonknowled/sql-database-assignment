-- Задача 5: Классы с наибольшим количеством автомобилей со средней позицией > 3.0
WITH CarAvg AS (
    SELECT c.name AS car_name, c.class AS car_class, AVG(r.position) AS avg_pos, COUNT(r.race) AS race_count, cl.country AS car_country
    FROM Cars c JOIN Results r ON c.name = r.car JOIN Classes cl ON c.class = cl.class
    GROUP BY c.name, c.class, cl.country
),
ClassLowCount AS (
    SELECT car_class, COUNT(*) AS low_position_count FROM CarAvg WHERE avg_pos > 3.0 GROUP BY car_class
),
MaxLowCount AS (
    SELECT MAX(low_position_count) AS max_count FROM ClassLowCount
)
SELECT ca.car_name, ca.car_class, ROUND(ca.avg_pos, 4) AS average_position, ca.race_count, ca.car_country,
    (SELECT COUNT(*) FROM Results r2 WHERE r2.car IN (SELECT name FROM Cars WHERE class = ca.car_class)) AS total_races,
    clc.low_position_count
FROM CarAvg ca JOIN ClassLowCount clc ON ca.car_class = clc.car_class
WHERE clc.low_position_count = (SELECT max_count FROM MaxLowCount)
ORDER BY clc.low_position_count DESC;
