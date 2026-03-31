-- Задача 3: Категоризация отелей и предпочтения клиентов
WITH HotelCategory AS (
    SELECT 
        h.ID_hotel,
        h.name AS hotel_name,
        AVG(r.price) AS avg_price,
        CASE 
            WHEN AVG(r.price) < 175 THEN 'Дешевый'
            WHEN AVG(r.price) BETWEEN 175 AND 300 THEN 'Средний'
            ELSE 'Дорогой'
        END AS category
    FROM Hotel h
    JOIN Room r ON h.ID_hotel = r.ID_hotel
    GROUP BY h.ID_hotel, h.name
),
CustomerHotels AS (
    SELECT DISTINCT
        c.ID_customer,
        c.name,
        hc.hotel_name,
        hc.category
    FROM Customer c
    JOIN Booking b ON c.ID_customer = b.ID_customer
    JOIN Room r ON b.ID_room = r.ID_room
    JOIN HotelCategory hc ON r.ID_hotel = hc.ID_hotel
),
CustomerPreference AS (
    SELECT 
        ID_customer,
        name,
        MAX(CASE 
            WHEN category = 'Дорогой' THEN 3
            WHEN category = 'Средний' THEN 2
            WHEN category = 'Дешевый' THEN 1
        END) AS pref_level,
        GROUP_CONCAT(DISTINCT hotel_name ORDER BY hotel_name SEPARATOR ', ') AS visited_hotels
    FROM CustomerHotels
    GROUP BY ID_customer, name
)
SELECT 
    ID_customer,
    name,
    CASE pref_level
        WHEN 3 THEN 'Дорогой'
        WHEN 2 THEN 'Средний'
        WHEN 1 THEN 'Дешевый'
    END AS preferred_hotel_type,
    visited_hotels
FROM CustomerPreference
ORDER BY pref_level;
