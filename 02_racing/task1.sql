-- Задача 1: Автомобили с наименьшей средней позицией в каждом классе
WITH CarAvg AS (
    SELECT c.name AS car_name, c.class AS car_class, AVG(r.position) AS avg_pos, COUNT(r.race) AS race_count
    FROM Cars c JOIN Results r ON c.name = r.car
    GROUP BY c.name, c.class
),
ClassMin AS (
    SELECT car_class, MIN(avg_pos) AS min_avg FROM CarAvg GROUP BY car_class
)
SELECT ca.car_name, ca.car_class, ROUND(ca.avg_pos, 4) AS average_position, ca.race_count
FROM CarAvg ca JOIN ClassMin cm ON ca.car_class = cm.car_class AND ca.avg_pos = cm.min_avg
ORDER BY ca.avg_pos;
