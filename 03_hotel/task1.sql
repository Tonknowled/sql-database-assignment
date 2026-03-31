-- Задача 1: Клиенты с более чем двумя бронированиями в разных отелях
SELECT 
    c.name,
    c.email,
    c.phone,
    COUNT(DISTINCT b.ID_booking) AS total_bookings,
    GROUP_CONCAT(DISTINCT h.name ORDER BY h.name SEPARATOR ', ') AS hotel_list,
    ROUND(AVG(DATEDIFF(b.check_out_date, b.check_in_date)), 4) AS avg_stay_days
FROM Customer c
JOIN Booking b ON c.ID_customer = b.ID_customer
JOIN Room r ON b.ID_room = r.ID_room
JOIN Hotel h ON r.ID_hotel = h.ID_hotel
GROUP BY c.ID_customer, c.name, c.email, c.phone
HAVING COUNT(DISTINCT b.ID_booking) > 2 
   AND COUNT(DISTINCT h.ID_hotel) > 1
ORDER BY total_bookings DESC;
