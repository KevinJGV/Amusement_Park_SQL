DROP DATABASE IF EXISTS `AmusementPark`;

/*******************************************************************************
   Create database
********************************************************************************/
CREATE DATABASE `AmusementPark`;


USE `AmusementPark`;

/*******************************************************************************
   Create Tables
********************************************************************************/
CREATE TABLE `Attraction`
(
    `AttractionId` INT NOT NULL,
    `Name` VARCHAR(160) NOT NULL,
    `Type` VARCHAR(60) NOT NULL,
    `MinHeight` INT,
    `MaxCapacity` INT,
    `Status` VARCHAR(20) NOT NULL,
    CONSTRAINT `PK_Attraction` PRIMARY KEY (`AttractionId`)
);

CREATE TABLE `Visitor`
(
    `VisitorId` INT NOT NULL,
    `FirstName` VARCHAR(40) NOT NULL,
    `LastName` VARCHAR(40) NOT NULL,
    `BirthDate` DATE NOT NULL,
    `Email` VARCHAR(60),
    `Phone` VARCHAR(24),
    `Address` VARCHAR(70),
    `City` VARCHAR(40),
    `State` VARCHAR(40),
    `Country` VARCHAR(40),
    `PostalCode` VARCHAR(10),
    CONSTRAINT `PK_Visitor` PRIMARY KEY (`VisitorId`)
);

CREATE TABLE `Ticket`
(
    `TicketId` INT NOT NULL,
    `VisitorId` INT NOT NULL,
    `PurchaseDate` DATE NOT NULL,
    `TicketType` VARCHAR(40) NOT NULL,
    `Price` DECIMAL(10,2) NOT NULL,
    `ValidFrom` DATE NOT NULL,
    `ValidTo` DATE NOT NULL,
    CONSTRAINT `PK_Ticket` PRIMARY KEY (`TicketId`),
    CONSTRAINT `FK_Ticket_Visitor` FOREIGN KEY (`VisitorId`) REFERENCES `Visitor`(`VisitorId`)
);

CREATE TABLE `Employee`
(
    `EmployeeId` INT NOT NULL,
    `FirstName` VARCHAR(40) NOT NULL,
    `LastName` VARCHAR(40) NOT NULL,
    `JobTitle` VARCHAR(40),
    `HireDate` DATE,
    `Email` VARCHAR(60),
    `Phone` VARCHAR(24),
    `Address` VARCHAR(70),
    `City` VARCHAR(40),
    `State` VARCHAR(40),
    `Country` VARCHAR(40),
    `PostalCode` VARCHAR(10),
    CONSTRAINT `PK_Employee` PRIMARY KEY (`EmployeeId`)
);

CREATE TABLE `Maintenance`
(
    `MaintenanceId` INT NOT NULL,
    `AttractionId` INT NOT NULL,
    `EmployeeId` INT NOT NULL,
    `MaintenanceDate` DATE NOT NULL,
    `Details` VARCHAR(500),
    CONSTRAINT `PK_Maintenance` PRIMARY KEY (`MaintenanceId`),
    CONSTRAINT `FK_Maintenance_Attraction` FOREIGN KEY (`AttractionId`) REFERENCES `Attraction`(`AttractionId`),
    CONSTRAINT `FK_Maintenance_Employee` FOREIGN KEY (`EmployeeId`) REFERENCES `Employee`(`EmployeeId`)
);

CREATE TABLE `Visit`
(
    `VisitId` INT NOT NULL,
    `VisitorId` INT NOT NULL,
    `AttractionId` INT NOT NULL,
    `VisitDate` DATE NOT NULL,
    `Rating` INT CHECK (`Rating` >= 1 AND `Rating` <= 5),
    `Comment` VARCHAR(500),
    CONSTRAINT `PK_Visit` PRIMARY KEY (`VisitId`),
    CONSTRAINT `FK_Visit_Visitor` FOREIGN KEY (`VisitorId`) REFERENCES `Visitor`(`VisitorId`),
    CONSTRAINT `FK_Visit_Attraction` FOREIGN KEY (`AttractionId`) REFERENCES `Attraction`(`AttractionId`)
);

CREATE TABLE `Event`
(
    `EventId` INT NOT NULL,
    `Name` VARCHAR(120) NOT NULL,
    `Description` VARCHAR(500),
    `EventDate` DATE NOT NULL,
    `Price` DECIMAL(10,2),
    CONSTRAINT `PK_Event` PRIMARY KEY (`EventId`)
);

CREATE TABLE `EmployeeEvent`
(
    `EmployeeId` INT NOT NULL,
    `EventId` INT NOT NULL,
    CONSTRAINT `PK_EmployeeEvent` PRIMARY KEY (`EmployeeId`, `EventId`),
    CONSTRAINT `FK_EmployeeEvent_Employee` FOREIGN KEY (`EmployeeId`) REFERENCES `Employee`(`EmployeeId`),
    CONSTRAINT `FK_EmployeeEvent_Event` FOREIGN KEY (`EventId`) REFERENCES `Event`(`EventId`)
);

CREATE TABLE `VisitorEvent`
(
    `VisitorId` INT NOT NULL,
    `EventId` INT NOT NULL,
    `TicketId` INT NOT NULL,
    CONSTRAINT `PK_VisitorEvent` PRIMARY KEY (`VisitorId`, `EventId`, `TicketId`),
    CONSTRAINT `FK_VisitorEvent_Visitor` FOREIGN KEY (`VisitorId`) REFERENCES `Visitor`(`VisitorId`),
    CONSTRAINT `FK_VisitorEvent_Event` FOREIGN KEY (`EventId`) REFERENCES `Event`(`EventId`),
    CONSTRAINT `FK_VisitorEvent_Ticket` FOREIGN KEY (`TicketId`) REFERENCES `Ticket`(`TicketId`)
);

/*******************************************************************************
   Insert Data
********************************************************************************/
-- Inserts para la tabla `Attraction`
INSERT INTO `Attraction` (`AttractionId`, `Name`, `Type`, `MinHeight`, `MaxCapacity`, `Status`) VALUES
(1, 'Montaña Rusa', 'Extrema', 120, 100, 'Operativa'),
(2, 'Casa del Terror', 'Terror', 110, 50, 'Operativa'),
(3, 'Rueda de la Fortuna', 'Familiar', 0, 80, 'En Mantenimiento'),
(4, 'Carrusel', 'Infantil', 0, 60, 'Operativa'),
(5, 'Sillas Voladoras', 'Aérea', 90, 40, 'Operativa'),
(6, 'Tobogán de Agua', 'Aventura', 100, 120, 'Operativa'),
(7, 'Salto al Vacío', 'Extrema', 130, 30, 'En Mantenimiento'),
(8, 'Tren Fantasma', 'Terror', 0, 70, 'Operativa'),
(9, 'Mini Montaña Rusa', 'Infantil', 90, 50, 'Operativa'),
(10, 'Espejos Mágicos', 'Diversión', 0, 30, 'Operativa');

-- Inserts para la tabla `Visitor`
INSERT INTO `Visitor` (`VisitorId`, `FirstName`, `LastName`, `BirthDate`, `Email`, `Phone`, `Address`, `City`, `State`, `Country`, `PostalCode`) VALUES
(1, 'Carlos', 'Pérez', '1985-07-12', 'carlos.perez@example.com', '123456789', 'Calle 123', 'Bogotá', 'Cundinamarca', 'Colombia', '110111'),
(2, 'Ana', 'Gómez', '1990-11-25', 'ana.gomez@example.com', '987654321', 'Carrera 45', 'Medellín', 'Antioquia', 'Colombia', '050001'),
(3, 'Luis', 'Martínez', '1982-03-10', 'luis.martinez@example.com', '456789123', 'Calle 67', 'Cali', 'Valle del Cauca', 'Colombia', '760001'),
(4, 'Sofía', 'Hernández', '1995-08-22', 'sofia.hernandez@example.com', '321654987', 'Avenida 34', 'Barranquilla', 'Atlántico', 'Colombia', '080001'),
(5, 'Pedro', 'Ramírez', '1978-12-14', 'pedro.ramirez@example.com', '159753456', 'Calle 8', 'Cartagena', 'Bolívar', 'Colombia', '130001'),
(6, 'María', 'Cruz', '1993-06-30', 'maria.cruz@example.com', '258963147', 'Calle 90', 'Pereira', 'Risaralda', 'Colombia', '660001'),
(7, 'Andrés', 'Fernández', '1980-01-05', 'andres.fernandez@example.com', '753159486', 'Calle 15', 'Santa Marta', 'Magdalena', 'Colombia', '470001'),
(8, 'Lucía', 'Jiménez', '1988-09-20', 'lucia.jimenez@example.com', '951357486', 'Calle 24', 'Bucaramanga', 'Santander', 'Colombia', '680001'),
(9, 'Javier', 'Alvarez', '1992-10-16', 'javier.alvarez@example.com', '852963741', 'Calle 88', 'Cali', 'Valle del Cauca', 'Colombia', '760002'),
(10, 'Natalia', 'Sánchez', '1986-04-12', 'natalia.sanchez@example.com', '147258369', 'Calle 20', 'Medellín', 'Antioquia', 'Colombia', '050002');

-- Inserts para la tabla `Ticket`
INSERT INTO `Ticket` (`TicketId`, `VisitorId`, `PurchaseDate`, `TicketType`, `Price`, `ValidFrom`, `ValidTo`) VALUES
(1, 1, '2024-10-01', 'General', 50.00, '2024-10-01', '2024-10-01'),
(2, 2, '2024-10-01', 'VIP', 100.00, '2024-10-01', '2024-10-01'),
(3, 3, '2024-10-02', 'General', 50.00, '2024-10-02', '2024-10-02'),
(4, 4, '2024-10-02', 'VIP', 100.00, '2024-10-02', '2024-10-02'),
(5, 5, '2024-10-03', 'General', 50.00, '2024-10-03', '2024-10-03'),
(6, 6, '2024-10-03', 'VIP', 100.00, '2024-10-03', '2024-10-03'),
(7, 7, '2024-10-04', 'General', 50.00, '2024-10-04', '2024-10-04'),
(8, 8, '2024-10-04', 'VIP', 100.00, '2024-10-04', '2024-10-04'),
(9, 9, '2024-10-05', 'General', 50.00, '2024-10-05', '2024-10-05'),
(10, 10, '2024-10-05', 'VIP', 100.00, '2024-10-05', '2024-10-05');

-- Inserts para la tabla `Employee`
INSERT INTO `Employee` (`EmployeeId`, `FirstName`, `LastName`, `JobTitle`, `HireDate`, `Email`, `Phone`, `Address`, `City`, `State`, `Country`, `PostalCode`) VALUES
(1, 'Juan', 'Rodríguez', 'Supervisor', '2020-02-15', 'juan.rodriguez@example.com', '321654987', 'Carrera 7', 'Bogotá', 'Cundinamarca', 'Colombia', '110111'),
(2, 'Laura', 'Mendoza', 'Operador', '2018-08-23', 'laura.mendoza@example.com', '852963741', 'Avenida 1', 'Medellín', 'Antioquia', 'Colombia', '050001'),
(3, 'Carlos', 'López', 'Mecánico', '2019-06-12', 'carlos.lopez@example.com', '951357486', 'Calle 10', 'Cali', 'Valle del Cauca', 'Colombia', '760001'),
(4, 'Marta', 'Santos', 'Cajera', '2017-04-05', 'marta.santos@example.com', '753159486', 'Calle 20', 'Barranquilla', 'Atlántico', 'Colombia', '080001'),
(5, 'Pedro', 'Díaz', 'Seguridad', '2021-10-01', 'pedro.diaz@example.com', '951357486', 'Calle 34', 'Bogotá', 'Cundinamarca', 'Colombia', '110111'),
(6,'Mariñis', "", 'Mascota','2000-01-01', "", "", "Amusement Park Juanchis", 'Bogotá','Cundinamarca','Colombia','681002');

-- Inserts para la tabla Eventos
INSERT INTO `Event` (EventId,Name,Description,EventDate,Price) VALUES
(1,'Cumpleaños','Cumpleaños para la hija de la empleada Laura Mendoza.','2019-08-11',60.00),
(2,'Funeral','Funeral a la mascota Mariñis del Amusement Park Juanchis.','2020-09-11',110.00),
(3,'Matrimonio','Matrimonio de la visitante Sofía Hernández con su esposa Juliana Numa','2024-10-05',10000.00),
(4,'Hackaton','Hackaton con la empresa asociada Gardenlands.','2024-12-07',5000.00);

-- Inserts para la tabla EmployeeEvent
INSERT INTO `EmployeeEvent` (EventId,EmployeeId) VALUES
(1,2),
(2,1),
(2,3);

-- Inserts para la tabla VisitorEvent
INSERT INTO `VisitorEvent` (VisitorId,EventId,TicketId) VALUES
(4,3,10),
(10,3,9),
(1,4,8),
(2,4,7),
(3,4,6),
(9,4,5),
(5,4,4),
(6,4,3),
(7,4,2),
(8,4,1);

-- Inserts para la tabla Maintenance
INSERT INTO `Maintenance` (MaintenanceId,AttractionId,EmployeeId,MaintenanceDate,Details) VALUES 
(1,6,1,"2024-10-10","Bien"),
(2,7,2,"2024-10-11","XYZ"),
(3,8,3,"2024-10-12","Loquesea"),
(4,9,4,"2024-10-13","Barbaro"),
(5,10,5,"2024-10-14","Siabueno");

-- Inserts para la tabla Visit
INSERT INTO `Visit` (VisitId,VisitorId,AttractionId,VisitDate,Rating,Comment) VALUES
(1,2,1,"2024-10-10",5,"Si"),
(2,4,3,"2024-09-10",5,"Bien."),
(3,6,5,"2024-07-10",5,"Me gustó"),
(4,8,6,"2024-06-10",5,"Final Feliz");