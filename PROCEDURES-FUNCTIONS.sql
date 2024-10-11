DELIMITER //
-- PROCEDIMIENTOS
-- Procedimiento para registrar una nueva visita a una atracción.
CREATE PROCEDURE RegisterVisit(
    IN p_VisitId INT,
    IN p_VisitorId INT,
    IN p_AttractionId INT,
    IN p_VisitDate DATE,
    IN p_Rating INT
)
BEGIN
    INSERT INTO Visit (VisitId,VisitorId, AttractionId, VisitDate, Rating)
    VALUES (p_VisitId,p_VisitorId, p_AttractionId, p_VisitDate, p_Rating);
END //

-- Procedimiento para actualizar el precio de los eventos por un porcentaje.
CREATE PROCEDURE UpdateEventPrices(
    IN p_PercentageIncrease DECIMAL(5, 2)
)
BEGIN
    UPDATE Event
    SET Price = Price * (1 + p_PercentageIncrease / 100);
END //

-- Procedimiento para eliminar eventos anteriores a una fecha específica.
-- Procedimiento para asignar un empleado a un evento.
CREATE PROCEDURE AssignEmployeeToEvent(
    IN p_EmployeeId INT,
    IN p_EventId INT
)
BEGIN
    INSERT INTO EmployeeEvent (EmployeeId, EventId)
    VALUES (p_EmployeeId, p_EventId);
END //

-- Procedimiento para generar un informe de visitantes y las atracciones que visitaron.
CREATE PROCEDURE VisitorAttractionReport()
BEGIN
    SELECT v.FirstName, v.LastName, a.Name AS AttractionName, vis.VisitDate
    FROM Visit vis
    JOIN Visitor v ON vis.VisitorId = v.VisitorId
    JOIN Attraction a ON vis.AttractionId = a.AttractionId;
END //

-- FUNCIONES
-- 1. **Función para calcular la edad de un visitante.**
CREATE FUNCTION CalculateAge(p_BirthDate DATE)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_Age INT;
    SET v_Age = TIMESTAMPDIFF(YEAR, p_BirthDate, CURDATE());
    RETURN v_Age;
END //

-- 2. **Función para obtener el precio total de los tickets vendidos en un día específico.**
CREATE FUNCTION TotalTicketsSoldOnDate(p_Date DATE)
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE v_Total DECIMAL(10, 2);
    SELECT SUM(Price) INTO v_Total
    FROM Ticket
    WHERE PurchaseDate = p_Date;
    RETURN v_Total;
END //

-- 3. **Función para calcular el precio promedio de los tickets VIP.**
CREATE FUNCTION AverageVIPTicketPrice()
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE v_AveragePrice DECIMAL(10, 2);
    SELECT AVG(Price) INTO v_AveragePrice
    FROM Ticket
    WHERE TicketType = 'VIP';
    RETURN v_AveragePrice;
END //

-- 4. **Función para obtener la capacidad total de todas las atracciones operativas.**
CREATE FUNCTION TotalOperationalCapacity()
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_TotalCapacity INT;
    SELECT SUM(MaxCapacity) INTO v_TotalCapacity
    FROM Attraction
    WHERE Status = 'Operativa';
    RETURN v_TotalCapacity;
END //

-- 5. **Función para verificar si un visitante tiene al menos una visita registrada.**
CREATE FUNCTION HasVisits(p_VisitorId INT)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE v_Count INT;
    SELECT COUNT(*) INTO v_Count
    FROM Visit
    WHERE VisitorId = p_VisitorId;
    RETURN v_Count > 0;
END //

DELIMITER ;