**Autor/a:** Cesar

```sql
```bash
--1)
SELECT COD_T, NOM, ROUND(AVG(PAGS), 2) AS "MEDIA DEL N DE PAGINAS"
FROM LIBRO 
NATURAL JOIN TEMPA
WHERE GENERO = "CUENTO" AND ANIO = 2010
GROUP BY COD_T
HAVING AVG(PAGS) <= 300;

--2)
SELECT DISTINCT COD_A, AUTOR.NOM, APEL
FROM AUTOR 
NATURAL JOIN LIBRO
INNER JOIN TEMA ON LIBRO.COD_T = TEMA.COD_T
WHERE SEXO = "M" AND NACION <> "ESPAÑOLA" AND PAGS > 200 AND TEMA.NOM AND COD_A IN (SELECT COD_A
                                                                                    FROM LIBRO
                                                                                    NATURAL JOIN TEMA
                                                                                    WHERE PAGS > 200 AND TEMA.NOM = "FILOSOFIA")
                                                                       AND COD_A IN(SELECT COD_A
                                                                                    FROM LIBRO
                                                                                    NATURAL JOIN TEMA
                                                                                    WHERE PAGS > 200 AND TEMA.NOM = "LITERATURA");

--3)
SELECT ISBN, TITULO, COD_A
FROM LIBRO
NATURAL JOIN TEMA
WHERE NOM = "HISTORIA" AND PAGS > (SELECT MAX(PAGS) AS "MAXIMO DE PAGINAS DE HISTORIA"
                                    FROM LIBRO
                                    NATURAL JOIN TEMA
                                    INNER JOIN AUTOR ON LIBRO.COD_A = AUTOR.COD_A
                                    WHERE TEMA.NOM = "GEOGRAFIA" AND AUTOR.EDAD = (SELECT MAX(EDAD) AS "EDAD MAS ALTA DE LOS AUTORES")
                                                                                    FROM AUTOR
                                                                                    WHERE NACION = "ESPAÑOLA");

--4)
SELECT SUM(PAGS) AS "NUMERO TOTAL DE PAGINAS", COUNT(COD_L) AS "NUERO DE NOVELAS"
FROM LIBRO
NATURAL JOIN AUTOR
WHERE GENERO = "NOVELA" AND ANIO = 2010 AND SEXO = (SELECT SEXO
                                                    FROM AUTOR
                                                    WHERE NOM = "FRANCIS" APEL = "LUNA PALACIOS")
                                        AND EDAD = (SELECT EDAD
                                                    FROM AUTOR
                                                    WHERE NOM = "FRANCIS" APEL = "LUNA PALACIOS")
                                        AND NACION = (SELECT NACION
                                                    FROM AUTOR
                                                    WHERE NOM = "FRANCIS" APEL = "LUNA PALACIOS");

--5)
SELECT COD_A, NOM, APEL
FROM AUTOR
WHERE NACION <> "ESPAÑOLA" AND COD_A NOT IN (SELECT COD_A
                                            FROM LIBRO
                                            WHERE GENERO IN ("NOVELA", "CUENTO"));

--6)
SELECT ANIO, TEMA.NOM, MIN(EDAD) AS "EDAD DEL AUTOR MAS JOVEN"
FROM AUTOR NATURAL JOIN LIBRO
INNER JOIN TEMA ON LIBRO.COD_T = TEMA.COD_T
WHERE TEMA.NOM IN ("CIENCIA", "LITERATURA", "VIAJES", "HISTORIA") AND NACION "ESPAÑOLA"
GROUP BY ANIO, TEMA.COD_T
HAVING MIN(EDAD) BETWEEN (35, 45) OR EDAD < 25;

--7)
SELEC COD_A, NOM, APEL, TÍTULO 
FROM AUTOR 
LEFT JOIN LIBRO ON AUTOR. COD_A=LIBRO.COD_A;
```
```
