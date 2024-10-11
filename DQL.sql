-- 1. **Obtener todas las atracciones operativas.**
SELECT
    A.Name AS Attraction,
    A.Status
FROM
    `Attraction` A
WHERE
    A.Status = 'Operativa';

-- 2. **Listar todos los visitantes que se encuentran en la base de datos.**
SELECT
    CONCAT (V.FirstName, ' ', V.LastName) AS Visitor
FROM
    Visitor V;

-- 3. **Mostrar los eventos programados junto con su precio.**
SELECT
    E.Name AS Event,
    E.Price
FROM
    Event E;

-- 4. **Obtener el nombre y fecha de contratación de todos los empleados.**
SELECT
    CONCAT (E.FirstName, ' ', E.LastName) AS Employee,
    E.HireDate
FROM
    Employee E;

-- 5. **Listar todos los boletos vendidos y su tipo.**
SELECT
    T.TicketId,
    T.TicketType
FROM
    Ticket T;

-- 6. **Obtener el nombre de los visitantes y las atracciones que visitaron.**
SELECT
    CONCAT (v.FirstName, ' ', v.LastName) AS Visitor,
    a.Name AS Attraction
FROM
    Visit vi
    JOIN Visitor v ON vi.VisitorId = v.VisitorId
    JOIN Attraction a ON vi.AttractionId = a.AttractionId;

-- 7. **Listar los empleados que participaron en eventos, junto con el nombre del evento.**
SELECT
    CONCAT (e.FirstName, ' ', e.LastName) AS Employee,
    ev.Name AS EventName
FROM
    EmployeeEvent ee
    JOIN Employee e ON ee.EmployeeId = e.EmployeeId
    JOIN Event ev ON ee.EventId = ev.EventId;

-- 8. **Mostrar los detalles de mantenimiento realizados por cada empleado, junto con la atracción.**
SELECT
    CONCAT (e.FirstName, ' ', e.LastName) AS Employee,
    a.Name AS Attraction,
    m.Details
FROM
    Maintenance m
    JOIN Employee e ON m.EmployeeId = e.EmployeeId
    JOIN Attraction a ON m.AttractionId = a.AttractionId;

-- 9. **Obtener el nombre del visitante y la atracción que calificó junto con la puntuación.**
SELECT
    CONCAT (v.FirstName, ' ', v.LastName) AS Visitor,
    a.Name AS Attraction,
    vi.Rating
FROM
    Visit vi
    JOIN Visitor v ON vi.VisitorId = v.VisitorId
    JOIN Attraction a ON vi.AttractionId = a.AttractionId;

-- 10. **Listar los visitantes que asistieron a eventos, con el nombre del evento.**
SELECT
    CONCAT (v.FirstName, ' ', v.LastName) AS Visitor,
    e.Name AS EventName
FROM
    VisitorEvent ve
    JOIN Visitor v ON ve.VisitorId = v.VisitorId
    JOIN Event e ON ve.EventId = e.EventId;

-- 11. **Contar cuántas visitas ha tenido cada atracción.**
SELECT
    a.Name AS Attraction,
    COUNT(vi.VisitId) AS VisitCount
FROM
    Visit vi
    JOIN Attraction a ON vi.AttractionId = a.AttractionId
GROUP BY
    a.Name;

-- 12. **Obtener el precio promedio de los tickets vendidos por tipo.**
SELECT
    T.TicketType,
    ROUND(AVG(T.Price)) AS AvgPrice
FROM
    Ticket T
GROUP BY
    T.TicketType;

-- 13. **Contar cuántos empleados hay en cada ciudad.**
SELECT
    E.City,
    COUNT(E.EmployeeId) AS EmployeeCount
FROM
    Employee E
GROUP BY
    E.City;

-- 14. **Listar el total de visitantes por país.**
SELECT
    V.Country,
    COUNT(V.VisitorId) AS VisitorCount
FROM
    Visitor V
GROUP BY
    V.Country;

-- 15. **Obtener el número total de eventos y su precio promedio.**
SELECT
    COUNT(E.EventId) AS TotalEvents,
    AVG(E.Price) AS AvgPrice
FROM
    Event E;

-- 16. **Obtener el nombre de las atracciones que tienen una capacidad máxima mayor que el promedio.**
SELECT
    Name AS Attraction,
    ROUND(AVG(MaxCapacity)) as MaxCapacity
FROM
    Attraction
GROUP BY
    Name
HAVING
    AVG(MaxCapacity) > (
        SELECT
            AVG(MaxCapacity)
        FROM
            Attraction
    );

-- 17. **Listar los empleados que han trabajado en más de un evento.**
SELECT
    CONCAT (e.FirstName, ' ', e.LastName) AS Employee,
    COUNT(ee.EventId) AS EventCount
FROM
    EmployeeEvent ee
    JOIN Employee e ON ee.EmployeeId = e.EmployeeId
HAVING
    COUNT(ee.EventId) > 1;

-- 18. **Obtener las atracciones que no han sido visitadas en la última semana.**
SELECT
    a.Name AS Attraction
FROM
    Attraction a
WHERE
    a.AttractionId NOT IN (
        SELECT
            AttractionId
        FROM
            Visit
        WHERE
            VisitDate >= DATE_SUB (CURDATE (), INTERVAL 7 DAY)
    );

-- 19. **Listar los visitantes que compraron un boleto VIP.**
SELECT
    CONCAT (v.FirstName, ' ', v.LastName) AS Visitor,
    t.TicketType
FROM
    Ticket t
    JOIN Visitor v ON t.VisitorId = v.VisitorId
WHERE
    t.TicketType = 'VIP';

-- 20. **Mostrar los empleados cuyo salario (de la tabla `EmployeeSalary`) es mayor al salario promedio.**
-- 21. **Actualizar el estado de una atracción a 'En Mantenimiento'.**
-- 22. **Eliminar visitantes que no han realizado ninguna visita.**
-- 23. **Insertar un nuevo evento en la base de datos.**
-- 24. **Aumentar el precio de los tickets VIP en un 10%.**
-- 25. **Cambiar la ciudad de todos los empleados en Bogotá a Medellín.**