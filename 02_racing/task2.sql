-- Задача 2: Автомобиль с наименьшей средней позицией
WITH CarAvg AS (
    SELECT c.name AS car_name, c.class AS car_class, AVG(r.position) AS avg_pos, COUNT(r.race) AS race_count, cl.country AS car_country
    FROM Cars c JOIN Results r ON c.name = r.car JOIN Classes cl ON c.class = cl.class
    GROUP BY c.name, c.class, cl.country
)
SELECT car_name, car_class, ROUND(avg_pos, 4) AS average_position, race_count, car_country
FROM CarAvg WHERE avg_pos = (SELECT MIN(avg_pos) FROM CarAvg) ORDER BY car_name LIMIT 1;
