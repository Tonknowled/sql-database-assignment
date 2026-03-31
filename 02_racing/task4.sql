-- Задача 4: Автомобили с позицией лучше средней по классу
WITH CarAvg AS (
    SELECT c.name AS car_name, c.class AS car_class, AVG(r.position) AS avg_pos, COUNT(r.race) AS race_count, cl.country AS car_country
    FROM Cars c JOIN Results r ON c.name = r.car JOIN Classes cl ON c.class = cl.class
    GROUP BY c.name, c.class, cl.country
),
ClassAvg AS (
    SELECT class, AVG(position) AS class_avg, COUNT(DISTINCT name) AS car_count
    FROM Cars c JOIN Results r ON c.name = r.car GROUP BY class HAVING COUNT(DISTINCT name) >= 2
)
SELECT ca.car_name, ca.car_class, ROUND(ca.avg_pos, 4) AS average_position, ca.race_count, ca.car_country
FROM CarAvg ca JOIN ClassAvg cla ON ca.car_class = cla.class
WHERE ca.avg_pos < cla.class_avg ORDER BY ca.car_class, ca.avg_pos;
