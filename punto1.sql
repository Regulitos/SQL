DROP DATABASE IF EXISTS almacen;
CREATE DATABASE almacen;
USE almacen;

CREATE TABLE articulos(
	id INT NOT NULL PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    fecha_compra DATE NOT NULL
);

INSERT INTO articulos VALUES(1020,"Coca-Cola","2023/05/19");
INSERT INTO articulos VALUES(1021,"Poker","2023/05/20");
INSERT INTO articulos VALUES(1022,"Ron","2023/04/19");
INSERT INTO articulos VALUES(1023,"Sandwich","2023/07/19");
SELECT * FROM articulos;

DROP PROCEDURE IF EXISTS prueba;
delimiter //
CREATE PROCEDURE  prueba()
BEGIN 
SELECT nombre FROM almacen.articulos;
END //
delimiter ;

CALL prueba();

DROP PROCEDURE IF EXISTS ArticulosComprados;
DELIMITER //
CREATE PROCEDURE ArticulosComprados(IN fecha_inicial DATE)
BEGIN 
    DECLARE fecha_fin DATE; 
    SET fecha_fin = DATE_ADD(fecha_inicial, INTERVAL 30 DAY);
    SELECT * FROM almacen.articulos WHERE fecha_compra BETWEEN fecha_inicial AND fecha_fin;
END //
DELIMITER ;

CALL ArticulosComprados('2023-05-01');

SELECT nombre, EXTRACT(DAY FROM fecha_compra) AS 'Dia', EXTRACT(MONTH FROM fecha_compra) AS 'Mes' FROM almacen.articulos;