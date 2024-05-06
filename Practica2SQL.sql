DROP DATABASE IF EXISTS `tienda`;
CREATE DATABASE `tienda` CHARACTER SET utf8mb4; 
USE `tienda`;
CREATE TABLE `fabricante` (
 `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 `nombre` VARCHAR(100) NOT NULL
);

CREATE TABLE `producto` (
`id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
`nombre` VARCHAR(100) NOT NULL,
`precio` DOUBLE NOT NULL,
`id_fabricante` INT UNSIGNED NOT NULL,
FOREIGN KEY (`id_fabricante`) REFERENCES `fabricante` (`id`)
);


INSERT INTO `fabricante` VALUES (1,'Asus');
INSERT INTO `fabricante` VALUES (2,'Lenovo');
INSERT INTO `fabricante` VALUES (3,'Hewlett-Packard');
INSERT INTO `fabricante` VALUES (4,'Samsung');
INSERT INTO `fabricante` VALUES (5,'Seagate');
INSERT INTO `fabricante` VALUES (6,'Crucial');
INSERT INTO `fabricante` VALUES (7,'Gigabyte');
INSERT INTO `fabricante` VALUES (8, 'Huawei');
INSERT INTO `fabricante` VALUES (9, 'Xiaomi');

INSERT INTO `producto` VALUES (1, 'Disco duro SATA3 1TB', 86.99, 5);
INSERT INTO `producto` VALUES (2, 'Memoria RAM DDR4 8GB', 120, 6);
INSERT INTO `producto` VALUES (3, 'Disco SSD 1 TB', 150.99, 4);
INSERT INTO `producto` VALUES (4, 'GeForce GTX 1050Ti', 185, 7);
INSERT INTO `producto` VALUES (5, 'GeForce GTX 1080 Xtreme', 755, 6);
INSERT INTO `producto` VALUES (6, 'Monitor 24 LED Full HD', 202, 1);
INSERT INTO `producto` VALUES (7, 'Monitor 27 LED Full HD', 245.99, 1);
INSERT INTO `producto` VALUES (8, 'Portátil Yoga 520', 559, 2);
INSERT INTO `producto` VALUES (9, 'Portátil Ideapd 320', 444, 2);
INSERT INTO `producto` VALUES (10, 'Impresora HP Deskjet 3720', 59.99, 3);
INSERT INTO `producto` VALUES (11, 'Impresora HP Laserjet Pro M26nw', 180, 3);

SELECT `nombre` FROM `producto`;
SELECT `nombre`, `precio` FROM `producto`;
SELECT * FROM `producto`;
SELECT `nombre`,`precio`,`precio`*1.15 FROM `producto`;
SELECT `nombre`AS 'NOMBRE DE PRODUCTO', `precio` AS EUROS, `precio`*1.15 AS DOLARES FROM producto;
SELECT UPPER (nombre) AS 'UPPER(NOMBRE)', precio FROM producto;
SELECt LOWER(nombre) AS 'LOWER(NOMBRE)', precio FROM producto;
SELECT nombre, UPPER((SUBSTR(NOMBRE,1,2))) FROM fabricante;
SELECT nombre, ROUND(precio,0) AS 'Precio Redondeado' FROM producto;
SELECT nombre, TRUNCATE(precio,0) AS 'Precio Truncado' FROM producto;
SELECT id_fabricante FROM producto AS pd JOIN fabricante AS fab ON fab.id=pd.id_fabricante;
SELECT DISTINCT id_fabricante FROM producto AS pd JOIN fabricante AS fab ON fab.id = pd.id_fabricante;
SELECT nombre FROM fabricante ORDER BY nombre ASC;
SELECT nombre FROM fabricante ORDER BY nombre DESC;
SELECT nombre, precio FROM producto ORDER BY nombre ASC,precio DESC;
SELECT * FROM fabricante LIMIT 5 OFFSET 0;
SELECT * FROM fabricante LIMIT 5;
SELECT * FROM fabricante LIMIT 2 OFFSET 3;
SELECT nombre, precio FROM producto ORDER BY precio ASC LIMIT 1;
SELECT nombre, precio FROM producto ORDER BY precio DESC LIMIT 1;
SELECT nombre FROM producto WHERE id_fabricante=2;
SELECT nombre FROM producto WHERE precio<=120;
SELECT nombre FROM producto WHERE precio>=400;
SELECT nombre FROM producto WHERE precio<400;
SELECT * FROM producto WHERE precio>=80 AND precio <=300;
SELECT * FROM producto WHERE precio BETWEEN 60 AND 250;
SELECT * FROM producto WHERE precio>200 AND id_fabricante=6;
SELECT * FROM producto WHERE id_fabricante=1 OR id_fabricante=3 OR id_fabricante=5;
SELECT * FROM producto WHERE nombre IN ('GeForce GTX 1050Ti','Disco duro SATA3 1TB','Impresora') ;
SELECT nombre,precio*100 AS 'centimos hoy'  FROM producto;
SELECT nombre FROM fabricante WHERE nombre LIKE 'S%';
SELECT nombre FROM fabricante WHERE nombre LIKE '%e';
SELECT nombre FROM fabricante WHERE nombre LIKE '%w%';
SELECT nombre FROM fabricante WHERE nombre LIKE '____';
SELECT nombre FROM producto WHERE nombre LIKE 'Portátil%';
SELECT nombre,precio FROM producto WHERE nombre LIKE 'Monitor%' AND precio<215;
SELECT nombre, precio FROM producto WHERE precio >= 180 ORDER BY precio DESC, nombre ASC;