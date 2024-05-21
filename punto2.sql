DROP DATABASE IF EXISTS dbEstudiantes;

CREATE DATABASE dbEstudiantes;
USE dbEstudiantes;

CREATE TABLE Estudiante(
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(45),
    documento VARCHAR(15) UNIQUE,
    celular BIGINT
);

CREATE TABLE Materia(
	id INT NOT NULL primary KEY auto_increment,
    nombre VARCHAR(30),
    creditos INT NOT NULL
);

CREATE TABLE Nota(
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    Estudiante_id INT,
    Materia_id INT,
    Nota FLOAT NOT NULL,
    FOREIGN KEY (Estudiante_id) REFERENCES Estudiante(id),
    FOREIGN KEY (Materia_id) REFERENCES Materia(id)
);


INSERT INTO Estudiante values(null,"Alexander Fleming","154234","3003341544");
INSERT INTO Estudiante values(null,"Manuel Elkin Patarroyo","154235","3003341575");
INSERT INTO Estudiante values(null,"Albert Einstein","154236","3003341584");
INSERT INTO Estudiante values(null,"Sigmund Freud","132178","3003347845");

INSERT INTO Materia values(null,"Musica",2);
INSERT INTO Materia values(null,"Fisica",7);
INSERT INTO Materia values(null,"Astronomia",5);
INSERT INTO Materia values(null,"Matematicas",6);
INSERT INTO Materia values(null,"Biologia",4);
INSERT INTO Materia values(null,"Quimica",4);
INSERT INTO Materia values(null,"Escritura",3);

INSERT INTO Nota values(null,2,5,4.7);
INSERT INTO Nota values(null,1,5,5.0);
INSERT INTO Nota values(null,3,2,5.0);
INSERT INTO Nota values(null,1,6,4.2);
INSERT INTO Nota values(null,3,4,5.0);

DROP procedure IF EXISTS uspPromedioEstudiante


DELIMITER $$
CREATE PROCEDURE uspPromedioEstudiante(IN estudiante_id INT)
BEGIN
    DECLARE estudiante_nombre VARCHAR(45);
    DECLARE estudiante_documento VARCHAR(15);
    DECLARE total_creditos INT;
    DECLARE pca FLOAT;

    -- Obtener el nombre y el número de documento del estudiante
    SELECT nombre, documento INTO estudiante_nombre, estudiante_documento
    FROM Estudiante
    WHERE id = estudiante_id;

    -- Calcular la sumatoria de los créditos de las materias que ha tomado el estudiante
    SELECT SUM(creditos) INTO total_creditos
    FROM Materia
    INNER JOIN Nota ON Materia.id = Nota.Materia_id
    WHERE Nota.Estudiante_id = estudiante_id;

    -- Calcular el PCA del estudiante
    SELECT SUM(Nota.Nota * Materia.creditos) INTO pca
    FROM Materia
    INNER JOIN Nota ON Materia.id = Nota.Materia_id
    WHERE Nota.Estudiante_id = estudiante_id;

    -- Dividir la sumatoria de los productos entre la sumatoria de los créditos
    SET pca = pca / total_creditos;
    
    SELECT estudiante_nombre AS 'Nombre del estudiante', estudiante_documento AS 'Número de documento', pca AS 'Promedio crédito acumulado';
END $$
DELIMITER ;

CALL uspPromedioEstudiante(1);

SELECT e.id, e.nombre
FROM Estudiante e
LEFT JOIN Nota n ON e.id = n.Estudiante_id
WHERE n.id IS NULL;

SELECT e.nombre AS `Nombre del estudiante`, CalculatedPCA.pca AS `Mejor PCA`
FROM Estudiante e
INNER JOIN (
    SELECT Nota.Estudiante_id, SUM(Nota.Nota * Materia.creditos) / SUM(Materia.creditos) AS pca
    FROM Nota
    INNER JOIN Materia ON Nota.Materia_id = Materia.id
    GROUP BY Nota.Estudiante_id
) AS CalculatedPCA ON e.id = CalculatedPCA.Estudiante_id
WHERE CalculatedPCA.pca = (
    SELECT MAX(pca) 
    FROM (
        SELECT SUM(Nota.Nota * Materia.creditos) / SUM(Materia.creditos) AS pca
        FROM Nota
        INNER JOIN Materia ON Nota.Materia_id = Materia.id
        GROUP BY Nota.Estudiante_id
    ) AS MaxPCA
);



