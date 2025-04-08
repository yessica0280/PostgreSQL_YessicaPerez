CREATE TABLE producto (
	codigo INT,
	nombre VARCHAR(100),
	precio NUMERIC,
	codigo_fabricante INT
);

CREATE TABLE fabricante (
	codigo INT,
    nombre VARCHAR(100)
);

INSERT INTO producto VALUES(1, 'Disco duro SATA3 1TB', 86.99, 5),
(2, 'Memoria RAM DDR4 8GB', 120, 6),
(3, 'Disco SSD 1 TB', 150.99, 4),
(4, 'GeForce GTX 1050Ti', 185, 7),
(5, 'GeFroce GTX 1080 Xtreme', 755, 6),
(6, 'Monitor 24 LED Full HD', 202, 1),
(7, 'Monitor 27 LED Full HD', 245.99, 1),
(8, 'Portátil Yoga 520', 559, 2),
(9, 'Portátil Ideapd 320', 444, 2),
(10, 'Impresora HP Deskjet 3720', 59.99, 3),
(11, 'Impresora HP Laserjet Pro M26nw', 180, 3);

INSERT INTO fabricante VALUES(1, 'Asus'),
(2, 'Lenovo'),
(3, 'Hewlett-Packard'),
(4, 'Samsung'),
(5, 'Seagate'),
(6, 'Crucial'),
(7, 'Gigabyte'),
(8, 'Huawei'),
(9, 'Xiaomi');

-- 1. Lista el nombre de todos los productos que hay en la tabla producto.
SELECT nombre FROM producto

-- 2. Lista los nombres y los precios de todos los productos de la tabla producto.
SELECT nombre, precio from producto

-- 3. Lista todas las columnas de la tabla producto.
select * from producto

-- 4. Lista el nombre de los productos, el precio en euros y el precio en dólares
-- estadounidenses (USD).
select nombre, precio as "precio en euros", precio * 1.1 as "precio en dolares" from producto

-- 5. Lista el nombre de los productos, el precio en euros y el precio en dólares
-- estadounidenses (USD). Utiliza los siguientes alias para las columnas: nombre
-- de producto, euros, dólares.


-- 6. Lista los nombres y los precios de todos los productos de la tabla producto,
-- convirtiendo los nombres a mayúscula.
select upper(nombre), precio from producto

-- 7. Lista los nombres y los precios de todos los productos de la tabla producto,
-- convirtiendo los nombres a minúscula.
select lower(nombre), precio from producto

-- 8. Lista el nombre de todos los fabricantes en una columna, y en otra columna
-- obtenga en mayúsculas los dos primeros caracteres del nombre del
-- fabricante.
select nombre, upper(substring(nombre, 1, 2)) from fabricante

-- 9. Lista los nombres y los precios de todos los productos de la tabla producto,
-- redondeando el valor del precio.
select nombre, round(precio) from producto

-- 10. Lista los nombres y los precios de todos los productos de la tabla producto,
-- truncando el valor del precio para mostrarlo sin ninguna cifra decimal.
select nombre, trunc(precio) from producto

-- 11. Lista el identificador de los fabricantes que tienen productos en la
-- tabla producto.
select codigo_fabricante from producto

-- 12. Lista el identificador de los fabricantes que tienen productos en la
-- tabla producto, eliminando los identificadores que aparecen repetidos.
select distinct codigo_fabricante from producto

-- 13. Lista los nombres de los fabricantes ordenados de forma ascendente.
select nombre from fabricante order by nombre asc

-- 14. Lista los nombres de los fabricantes ordenados de forma descendente.
select nombre from fabricante order by nombre desc

-- 15. Lista los nombres de los productos ordenados en primer lugar por el
-- nombre de forma ascendente y en segundo lugar por el precio de forma
-- descendente.
select nombre, precio from producto order by nombre asc, precio desc

-- 16. Devuelve una lista con las 5 primeras filas de la tabla fabricante.
select * from fabricante limit 5

-- 17. Devuelve una lista con 2 filas a partir de la cuarta fila de la tabla fabricante.
-- La cuarta fila también se debe incluir en la respuesta.
select * from fabricante offset 3 limit 2

-- 18. Lista el nombre y el precio del producto más barato. (Utilice solamente las
-- cláusulas ORDER BY y LIMIT).
select nombre, precio from producto order by precio asc limit 1

-- 19. Lista el nombre y el precio del producto más caro. (Utilice solamente las
-- cláusulas ORDER BY y LIMIT).
select nombre, precio from producto order by precio desc limit 1

-- 20. Lista el nombre de todos los productos del fabricante cuyo identificador de
-- fabricante es igual a 2.
select nombre from producto where codigo_fabricante = 2

-- 21. Lista el nombre de los productos que tienen un precio menor o igual a 120€.
select nombre, precio from producto where precio <= 120

-- 22. Lista el nombre de los productos que tienen un precio mayor o igual a 400€.
select nombre, precio from producto where precio >= 400

-- 23. Lista el nombre de los productos que no tienen un precio mayor o igual a
-- 400€.
select nombre, precio from producto where precio < 400

-- 24. Lista todos los productos que tengan un precio entre 80€ y 300€. Sin utilizar
-- el operador BETWEEN.
select nombre, precio from producto where precio >= 80 and precio <= 300

-- 25. Lista todos los productos que tengan un precio entre 60€ y 200€. Utilizando
-- el operador BETWEEN.
select nombre, precio from producto where precio between  60 and 200

-- 26. Lista todos los productos que tengan un precio mayor que 200€ y que el
-- identificador de fabricante sea igual a 6.
select nombre, precio from producto where precio > 200 and codigo_fabricante = 6 

-- 27. Lista todos los productos donde el identificador de fabricante sea 1, 3 o 5.
-- Sin utilizar el operador IN.
select nombre from producto where codigo_fabricante = 1 or codigo_fabricante = 3 or codigo_fabricante = 5

-- 28. Lista todos los productos donde el identificador de fabricante sea 1, 3 o 5.
-- Utilizando el operador IN.
select nombre from producto where codigo_fabricante in (1, 3, 5)

-- 29. Lista el nombre y el precio de los productos en céntimos (Habrá que
-- multiplicar por 100 el valor del precio). Cree un alias para la columna que
-- contiene el precio que se llame céntimos.
select nombre, precio * 100 as centimos from producto

-- 30. Lista los nombres de los fabricantes cuyo nombre empiece por la letra S.
select nombre from fabricante where nombre like 'S%'

-- 31. Lista los nombres de los fabricantes cuyo nombre termine por la vocal e.
select nombre from fabricante where nombre like '%e'

-- 32. Lista los nombres de los fabricantes cuyo nombre contenga el carácter w.
select nombre from fabricante where nombre like '%w%'

-- 33. Lista los nombres de los fabricantes cuyo nombre sea de 4 caracteres.
select nombre from fabricante where length(nombre) = 4

-- 34. Devuelve una lista con el nombre de todos los productos que contienen la
-- cadena Portátil en el nombre.
select nombre from producto where nombre like '%Portátil%'

-- 35. Devuelve una lista con el nombre de todos los productos que contienen la
-- cadena Monitor en el nombre y tienen un precio inferior a 215 €.
select nombre from producto where nombre like '%Monitor' and precio < 215

-- 36. Lista el nombre y el precio de todos los productos que tengan un precio
-- mayor o igual a 180€. Ordene el resultado en primer lugar por el precio (en
-- orden descendente) y en segundo lugar por el nombre (en orden
-- ascendente).
select nombre, precio from where precio >= 180 order by precio desc, nombre asc

-- Consultas multitabla (Composición interna)
-- Resuelva todas las consultas utilizando la sintaxis de SQL1 y SQL2.
-- 1. Devuelve una lista con el nombre del producto, precio y nombre de
-- fabricante de todos los productos de la base de datos.
select p.nombre, p.precio, f.nombre from producto p inner join fabricante f 
on p.codigo_fabricante = f.codigo_fabricante

-- 2. Devuelve una lista con el nombre del producto, precio y nombre de
-- fabricante de todos los productos de la base de datos. Ordene el resultado
-- por el nombre del fabricante, por orden alfabético.
select p.nombre, p.precio, f.nombre from producto p inner join fabricante f 
on p.codigo_fabricante = f.codigo_fabricante oreder by f.nombre asc

-- 3. Devuelve una lista con el identificador del producto, nombre del producto,
-- identificador del fabricante y nombre del fabricante, de todos los productos
-- de la base de datos.
select p.codigo, p.nombre, p.codigo_fabricante, f.nombre from producto p 
inner join fabricante f on p.codigo_fabricante = f.codigo_fabricante

-- 4. Devuelve el nombre del producto, su precio y el nombre de su fabricante,
-- del producto más barato.
select p.nombre, p.precio, f.nombre from producto p inner join fabricante f 
on p.codigo_fabricante = f.codigo_fabricante order by p.precio asc limit 1

-- 5. Devuelve el nombre del producto, su precio y el nombre de su fabricante,
-- del producto más caro.
select p.nombre, p.precio, f.nombre from producto p inner join fabricante f 
on p.codigo_fabricante = f.codigo_fabricante order by p.precio desc limit 1

-- 6. Devuelve una lista de todos los productos del fabricante Lenovo.
select p.nombre, p.precio from producto p inner join fabricante f 
on .p.codigo_fabricante = f.codigo_fabricante where f.nombre = 'Lenovo'

-- 7. Devuelve una lista de todos los productos del fabricante Crucial que tengan
-- un precio mayor que 200€.
select p.nombre, p.precio from producto p inner join fabricante f 
on p.codigo_fabricante = f.codigo_fabricante where f.nombre = 'Crucial' and p.precio > 200

-- 8. Devuelve un listado con todos los productos de los
-- fabricantes Asus, Hewlett-Packardy Seagate. Sin utilizar el operador IN.
select p.nombre, p.precio from producto p inner join fabricante f 
on p.codigo_fabricante = f.codigo_fabricante where f.nombre = 'Asus' or f.nombre = 'Hewlett.Packard' or f.nombre = 'Seagate'

-- 9. Devuelve un listado con todos los productos de los
-- fabricantes Asus, Hewlett-Packardy Seagate. Utilizando el operador IN.
select p.nombre, p.precio from producto p inner join fabricante f 
on p.codigo_fabricante = f.codigo_fabricante where f.nombre in ('Asus', 'Hewlett-Packard', 'Seagate')

-- 10. Devuelve un listado con el nombre y el precio de todos los productos de los
-- fabricantes cuyo nombre termine por la vocal e.
select p.nombre, p.precio from producto p inner join fabricante f 
on p.codigo_fabricante = f.codigo_fabricante where f.nombre like '%e'

-- 11. Devuelve un listado con el nombre y el precio de todos los productos cuyo
-- nombre de fabricante contenga el carácter w en su nombre.
select p.nombre, p.precio from producto p inner join fabricante f 
on p.codigo_fabricante = f.codigo_fabricante where f.nombre like '%w%'

-- 12. Devuelve un listado con el nombre de producto, precio y nombre de
-- fabricante, de todos los productos que tengan un precio mayor o igual a
-- 180€. Ordene el resultado en primer lugar por el precio (en orden
-- descendente) y en segundo lugar por el nombre (en orden ascendente)
select p.nombre, p.precio, f.nombre from producto p inner join fabricante f 
on p.codigo_fabricante = f.codigo_fabricante where p.precio >= 180 order by p.precio desc, p.nombre asc

-- 13. Devuelve un listado con el identificador y el nombre de fabricante,
-- solamente de aquellos fabricantes que tienen productos asociados en la
-- base de datos.
select distinct f.codigo_fabricante, f.nombre from fabricante f inner join producto p on f.codigo_fabricante = p.codigo_fabricante
