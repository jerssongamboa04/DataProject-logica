
--2.Muestra los nombres de todas las películas con una clasificación por edades de ‘Rʼ.
SELECT 
        "title" as "Name_films", "rating" as "Age_R" 
FROM 
        "film"
WHERE 
        RATING = 'R';

--3.Encuentra los nombres de los actores que tengan un “actor_idˮ entre 30 y 40.
SELECT 
       CONCAT("first_name", ' ' ,"last_name") as "Name_actor", 
       "actor_id"
FROM 
       "actor" 
WHERE 
       "actor_id" BETWEEN 30 AND 40;

--4.Obtén las películas cuyo idioma coincide con el idioma original.
SELECT 
    f."title", 
    l."name" AS "language_name"
FROM 
    "film" AS f
INNER JOIN 
    language AS l ON f."language_id" = l."language_id"
ORDER BY 
    f."title";
--La fila de "original_language_id", de la tabla film, solo guarda valores nulos por lo cual no me deja comparar los valores de la fila name de la tabla language
--se hace la busqueda de las peliculas y sus lenguajes. 

--5.Ordena las películas por duración de forma ascendente.
SELECT  
     "film_id" ,"title", "length"
FROM 
      "film" 
order by 
      "length" ;

--6.Encuentra el nombre y apellido de los actores que tengan ‘Allenʼ en su apellido.
SELECT 
      CONCAT("first_name", ' ', "last_name") as "name_actor"
FROM 
      "actor"
WHERE 
      "last_name" = 'ALLEN';

--7.Encuentra la cantidad total de películas en cada clasificación de la tabla “filmˮ y 
--muestra la clasificación junto con el recuento.

SELECT 
      "rating", COUNT("film_id") as "total_film"
FROM 
      "film"
group by 
      "rating";

--8.Encuentra el título de todas las películas que son ‘PG13ʼ o tienen una duración 
--mayor a 3 horas en la tabla film.

SELECT 
      "title" as "name_film",
      "length" as "duration_film",
      "rating" as "Classification_film"
FROM 
       "film"
WHERE 
       "rating" = 'PG-13'
OR 
       "length" > 180;

--9.Encuentra la variabilidad de lo que costaría reemplazar las películas.
SELECT 
      round(VARIANCE("replacement_cost"),2) as "Variance_cost_replacement"
FROM 
      "film";

--10.Encuentra la mayor y menor duración de una película de nuestra BBDD.
SELECT MIN("length") as "duration_min" ,
       MAX("length") as "duration_max"
FROM 
       "film";

--11.Encuentra lo que costó el antepenúltimo alquiler ordenado por día.

SELECT 
       "amount" as "price_rental",
       "rental_id", 
       "payment_date"
FROM 
       "payment" 
order by 
       "payment_date" DESC 
limit 1
OFFSET 2;

--12.Encuentra el título de las películas en la tabla “filmˮ
-- que no sean ni ‘NC- 17ʼ ni ‘Gʼ en cuanto a su clasificación.

SELECT 
      "title" as "name_film",
      "rating" as "classification"
FROM 
      "film"
WHERE 
      "rating" NOT IN ('NC-17', 'G');

--13.Encuentra el promedio de duración de las películas para cada 
--clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.

SELECT 
       "rating" as "classification", 
       ROUND(AVG("length"),2) as "avg_duration"
FROM 
       "film"
group by 
       "rating";

--14.Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.

SELECT 
      "title" as "name_film", 
      "length" as "duration_film"
FROM 
      "film"
WHERE "length" > 180;

--15.¿Cuánto dinero ha generado en total la empresa?
SELECT 
     SUM("amount") as "Total_payment"
FROM 
     "payment";

--16.Muestra los 10 clientes con mayor valor de id.
SELECT 
       CONCAT("first_name", ' ', "last_name") as "full_name_client",
       "customer_id" as "client_id" 
FROM 
       "customer"
order by 
       "customer_id" DESC 
LIMIT 10;

--17.Encuentra el nombre y apellido de los actores 
--que aparecen en la película con título ‘Egg Igbyʼ.

SELECT 
      CONCAT("first_name", ' ', "last_name") as "full_name_actors"
FROM 
      "actor" as a 
inner join 
      "film_actor" as fa on a."actor_id" = fa."actor_id"
inner join 
      "film" as f on fa."film_id" = f."film_id"
WHERE 
       f."title" = 'EGG IGBY';

--18.Selecciona todos los nombres de las películas únicos.

SELECT DISTINCT("title") as "unique_movie_names"
FROM 
    "film";

--19.Encuentra el título de las películas que son comedias 
--y tienen una duración mayor a 180 minutos en la tabla “filmˮ.

SELECT 
     "title" as "name_movie",
     "length" as "duration" , 
     c."name" as "category"
FROM 
     "film" as f
inner join 
     "film_category" as fc on fc."film_id" = f."film_id"
inner join 
     "category" as c on c."category_id" = fc."category_id"
WHERE 
     "length" > 180 AND c."name"= 'Comedy';


--20.Encuentra las categorías de películas que tienen un promedio de duración superior 
--a 110 minutos y muestra el nombre de la categoría junto con el promedio de duración.

SELECT 
       c."name" AS "category",
       ROUND(AVG(f."length"), 2) AS "avg_duration"
FROM 
      "category" AS c
INNER JOIN 
      "film_category" AS fc ON c."category_id" = fc."category_id"
INNER JOIN 
      "film" AS f ON f."film_id" = fc."film_id"
GROUP BY 
      c."name"
HAVING 
      AVG(f."length") > 110;


--21.¿Cuál es la media de duración del alquiler de las películas?

SELECT 
      ROUND(AVG("rental_duration") ,2) 
FROM 
      "film";

--22.Crea una columna con el nombre y apellidos de todos los actores y actrices.

SELECT 
     CONCAT("first_name", ' ', "last_name") as "full_name_actors" 
FROM 
     "actor"

--23.Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.

SELECT 
      "rental_date", COUNT("rental_id") as "number_rentals"
FROM 
      "rental"
group by 
      "rental_date"
order by 
      "number_rentals" DESC ;

--24.Encuentra las películas con una duración superior al promedio.

SELECT 
       f."title", f."length"
FROM 
       "film" f
WHERE 
       f."length" > (
    SELECT AVG(f."length") 
    FROM film f);

--25.Averigua el número de alquileres registrados por mes.
SELECT 
    EXTRACT(YEAR FROM "rental_date") AS año, 
    EXTRACT(MONTH FROM "rental_date") AS mes, 
    COUNT(*) AS total_rental
FROM 
    "rental"
GROUP BY 
    EXTRACT(YEAR FROM "rental_date"), EXTRACT(MONTH FROM "rental_date")
ORDER BY 
    año DESC, mes DESC;

--26.Encuentra el promedio, la desviación estándar y varianza del total pagado.

 SELECT ROUND(avg("amount"),2) as "avg_payment", 
        ROUND(STDDEV("amount"),2) as "deviation_payment",
        ROUND(VARIANCE("amount"),2) as "variance_payment"
 FROM "payment";

--27.¿Qué películas se alquilan por encima del precio medio?

 SELECT f."title" as "title_film",
        p."amount" as "rental_price"
 FROM "payment" as p
 inner join  
           rental r ON p.rental_id = r.rental_id
 inner join 
           inventory i ON r.inventory_id = i.inventory_id
 inner join 
           film f on i.film_id = f.film_id
 WHERE 
    p."amount" > (
        SELECT AVG(p2."amount") 
        FROM "payment" AS p2)
 order by 
        p."amount";
 
 --28.Muestra el id de los actores que hayan participado en más de 40 películas..
 
 SELECT 
       a."actor_id" as "actor_id",
       CONCAT(a."first_name", ' ',a."last_name") as "name_actor",
       COUNT(fa."film_id") as "film_count"   
 FROM  
     "actor" as a
inner join 
      film_actor as fa on a."actor_id" = fa."actor_id"
group by 
       a."actor_id", a."first_name", a."last_name"
HAVING 
      COUNT(fa."film_id") > 40
ORDER BY 
       "film_count" DESC ;
          
      
--29.Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible.

SELECT 
    f.film_id,
    f.title,
    COUNT(i.inventory_id) AS available_copies
FROM 
    "film" f
LEFT JOIN 
    inventory i ON f.film_id = i.film_id
GROUP BY 
    f.film_id, f.title
ORDER BY 
    f.title;

      
--30.Obtener los actores y el número de películas en las que ha actuado.
SELECT 
    CONCAT(a."first_name", ' ', a."last_name") AS "name_actor",
    COUNT(fa."film_id") AS "acted_film"
FROM 
    "actor" AS a
INNER JOIN 
    "film_actor" AS fa ON a."actor_id" = fa."actor_id"
GROUP BY 
    a."actor_id", a."first_name", a."last_name"
ORDER BY 
    "acted_film" DESC; 
         
--31.Obtener todas las películas y mostrar los actores que han actuado en ellas,
-- incluso si algunas películas no tienen actores asociados.
   
  SELECT 
    f."film_id",
    f."title" AS "name_film",
    CONCAT(a."first_name", ' ', a."last_name") AS "name_actor"
FROM 
    "film" AS f
LEFT JOIN 
    "film_actor" AS fa ON f."film_id" = fa."film_id"
LEFT JOIN 
    "actor" AS a ON fa."actor_id" = a."actor_id"
ORDER BY 
    f."title";

--32.Obtener todos los actores y mostrar las películas en las que han actuado,
-- incluso si algunos actores no han actuado en ninguna película.
   
   SELECT 
        CONCAT(a."first_name", ' ', a."last_name") AS "name_actor",
        f."film_id",
        f."title" AS "name_film"        
   FROM 
       "actor" as a
   LEFT JOIN 
        film_actor as fa ON a."actor_id" = fa."actor_id"    
   LEFT JOIN
         film as f ON fa."film_id" = f."film_id"    
   ORDER BY 
         "name_actor";
   
--33.Obtener todas las películas que tenemos y todos los registros de alquiler.

SELECT 
      *
FROM 
    film AS f
left join 
    inventory AS i ON f."film_id" = i."film_id"
left join 
    rental AS r ON i."inventory_id" = r."inventory_id"
ORDER BY 
    f."title", r."rental_date";

--34.Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.

   SELECT CONCAT(c."first_name", ' ', c."last_name") as "name_customer",
          SUM(p.amount) AS "total_payment"
   FROM 
          customer as c
   inner join 
          payment as p on c."customer_id" = p."customer_id"
   group by 
          c."first_name", c."last_name"
   order by 
          "total_payment" DESC
   limit 5;
        
--35.Selecciona todos los actores cuyo primer nombre es 'Johnny'.
  SELECT 
       CONCAT(a."first_name", ' ', a."last_name") as "name_actor"
  FROM 
       "actor" as a
  WHERE 
       a."first_name" = 'JOHNNY';
        
--36.Renombra la columna “first_nameˮ como Nombre y “last_nameˮ como Apellido.

SELECT 
     "first_name" as "Nombre",
     "last_name" as "Apellido"
FROM "actor";

--37.Encuentra el ID del actor más bajo y más alto en la tabla actor.

SELECT 
     MIN(a."actor_id") as "actor_id_min",
     MAX(a."actor_id") as "actor_id_max"
FROM 
    "actor" as a;

--38.Cuenta cuántos actores hay en la tabla “actorˮ.
   
SELECT 
     COUNT("actor_id") 
FROM 
     "actor" as a;
        
--39.Selecciona todos los actores y ordénalos por apellido en orden ascendente.

SELECT "first_name" as "actor_first_name",
       "last_name" as "actor_last_name"
FROM  
        "actor"
order by
       "last_name";

--40.Selecciona las primeras 5 películas de la tabla “filmˮ.

SELECT 
     "film_id",
     "title" as "top_film_title"
     
FROM 
    "film"
order by 
      "title"
limit 5;

--41.Agrupa los actores por su nombre
-- y cuenta cuántos actores tienen el mismo nombre. ¿Cuál es el nombre más repetido?

SELECT 
       "first_name" as "actor_name",
       COUNT("first_name") as "count_first_name"
FROM
      "actor"
group by 
       "first_name"
order by 
        "count_first_name" DESC;
       
--42.Encuentra todos los alquileres y los nombres de los clientes que los realizaron.
SELECT 
      r."rental_id",
      concat(c."first_name", ' ', c."last_name") as "customer_name"
FROM 
       "rental" as r
inner join customer as c on 
      r."customer_id" = c."customer_id"         
order by 
      r."rental_id";

--43.Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres.

SELECT 
      c."customer_id",
      concat(c."first_name", ' ', c."last_name") as "customer_name",
      r."rental_id",
      r.rental_date
FROM 
     "customer" as c
LEFT JOIN "rental" as r ON 
      c."customer_id" = r."customer_id"
ORDER BY 
      c."customer_id";  
     
     
--44.Realiza un CROSS JOIN entre las tablas film y category. 
--¿Aporta valor esta consulta? ¿Por qué? Deja después de la consulta la contestación.
     
SELECT 
      f."film_id" as "title_film",
      c."category_id" as "name_category_film"
FROM 
     "film" as f
cross join category as c;
--En esta consulta a estas tablas en especificas, 
--no nos aporta ninguna informacion relevante ya 
--que al no tener ninguna relacion de informacion entre tablas, 
--la union de estas tablas nos da informacion incoherente.
     
     
--45.Encuentra los actores que han participado en películas de la categoría 'Action'.
     
SELECT 
       CONCAT("first_name", ' ',"last_name") as "name_actor", 
       c."name" as "category_name"
FROM 
       "actor" as a
inner join 
       film_actor as fa on a."actor_id" = fa."actor_id"
inner join 
       film as f on fa."film_id" = f."film_id"
inner join 
       film_category as fc on f."film_id" = fc."film_id"
inner join 
       category as c on fc."category_id" = c."category_id"
WHERE 
       c."name" = 'Action';

     
--46.Encuentra todos los actores que no han participado en películas.     

SELECT 
    CONCAT(a.first_name, ' ', a.last_name) AS name_actor
FROM 
    "actor" AS a
LEFT JOIN 
    film_actor AS fa ON a.actor_id = fa.actor_id
WHERE 
    fa.actor_id IS NULL;
--No se encuentran actores que no hayan participado en ninguna pelicula, todos los actores han estado en almenos 1 pelicula.


--47.Selecciona el nombre de los actores y la cantidad de películas en las que han participado.

SELECT 
      CONCAT(a."first_name", ' ',a."last_name") as "name_actor",
      COUNT(fa."film_id") as "total_film" 
FROM 
      "actor" as a
inner join 
      film_actor as fa on a."actor_id" = fa."actor_id"
GROUP BY 
     a."first_name",
     a."last_name"
order by 
      "total_film";
   
--48.Crea una vista llamada “actor_num_peliculasˮ que muestre 
--los nombres de los actores y el número de películas en las que han participado.

CREATE VIEW actor_num_peliculas AS
SELECT 
    a."first_name", 
    a."last_name", 
    COUNT(fa."film_id") AS "total_movies"
FROM 
    "actor" AS a
INNER JOIN 
    film_actor AS fa ON a."actor_id" = fa."actor_id"
GROUP BY 
    a."actor_id", a."first_name", a."last_name"
ORDER BY 
    "total_movies" DESC;

--Se verifica que la vista se ha creado correctamente y se solicita la informacion de la vista.
SELECT * FROM actor_num_peliculas;
     
     
--49.Calcula el número total de alquileres realizados por cada cliente.

SELECT 
        CONCAT(c."first_name",' ',c."last_name") as "name_customer",
        COUNT(r."rental_id") as "total_rental"
FROM 
        "customer" as c
inner join 
        rental as r on c."customer_id" = r."customer_id"
GROUP BY 
        c."first_name",
        c."last_name"
ORDER BY 
        "total_rental";
   
   
       
 --50.Calcula la duración total de las películas en la categoría 'Action'.      
       
SELECT
      SUM(f."length") as "total_duration_film",
      c."name" as "category_name"
FROM 
      "film" as f
inner join 
       film_category as fc on f."film_id" = fc."film_id"
inner join 
       category as c on fc."category_id" = c."category_id"
WHERE 
       c."name" = 'Action'
GROUP BY 
       c."name";

--51.Crea una tabla temporal llamada “cliente_rentas_temporalˮ 
--para almacenar el total de alquileres por cliente.  
  
CREATE TEMP TABLE "cliente_rentas_temporal" as
SELECT 
        CONCAT(c."first_name",' ',c."last_name") as "name_customer",
        COUNT(r."rental_id") as "total_rental"
FROM 
        customer as c
inner join 
        rental as r on c."customer_id" = r."customer_id"
GROUP BY 
        c."first_name",
        c."last_name"
ORDER BY 
        "total_rental";
-- Verificamos si se creo la tabla temporal.  
SELECT * 
from cliente_rentas_temporal;
   
--52.Crea una tabla temporal llamada “peliculas_alquiladasˮ 
--que almacene las películas que han sido alquiladas al menos 10 veces.  
   
CREATE TEMP TABLE peliculas_alquiladas AS
SELECT 
      f."film_id",
      f."title", 
      COUNT(r."rental_id") AS "total_rental"
FROM 
    film as f
INNER JOIN 
         inventory i ON f."film_id" = i."film_id"
         
INNER JOIN 
         rental r ON i."inventory_id" = r."inventory_id"
GROUP BY 
       f."title", f."film_id"

HAVING 
      COUNT(r."rental_id") >= 10
ORDER BY 
        "total_rental";
-- Verificamos si se creo la tabla temporal.  
SELECT *
FROM "peliculas_alquiladas";

--53.Encuentra el título de las películas que han sido alquiladas por el cliente con el nombre ‘Tammy Sandersʼ 
--y que aún no se han devuelto. Ordena los resultados alfabéticamente por título de película.

SELECT 
      f."film_id",
      f."title",
     concat(c."first_name", ' ', c."last_name") as "customer_name"
FROM 
      "film" as f 
inner join 
      inventory as i on f."film_id" = i."film_id"
inner join 
      rental as r on i."inventory_id" = r."inventory_id"
inner join 
      customer as c on r."customer_id" = c."customer_id"      
WHERE 
      concat(c."first_name", ' ', c."last_name") = 'TAMMY SANDERS' AND r."return_date" IS NULL
ORDER BY 
      f."title";


--54.Encuentra los nombres de los actores que han actuado en al menos una película que pertenece a 
--la categoría ‘Sci-Fiʼ. Ordena los resultados alfabéticamente por apellido.

SELECT 
       a."first_name" || ' ' || a."last_name" AS "actor_name",
       c."name" as "film_category_name"
from 
     "actor" as a
     
inner join 
     film_actor as fa on a."actor_id" = fa."actor_id"
inner join 
     film as f on fa."film_id" = f."film_id"
inner join 
     film_category as fc on f."film_id" = fc."film_id"
inner join 
      category as c on fc."category_id" = c."category_id"
where 
     c."name" = 'Sci-Fi'
GROUP BY 
      c."name", a."first_name",a."last_name"

order by 
      a."last_name", a."first_name";       


--55.Encuentra el nombre y apellido de los actores que han actuado en películas que 
--se alquilaron después de que la película ‘Spartacus Cheaperʼ 
--se alquilara por primera vez. Ordena los resultados alfabéticamente por apellido.

SELECT DISTINCT 
       a."first_name", 
       a."last_name"
FROM 
    "actor" AS a
INNER JOIN 
    film_actor AS fa ON a."actor_id" = fa."actor_id"
INNER JOIN 
    film AS f ON fa."film_id" = f."film_id"
INNER JOIN 
    inventory AS i ON f."film_id" = i."film_id"
INNER JOIN 
    rental AS r ON i."inventory_id" = r."inventory_id"
WHERE 
    r."rental_date" > (
        SELECT MIN(r."rental_date") 
        FROM rental AS r
        INNER JOIN inventory AS i ON r."inventory_id" = i."inventory_id"
        INNER JOIN film AS f ON i."film_id" = f."film_id"
        WHERE f."title" = 'SPARTACUS CHEAPER'
    )
ORDER BY 
    a."last_name", a."first_name";

--56.Encuentra el nombre y apellido de los actores que no han actuado en ninguna
-- película de la categoría ‘Musicʼ.

SELECT DISTINCT 
    a."first_name", 
    a."last_name"
FROM 
    "actor" AS a
WHERE 
    a."actor_id" NOT IN (
        SELECT fa."actor_id"
        FROM film_actor AS fa
        INNER JOIN film_category AS fc ON fa."film_id" = fc."film_id"
        INNER JOIN category AS c ON fc."category_id" = c."category_id"
        WHERE c."name" = 'Music'
    )
ORDER BY 
    a."last_name", a."first_name";


--57.Encuentra el título de todas las películas que fueron alquiladas por más de 8 días.

SELECT 
    f."title"
FROM 
    "film" AS f
INNER JOIN 
    inventory AS i ON f."film_id" = i."film_id"
INNER JOIN 
    rental AS r ON i."inventory_id" = r."inventory_id"
WHERE 
    (r."return_date" - r."rental_date") > INTERVAL '8 days'
GROUP by
     f."title"
ORDER BY 
    f."title";

--58.Encuentra el título de todas las películas que son de la misma categoría que ‘Animationʼ.

SELECT 
     f."title"
FROM 
     "film" as f
inner join 
      film_category as fc on f."film_id" = fc."film_id"
inner join 
      category as c on fc."category_id" = c."category_id" 
WHERE 
      c."name" = 'Animation'
ORDER BY 
    f."title";


--59.Encuentra los nombres de las películas que tienen la misma duración 
--que la película con el título ‘Dancing Feverʼ.
-- Ordena los resultados alfabéticamente por título de película.

SELECT 
    f."title" as "name_film",
    f."length" as "duration_film"
FROM 
    "film" AS f
WHERE 
    f."length" = (
        SELECT f2."length"
        FROM film AS f2
        WHERE f2."title" = 'DANCING FEVER'
    )
ORDER BY 
    f."title";

--60.Encuentra los nombres de los clientes que han alquilado al menos 7 películas distintas.
-- Ordena los resultados alfabéticamente por apellido.


SELECT 
    c."first_name" as "first_name_customer", 
    c."last_name" as "last_name_customer"
FROM 
    "customer" AS c
INNER JOIN 
    rental AS r ON c."customer_id" = r."customer_id"
INNER JOIN 
    inventory AS i ON r."inventory_id" = i."inventory_id"
INNER JOIN 
    film AS f ON i."film_id" = f."film_id"
GROUP BY 
    c."customer_id", c."first_name", c."last_name"
HAVING 
    COUNT(DISTINCT f."film_id") >= 7
ORDER BY 
    c."last_name", c."first_name";

--61.Encuentra la cantidad total de películas alquiladas por categoría y muestra 
--el nombre de la categoría junto con el recuento de alquileres.

SELECT 
    c."name" AS category_name,
    COUNT(r."rental_id") AS total_rentals
FROM 
    "category" AS c
INNER JOIN 
    film_category AS fc ON c."category_id" = fc."category_id"
INNER JOIN 
    film AS f ON fc."film_id" = f."film_id"
INNER JOIN 
    inventory AS i ON f."film_id" = i."film_id"
INNER JOIN 
    rental AS r ON i."inventory_id" = r."inventory_id"
GROUP BY 
    c."name"
ORDER BY 
    total_rentals DESC;

--62.Encuentra el número de películas por categoría estrenadas en 2006.

SELECT 
    c."name" AS category_name,
    COUNT(f."film_id") AS total_movies
FROM 
    category AS c
INNER JOIN 
    film_category AS fc ON c."category_id" = fc."category_id"
INNER JOIN 
    film AS f ON fc."film_id" = f."film_id"
WHERE 
    f."release_year" = 2006
GROUP BY 
    c."name"
ORDER BY 
    total_movies;

--63.Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.

SELECT 
    s."staff_id", 
    s."first_name", 
    s."last_name", 
    st."store_id"
FROM 
    "staff" AS s
CROSS JOIN 
    store AS st
ORDER BY 
    s."staff_id", st."store_id";     


--64.Encuentra la cantidad total de películas alquiladas por cada
-- cliente y muestra el ID del cliente, su nombre y apellido junto
-- con la cantidad de películas alquiladas.

SELECT 
    c."customer_id", 
    c."first_name", 
    c."last_name", 
    COUNT(r."rental_id") AS total_rentals
FROM 
    "customer" AS c
INNER JOIN 
    rental AS r ON c."customer_id" = r."customer_id"
GROUP BY 
    c."customer_id", c."first_name", c."last_name"
ORDER BY 
    total_rentals DESC;







