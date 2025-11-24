SELECT nombre 
FROM clientes 
WHERE nombre LIKE 'P%';
-- Busca los nombres que empiecen por P

SELECT nombre 
FROM clientes 
WHERE nombre LIKE '%o';
-- Busca los nombres que terminen por o

SELECT metros_cuadrados 
FROM clientes 
WHERE metros_cuadrados BETWEEN 200 AND 1000;
-- Busca los metros_cuadrados entre 200 y 1000

SELECT metros_cuadrados 
FROM clientes 
WHERE metros_cuadrados >200 
AND metros_cuadrados< 800;
-- Busca los metros_cuadrados entre 200 y 800, es igual que BETWEEN pero con otra lógica

ALTER TABLE presupuestos
ADD COLUMN id_clientes INT;
-- Crea columnas nuevas

ALTER TABLE presupuestos
ADD CONSTRAINT id_clientes
FOREIGN KEY (id_clientes)
REFERENCES clientes(id_clientes);
-- Da FOREIGN KEY a un atributo ya creado

SELECT 
    infestacion,
    nombre AS plaga,
    id_clientes AS cliente,
 
    -- infestación > 95 → devuelve SI o NO
    CASE 
        WHEN infestacion > 95 THEN 'RIESGO para la salud: IMPORTANTE'
        ELSE 'Riesgo moderado'
    END AS infestacion_grave,
 
    -- peligro ALTO si infestación > 95
    CASE
        WHEN infestacion > 95 THEN 'Urgencia de tratamiento: ALTO'
        ELSE 'Urgencia: MEDIA'
    END AS peligro
 
FROM plagas
WHERE nombre LIKE '%cucaracha%';

-- Filtra por por el valor de infestación y cambia el texto indicando el riesgo y la urgencia

SELECT 
    nombre AS infestacion,          -- aquí mostramos el nombre en la columna "infestacion"
    nombre AS plaga,
    id_clientes AS cliente,
    infestacion AS nivel_infestacion,   -- aquí guardamos el número real de infestación
 
    CASE 
        WHEN infestacion > 95 THEN 'Riesgo para la salud: IMPORTANTE'
        ELSE 'Riesgo moderado'
    END AS infestacion_grave,
 
    CASE
        WHEN infestacion > 95 THEN 'Urgencia de tratamiento: ALTO'
        ELSE 'Urgencia: MEDIA'
    END AS peligro
-- Filtra por por el valor de infestación y cambia el texto indicando el riesgo y la urgencia
FROM plagas
WHERE nombre LIKE '%cucaracha%';


SELECT ROUND (AVG(precio),2) AS media_tratamientos 
FROM presupuestos;
-- Calcula la media y redondea el precio a 2 decimales

SELECT SUM(precio) FROM presupuestos;
-- Suma el precio total de los presupuestos
SELECT ROUND(SUM(precio))FROM presupuestos;
-- Suma el precio total de los presupuestos sin decimales

SELECT MAX(precio) AS tratamiento_mayor_coste
FROM presupuestos;
-- Busca el valor máximo en la columna precio y cambia el nombre a tratamiento de mayor coste
SELECT MIN(precio) AS tratamiento_mayor_coste
FROM presupuestos;
-- Busca el valor mínimo en la columna precio y cambia el nombre a tratamiento de mayor coste

SELECT nombre, COUNT(*) AS total
FROM tratamientos
GROUP BY nombre;
-- Busca por nombres, cuenta cuantos hay e indica el total de cada uno repetido
SELECT nombre, COUNT(*) AS total, SUM(duracion) AS tiempo_trabajo_minutos
FROM tratamientos
GROUP BY nombre;
-- Igual, pero añade el tiempo del trabajo

SELECT plagas.nombre AS plagas,
       clientes.nombre AS clientes
FROM plagas
INNER JOIN clientes
       ON plagas.id_clientes;
-- Muestra todas las plagas con cada uno de los clientes. Tengo 4 plagas y 4 clientes y me aparecen 16 resultados.

SELECT plagas.nombre AS plagas,
       
       clientes.nombre AS clientes
FROM plagas
INNER JOIN clientes
       ON plagas.id_clientes =clientes.id_clientes;
-- Muestra todas las plagas relacionadas con cada uno de los clientes

SELECT plagas.nombre AS plagas,
       clientes.nombre AS clientes,
       tratamientos.nombre AS tratamientos
FROM presupuestos
INNER JOIN clientes
       ON presupuestos.id_clientes =clientes.id_clientes
INNER JOIN plagas
       ON presupuestos.id_plagas=plagas.id_plagas
INNER JOIN tratamientos
       ON presupuestos.id_tratamientos=tratamientos.id_tratamientos;

-- Muestra los datos de nombre de clientes, plagas y tratamientos trayendolo desde sus correspodientes tablas y las muestra desde la tabla presupuestos

SELECT plagas.nombre AS plagas,
       clientes.nombre AS clientes,
       tratamientos.nombre AS tratamientos,
       tratamientos.repeticiones AS revisiones,
       tratamientos.duracion AS tiempo_trabajo_minutos,
       precio,
      ROUND(( presupuestos.precio/tratamientos.repeticiones),2) AS precio_por_trabajo,
      ROUND(( presupuestos.precio/tratamientos.duracion),2) AS precio_por_minuto
     
       
FROM presupuestos

INNER JOIN clientes
       ON presupuestos.id_clientes =clientes.id_clientes
INNER JOIN plagas
       ON presupuestos.id_plagas=plagas.id_plagas
INNER JOIN tratamientos
       ON presupuestos.id_tratamientos=tratamientos.id_tratamientos;

-- Lo mismo que la anterior, pero dividimos el precio entre las repeticiones para calcular el precio por trabajo y dividimos el precio por duracion y obtenemos el precio por minuto

SELECT plagas.nombre AS plagas,
       clientes.nombre AS clientes,
       tratamientos.nombre AS tratamientos,
       tratamientos.repeticiones AS revisiones,
       tratamientos.duracion AS tiempo_trabajo_minutos,
       tratamientos.plazo_seguridad,
       precio AS precio_€,
      ROUND(( presupuestos.precio/tratamientos.repeticiones),2) AS precio_por_trabajo_€,
      ROUND(( presupuestos.precio/tratamientos.duracion),2) AS precio_por_minuto_€
     
       
FROM presupuestos

INNER JOIN clientes
       ON presupuestos.id_clientes =clientes.id_clientes
INNER JOIN plagas
       ON presupuestos.id_plagas=plagas.id_plagas
INNER JOIN tratamientos
       ON presupuestos.id_tratamientos=tratamientos.id_tratamientos  
ORDER BY `precio_por_trabajo_€` DESC
-- Añadimos ordenador por precio descendente

SELECT 

	   plagas.nombre AS plagas,
       clientes.nombre AS clientes,
       tratamientos.nombre AS tratamientos,
       tratamientos.repeticiones AS revisiones,
       tratamientos.duracion AS tiempo_trabajo_minutos,
       precio AS precio_€,
       (CASE WHEN tratamientos.plazo_seguridad = 1 THEN 'Sí' ELSE 'No' END) AS plazo_seguridad,
      ROUND(( presupuestos.precio/tratamientos.repeticiones),2) AS precio_por_trabajo_€,
      ROUND(( presupuestos.precio/tratamientos.duracion),2) AS precio_por_minuto_€
     
       
FROM presupuestos

INNER JOIN clientes
       ON presupuestos.id_clientes =clientes.id_clientes
INNER JOIN plagas
       ON presupuestos.id_plagas=plagas.id_plagas
INNER JOIN tratamientos
       ON presupuestos.id_tratamientos=tratamientos.id_tratamientos  
ORDER BY `precio_por_trabajo_€` DESC;

-- CASE WHEN - THEN ELSE aqui ponemos un caso y si se cumple cambia el booleano de un numeroa un texto indicado, en este caso "Sí" o "No"