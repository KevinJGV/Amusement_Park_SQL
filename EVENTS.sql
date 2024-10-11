DELIMITER //
-- 1. **Evento programado para actualizar el estado de las atracciones a 'En Mantenimiento' todos los lunes.**
CREATE EVENT WeeklyMaintenanceUpdate
ON SCHEDULE EVERY 1 WEEK
STARTS '2024-10-14 00:00:00'
DO
    UPDATE Attraction
    SET Status = 'En Mantenimiento'
    WHERE Status = 'Operativa' AND DAYOFWEEK(CURDATE()) = 2;  -- 2 es lunes

-- 2. **Evento programado para eliminar boletos antiguos que no han sido utilizados.**
CREATE EVENT RemoveOldUnusedTickets
ON SCHEDULE EVERY 1 MONTH
DO
    DELETE FROM Ticket
    WHERE PurchaseDate < CURDATE() - INTERVAL 1 YEAR
    AND TicketId NOT IN (SELECT TicketId FROM Visit);

-- 3. **Evento programado para enviar un reporte semanal de visitas a los administradores (simulación con impresión en consola).**
CREATE EVENT WeeklyVisitorReport
ON SCHEDULE EVERY 1 WEEK
STARTS '2024-10-15 08:00:00'
DO
BEGIN
    -- Simulación de generación de reporte con SELECT (normalmente esto sería enviado por correo o guardado en un archivo)
    SELECT v.FirstName, v.LastName, COUNT(vis.VisitId) AS TotalVisits
    FROM Visit vis
    JOIN Visitor v ON vis.VisitorId = v.VisitorId
    GROUP BY v.VisitorId;
END //

-- 4. **Evento programado para aumentar el precio de los tickets en temporada alta (cada diciembre).**
CREATE EVENT HighSeasonTicketPriceIncrease
ON SCHEDULE EVERY 1 YEAR
STARTS '2024-12-01 00:00:00'
DO
    UPDATE Ticket
    SET Price = Price * 1.15
    WHERE TicketType IN ('General', 'VIP');

-- 5. **Evento programado para restablecer las atracciones operativas al final del día.**
CREATE EVENT ResetAttractionStatus
ON SCHEDULE EVERY 1 DAY
STARTS '2024-10-11 23:59:59'
DO
    UPDATE Attraction
    SET Status = 'Operativa'
    WHERE Status = 'En Mantenimiento';

DELIMITER ;