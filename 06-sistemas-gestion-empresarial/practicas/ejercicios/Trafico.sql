```bash
--PRÁCTICA  MySQL
--Dada la base de datos TRAFICO, realizar las siguientes consultas: 


--CONDUCTOR (CODC, DNI, NOMBRE, EDAD, NACION)
--AGENTE (CODA, NOMBRE, RANGO)
--INFRACCION (CODI, DESCRIP, IMPORTE)
--DENUNCIA (CODD , FECHA, PAGADA, CODC, CODA, CODI)
--(NOTA: Puede haber conductores que nunca hayan sido denunciados y agentes que nunca hayan denunciado a ningún conductor. En los enunciados se utiliza indistintamente ‘denuncia’, ‘sanción’ o ‘multa’).

--1.- DNI y nombre de los conductores que tengan alguna multa.
SELECT DISTINCT dni, nombre
FROM conductor NATURAL JOIN denuncia;

--2.- DNI y nombre de los conductores que tengan alguna multa de menos de 200 euros sin pagar.
SELECT DISTINCT dni, nombre
FROM conductor NATURAL JOIN denuncia NATURAL JOIN infracción
WHERE importe < 200 AND pagada LIKE 'NO';

--3.- Código de los agentes que hayan puesto alguna multa de al menos 500 euros durante el mes de enero de 2018.
Select distinct coda
from denuncia natural join infracción
where importe >= 500
and fecha between “2018-01-01” and “2018-01-31”;

--4.- Código, nombre y nacionalidad de los conductores extranjeros, mayores de 40 años, que hayan sido sancionados por agentes cuyo nombre empieza y termina por A.
SELECT DISTINCT codc, conductor.nombre, nacion
FROM conductor NATURAL JOIN denuncia INNER JOIN agente ON denuncia.coda=agente.coda
WHERE nacion NOT LIKE 'española' AND edad > 40 AND agente.nombre LIKE 'asa';

--5.- Código, nombre y rango de los agentes que hayan sancionado a conductores españoles y franceses.
SELECT DISTINCT coda, agente.nombre, rango
FROM agente NATURAL JOIN denuncia INNER JOIN conductor ON denuncia.codc = conductor.codc
WHERE nacion LIKE 'esf%' or nacion LIKE 'fra%';

--6.- Código, nombre y rango de los agentes que hayan sancionado a conductores españoles y franceses (a ambos).
Select distinct coda, agente.nombre, rango
from agente natural join denuncia natural join conductor
where nacion = (select nacion from conductor where nacion in (“Española”, “Francesa”));

--7.- Código, nombre y edad  de los conductores que siempre hayan sido sancionados con multas superiores a 500 euros.
Select distinct codc, conductor.nombre, edad
from conductor inner join infraccion on infracción.coda = conductor.coda
where importe > 500
and codc not in (select codc from denuncia natural join infaccion where importe <= 500);

--8.- Código y nombre de los agentes que nunca hayan puesto una denuncia.
Select coda, nombre
from agente
where coda not in (select coda from denuncia);

--9.- DNI y nombre de los conductores que hayan cometido las infracciones descritas como estacionamiento prohibido y exceso de velocidad (ambas).
Select distinct dni, conductor.nombre
from conductor inner join infracción on conductor.coda = infracción.coda
where descripción = “exceso de velocidad”
and codc in (select codc from infracción natural join denuncia where descripción = “estacionamiento prohibido”);

--10.- DNI y nombre de los conductores que no tengan ninguna multa pendiente de pago.
Select dni, conductor.nombre
from conductor natural join denuncia
where codca not in (select codc from denuncia where pagada=”NO”);
--11.- Código y nombre de los agentes que solo hayan sancionado a conductores extranjeros.
SELECT DISTINCT coda, agente.nombre
FROM agente NATURAL JOIN denuncia INNER JOIN conductor ON denuncia.codc = conductor.codc
WHERE nacion NOT LIKE "española" AND coda NOT IN (SELECT coda
                                                    FROM denuncia NATURAL JOIN conductor
                                                    WHERE nacion LIKE "española");

--12.- Edad media de los conductores que tienen alguna multa.
SELECT ROUND(AVG(edad), 2) AS "edad media"
FROM (SELECT DISTINCT codc, edad
        FROM conductor NATURAL JOIN denuncia) AS edad_dist_contductores;

--13.- DNI y nombre de los conductores, de entre 20 y 30 años, que han sido multados por algún sargento, por exceso de velocidad, ordenados por nombre.
SELECT DISTINCT dni, conductor.nombre --Porque las tablas tienen nombres iguales por eso se pone
FROM conductor NATURAL JOIN denuncia NATURAL JOIN infraccion INNER JOIN agente ON denuncia.coda = agente.coda
WHERE conductor.edad BETWEEN 20 AND 40 AND rango LIKE "sargento" AND descripcion LIKE "exceso de velocidad"
ORDER BY conductor.nombre;

--14.- Edad del conductor más joven con alguna multa de más de 100€ sin pagar.
SELECT MIN(edad) AS "Edad del mas joven con multa sin pagar"
FROM conductor NATURAL JOIN denuncia NATURAL JOIN infraccion
WHERE importe > 100 AND pagada LIKE "no";

--15.- Importe máximo de las infracciones cometidas por conductores extranjeros.
SELECT MAX(importe) AS "Importe maximo"
FROM conductor NATURAL JOIN denuncia NATURAL JOIN infraccion
where nacion NOT LIKE "española";

--16.- Importe medio de las multas pagadas, puestas por cada agente, a conductores de más de 60 años, mostrando solo aquellas medias que superen los 300€.
SELECT coda, ROUND(AVG(importe), 2) AS media -- Sin comillas para poder utilizarlo despues
FROM denuncia NATURAL JOIN conductor NATURAL JOIN infraccion
WHERE pagada LIKE "si" AND edad > 60
HAVING media > 300;

--17.- Importe máximo de las multas pagadas por los conductores de cada nacionalidad.
SELECT nacion, MAX(imp_total) AS "maximo importe"
FROM (SELECT nacion, codc, SUM(importe) AS importe_total
        FROM conductor NATURAL JOIN denuncia NATURAL JOIN infraccion
        WHERE pagada LIKE "si"
        GROUP BY nacion, codc) AS tabla_sumas;
GROUP BY nacion

Select nacion, MAX(importe) AS maximo
from conductor NATURAL JOIN denuncia NATURAL JOIN infraccion
WHERE pagada LIKE "si"
GROUP BY nacion;

--18.- Total recaudado cada día por cada agente cuyo nombre contenga una A, mostrando solo aquellos totales que superen 300 €.
SELECT fecha, coda, SUM(importe) AS total
from agente NATURAL JOIN denuncia NATURAL JOIN infraccion
where nombre LIKE "a%"
GROUP BY fecha, coda
HAVING total > 300;

--19.- Número de multas de al menos 300€, puestas por cada agente que no sea sargento, a los conductores de cada nacionalidad de las siguientes: española, inglesa y francesa, mostrando solo el resultado cuando pase de 2 sanciones.
SELECT nacion, coda, COUNT(codd) AS multas
FROM agente NATURAL JOIN denuncia NATURAL JOIN infraccion INNER JOIN conductor on denuncia.coidc = conductor.codc
WHERE rango NOT LIKE "sargento" AND importe >= 300
GROUP BY nacion, coda
HAVING multas > 2;

--20.- Nacionalidades de conductores que tienen multas por exceso de velocidad impagadas.
 SELECT DISTINCT nacion
 FROM conductor NATURAL JOIN denuncia NATURAL JOIN infraccion
 WHERE pagada LIKE "no" AND descripcion LIKE "exceso de velocidad"

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--21.- Código y nombre de los conductores que han pagado alguna multa mayor que la media del importe de todas las multas pagadas.
SELECT DISTINCT codc, nombre
FROM conductor NATURAL JOIN denuncia NATURAL JOIN infraccion
WHERE pagada LIKE "si" AND importe > (SELECT AVG(importe)
                                        FROM denuncia NATURAL JOIN infraccion
                                        WHERE pagada LIKE "si");

--22.- Código, nombre y rango de los agentes que han multado por exceso de velocidad a conductores españoles y extranjeros (a ambos) de más de 50 años.
SELECT DISTINCT coda, agente.nombre, rango
FROM agente NATURAL JOIN denuncia NATURAL JOIN infraccion INNER JOIN conductor on denuncia.codc = conductor.codc
WHERE edad > 50 and descripcion LIKE "exceso de velocidad" AND nacion LIKE "española" AND coda  in(SELECT coda
                                                                                                    FROM denuncia NATURAL JOIN infraccion INNER JOIN conductor on denuncia.codc = conductor.codc
                                                                                                    WHERE edad > 50 and descripcion LIKE "exceso de velocidad" AND nacion NOT LIKE "española");

--23.- DNI, nombre y nacionalidad de los conductores que no han cometido ninguna infracción de más de 200 €.
SELECT conductor.dni, conductor.nombre, conductor.nacion
FROM conductor
WHERE conductor.codc NOT IN (SELECT denuncia.codc
                             FROM denuncia
                             INNER JOIN infraccion ON denuncia.codi = infraccion.codi
                             WHERE infraccion.importe > 200);

--24.- Edad media de los conductores que solo han sido multados por exceso de velocidad.
SELECT ROUND(AVG(conductor.edad), 2) AS edad_media
FROM conductor
WHERE conductor.codc IN (SELECT denuncia.codc FROM denuncia) AND conductor.codc NOT IN (SELECT denuncia.codc
                                                                                        FROM denuncia
                                                                                        INNER JOIN infraccion ON denuncia.codi = infraccion.codi
                                                                                        WHERE infraccion.descrip <> 'exceso de velocidad');

--25.- Importe máximo de las multas pagadas por los conductores de cada nacionalidad que hayan cometido infracciones en la misma fecha que FAUSTO.
SELECT conductor.nacion, MAX(infraccion.importe) AS max_importe
FROM conductor
INNER JOIN denuncia ON conductor.codc = denuncia.codc
INNER JOIN infraccion ON denuncia.codi = infraccion.codi
WHERE denuncia.pagada LIKE 'si' AND denuncia.fecha IN (SELECT denuncia.fecha
                                                        FROM denuncia
                                                        INNER JOIN conductor ON conductor.codc = denuncia.codc
                                                        WHERE conductor.nombre = 'FAUSTO')
GROUP BY conductor.nacion;

--26.- Total recaudado cada día por cada agente con el mismo rango del agente 48, mostrando solo aquellos totales que superen 500 €.
SELECT denuncia.fecha, agente.coda, SUM(infraccion.importe) AS total
FROM agente
INNER JOIN denuncia ON agente.coda = denuncia.coda
INNER JOIN infraccion ON denuncia.codi = infraccion.codi
WHERE agente.rango = (SELECT agente.rango 
                      FROM agente 
                      WHERE agente.coda = 48)
GROUP BY denuncia.fecha, agente.coda
HAVING total > 500;

--27.- Máxima cantidad total recaudada por un agente.
SELECT MAX(tabla_totales_por_agente.total) AS max_total_recaudado
FROM (SELECT agente.coda AS coda_agente, SUM(infraccion.importe) AS total
      FROM agente
      INNER JOIN denuncia ON agente.coda = denuncia.coda
      INNER JOIN infraccion ON denuncia.codi = infraccion.codi
      GROUP BY agente.coda) AS tabla_totales_por_agente;

--28.- Añadir a la consulta anterior el código del agente que recaudó ese máximo.
SELECT agente.coda, SUM(infraccion.importe) AS total_recaudado
FROM agente
INNER JOIN denuncia ON agente.coda = denuncia.coda
INNER JOIN infraccion ON denuncia.codi = infraccion.codi
GROUP BY agente.coda
ORDER BY total_recaudado DESC
LIMIT 1;

--29.- DNI, nombre y nacionalidad de todos los conductores y descripción de las infracciones que han cometido (incluyendo los datos de aquellos que no tienen multas).
SELECT conductor.dni, conductor.nombre, conductor.nacion, infraccion.descrip
FROM conductor
LEFT JOIN denuncia ON conductor.codc = denuncia.codc
LEFT JOIN infraccion ON denuncia.codi = infraccion.codi;

--30.- Todos los datos de todos los agentes y de las denuncias que han puesto(incluyendo los datos de aquellos que no han sancionado a nadie).
SELECT agente.*, denuncia.*
FROM agente
LEFT JOIN denuncia ON agente.coda = denuncia.coda;

--31.- Código, nombre y edad de todos los conductores, descripción e importe de las infracciones que han cometido y código, nombre y rango de los agentes implicados(incluyendo, a continuación, los datos de aquellos conductores que no tienen multas).
SELECT conductor.codc, conductor.nombre AS nombre_conductor, conductor.edad, infraccion.descrip, infraccion.importe, agente.coda, agente.nombre AS nombre_agente, agente.rango
FROM conductor
LEFT JOIN denuncia ON conductor.codc = denuncia.codc
LEFT JOIN infraccion ON denuncia.codi = infraccion.codi
LEFT JOIN agente ON denuncia.coda = agente.coda
ORDER BY (denuncia.codd IS NULL), conductor.codc;
```