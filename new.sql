DROP DATABASE IF EXISTS peliculas;
CREATE DATABASE peliculas;
USE peliculas;

CREATE TABLE distribution_companies (
    id INT NOT NULL AUTO_INCREMENT,
    company_names VARCHAR(45) NULL,
    PRIMARY KEY (id)
);

CREATE TABLE movies (
	id INT NOT NULL AUTO_INCREMENT,
    movie_title VARCHAR(45) NOT NULL,
    imdb_rating INT NOT NULL,
    year_released INT NOT NULL,
    budget INT NOT NULL,
    box_office INT NOT NULL,
    `language` VARCHAR(45) NOT NULL,
    company_distribution INT NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_company_distribution
    FOREIGN KEY (company_distribution) 
    REFERENCES distribution_companies(id)
);

INSERT INTO distribution_companies (`id`,`company_names`) VALUES ('1','Columbia Pictures');
INSERT INTO distribution_companies (`id`,`company_names`) VALUES (null,'Paramount Pictures');
INSERT INTO distribution_companies (`id`,`company_names`) VALUES (null,'Warner Bros Pictures');
INSERT INTO distribution_companies (`id`,`company_names`) VALUES (null,'United Artists');
INSERT INTO distribution_companies (`id`,`company_names`) VALUES (null,'Universal Pictures');
INSERT INTO distribution_companies (`id`,`company_names`) VALUES (null,'New Line Cinema');
INSERT INTO distribution_companies (`id`,`company_names`) VALUES (null,'Miramax Films');
INSERT INTO distribution_companies (`id`,`company_names`) VALUES (null,'Buena Vista');
INSERT INTO distribution_companies (`id`,`company_names`) VALUES (null,'Studio Universal');


INSERT INTO movies (`id`,`movie_title`,`imdb_rating`,`year_released`,`budget`,`box_office`,`language`,`company_distribution`) VALUES (null,'The Shawshank Redemption','11','1994','25','73','English',1);
INSERT INTO movies (`id`,`movie_title`,`imdb_rating`,`year_released`,`budget`,`box_office`,`language`,`company_distribution`) VALUES (null,'The God Father','9','1972','70','291','English',2);
INSERT INTO movies (`id`,`movie_title`,`imdb_rating`,`year_released`,`budget`,`box_office`,`language`,`company_distribution`) VALUES (null,'The Dark Night','9','2008','185','1006','English',3);
INSERT INTO movies (`id`,`movie_title`,`imdb_rating`,`year_released`,`budget`,`box_office`,`language`,`company_distribution`) VALUES (null,'The God Father II','9','1974','13','2','English',2);
INSERT INTO movies (`id`,`movie_title`,`imdb_rating`,`year_released`,`budget`,`box_office`,`language`,`company_distribution`) VALUES (null,'Schindler´s List','8','1993','22','322','German',4);
INSERT INTO movies (`id`,`movie_title`,`imdb_rating`,`year_released`,`budget`,`box_office`,`language`,`company_distribution`) VALUES (null,'Pulp Fiction','8','1994','85','213','English',5);
INSERT INTO movies (`id`,`movie_title`,`imdb_rating`,`year_released`,`budget`,`box_office`,`language`,`company_distribution`) VALUES (null,'The Lord Of the Rings','8','2001','93','898','English',6);
INSERT INTO movies (`id`,`movie_title`,`imdb_rating`,`year_released`,`budget`,`box_office`,`language`,`company_distribution`) VALUES (null,'The Good, the Bad and the Ugly','10','1966','2','38','Spanish',7);

/*Ejercicio 1. Seleccionar todas las columnas de una tabla*/
SELECT*FROM distribution_companies;

/*Ejercicio 2. Selección de algunas columnas de una tabla*/
SELECT movie_title, imdb_rating, year_released FROM movies;

/*Ejercicio 3. Selección de unas pocas columnas y filtrado de datos numéricos en WHERE*/
SELECT movie_title, box_office FROM movies WHERE box_office > 300;

/*Ejercicio4. Selección de unas pocas columnas y filtrado de datos de texto en WHERE.*/
SELECT 
	movie_title,
    imdb_rating,
    year_released
FROM movies
WHERE movie_title LIKE '%God Father%';

/*Ejercicio 5: Selección de unas pocas columnas y filtrado de datos mediante dos condiciones en
WHERE*/
SELECT 
	movie_title,
    imdb_rating,
    year_released
FROM movies
WHERE year_released < 2001 AND imdb_rating >9;

/*Ejercicio 6: Filtrado de datos mediante WHERE y ordenación de la salida*/
SELECT movie_title, imdb_rating, year_released
FROM movies WHERE year_released > 1991
ORDER BY year_released ASC;

/*Ejercicio 7: Agrupación de datos por una columna. Mostrar el recuento de películas por cada categoría
de idioma.*/
SELECT
	language,
    COUNT(*) AS number_of_movies
FROM movies
GROUP BY language;
/*Explicación de la solución: Seleccione la columna language de la tabla movies. Para contar el número
de películas, utilice la función agregada COUNT(). Utilice el asterisco (*) para contar las filas, lo que
equivale al recuento de películas. Para dar un nombre a esta columna, utilice la palabra clave AS
seguida del nombre deseado. Para mostrar el recuento por idioma, necesita agrupar los datos por él, así
que escriba la columna language en la cláusula GROUP BY.*/

/*Ejercicio 8: Agrupación de Datos por Varias Columnas*/
SELECT 
	year_released,
    language,
    COUNT(*) AS numbres_of_movies
FROM movies
GROUP BY year_released, language
ORDER BY year_released ASC;
/*Explicación de la solución: Enumerar las columnas year_released y language de la tabla movies en
SELECT. Utilice COUNT(*) para contar el número de películas y asigne un nombre a esta columna
utilizando la palabra clave AS. Especifique las columnas por las que desea agrupar en la cláusula
GROUP BY. Separe cada nombre de columna con una coma. Ordene la salida utilizando ORDER BY
con la columna year_released y la palabra clave ASC.
*/

/*Ejercicio 9: Filtrado de Datos Después de Agrupar. Mostrar los idiomas hablados y el presupuesto
medio de las películas por categoría de idioma. Mostrar sólo los idiomas con un presupuesto medio
superior a 50 millones de dólares.
*/
SELECT
	language,
    AVG(budget) AS movie_budget
FROM movies
GROUP by language
HAVING AVG(budget) > 50;
/*Explicación de la solución: Seleccione la columna language de la tabla movies. Para calcular el
presupuesto medio, utilice la función de agregado AVG() con la columna presupuesto entre paréntesis.
Nombre la columna en la salida utilizando la palabra clave AS. Agrupe los datos por clasificación
utilizando GROUP BY. Para filtrar los datos después de agruparlos, utilice una cláusula HAVING. En
ella, utilice la misma construcción AVG() que en SELECT y establezca que los valores sean superiores
a 50 utilizando el operador "mayor que".
*/

/*Ejercicio 10: Selección de Columnas de Dos Tablas. Mostrar títulos de películas de la tabla movies,
cada uno con el nombre de su distribuidora.*/
SELECT
	movie_title,
	company_names
FROM peliculas.distribution_companies dc
JOIN peliculas.movies m 
ON dc.id = m.company_distribution

/*Explicación de la solución: Enumerar las columnas movie_title y company_name en SELECT. En la
cláusula FROM, hacer referencia a la tabla distribution_companies. Dele un alias dc para acortar su
nombre y poder utilizarlo más adelante. La palabra clave AS se omite aquí; puede utilizarla si lo desea.
Para acceder a los datos de la otra tabla, utilice JOIN (también puede escribirse como INNER JOIN) y
escriba el nombre de la tabla a continuación. Asigne también un alias a esta tabla. La unión utilizada
aquí es una unión de tipo interno; sólo devuelve las filas que cumplen la condición de unión
especificada en la cláusula ON. Las tablas se unen cuando la columna id de la
tabladistribution_companies es igual a la columna distribution_company_id de la tabla movies. Para
especificar qué columna procede de qué tabla, utilice el alias correspondiente de cada tabla.*/
