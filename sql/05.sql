/*
 * You love the acting in the movie 'AMERICAN CIRCUS' and want to watch other movies with the same actors.
 *
 * Write a SQL query that lists the title of all movies where at least 2 actors were also in 'AMERICAN CIRCUS'.
 *
 * HINT:
 * This can be solved with a self join on the film_actor table.
 */
SELECT DISTINCT f1.title
FROM film f1
JOIN film_actor fa1 ON (f1.film_id = fa1.film_id)
JOIN film_actor fa2 ON (fa1.film_id = fa2.film_id)

WHERE fa1.actor_id IN (SELECT actor_id FROM film_actor
JOIN film USING(film_id) WHERE film.title = 'AMERICAN CIRCUS'
) AND
fa2.actor_id IN (SELECT actor_id FROM film_actor
JOIN film USING(film_id) WHERE film.title = 'AMERICAN CIRCUS'
) AND 
fa2.actor_id != fa1.actor_id
;
