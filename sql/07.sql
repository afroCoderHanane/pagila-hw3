/*
 * List all actors with Bacall Number 2;
 * That is, list all actors that have appeared in a film with an actor that has appeared in a film with 'RUSSELL BACALL',
 * but do not include actors that have Bacall Number < 2.
 */

WITH bacall_1 AS (

SELECT DISTINCT actor_id
from actor                                         
JOIN film_actor USING (actor_id)
WHERE film_id IN(
 SELECT film_id from film_actor JOIN actor using (actor_id)
 WHERE first_name ='RUSSELL' AND last_name = 'BACALL') AND NOT
(first_name = 'RUSSELL' AND last_name = 'BACALL')


)


SELECT  DISTINCT a3.first_name||$$ $$||a3.last_name AS "Actor Name"
FROM actor a3
JOIN film_actor fa3 ON (a3.actor_id = fa3.actor_id)
JOIN film_actor fa4 ON (fa3.film_id = fa4.film_id)
JOIN actor a4 ON (fa4.actor_id = a4.actor_id)
WHERE a4.actor_id IN (SELECT * FROM bacall_1)
AND a3.actor_id NOT IN (SELECT * FROM bacall_1)
AND a3.actor_id NOT IN (SELECT actor_id FROM actor WHERE a3.first_name= 'RUSSELL' AND a3.last_name ='BACALL')
ORDER BY "Actor Name";
