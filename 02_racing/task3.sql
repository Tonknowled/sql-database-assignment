-- Задача 3: Классы с наименьшей средней позицией
WITH ClassAvg AS (
    SELECT c.class, AVG(r.position) AS class_avg
    FROM Cars c JOIN Results r ON c.name = r.car GROUP BY c.class
),
MinClass AS (
    SELECT class FROM ClassAvg WHERE class_avg = (SELECT MIN(class_avg) FROM ClassAvg)
),
CarDetails AS (
    SELECT c.name AS car_name, c.class AS car_class, AVG(r.position) AS avg_pos, COUNT(r.race) AS race_count, cl.country AS car_country
    FROM Cars c JOIN Results r ON c.name = r.car JOIN Classes cl ON c.class = cl.class
    GROUP BY c.name, c.class, cl.country
)
SELECT cd.car_name, cd.car_class, ROUND(cd.avg_pos, 4) AS average_position, cd.race_count, cd.car_country,
    (SELECT COUNT(*) FROM Results r2 WHERE r2.car IN (SELECT name FROM Cars WHERE class = cd.car_class)) AS total_races
FROM CarDetails cd WHERE cd.car_class IN (SELECT class FROM MinClass) ORDER BY cd.avg_pos;
