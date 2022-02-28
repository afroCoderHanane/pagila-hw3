/*
 * List the first and last names of all actors who:
 * 1. have appeared in at least one movie in the "Children" category,
 * 2. but that have never appeared in any movie in the "Horror" category.
 */
SELECT T1.first_name, T1.last_name
FROM (select actor.first_name, actor.last_name
from actor
join film_actor using(actor_id)
join film using(film_id)
join film_category using(film_id)
join category using (category_id)
WHERE name = 'Children') T1 WHERE (T1.first_name, T1.last_name) NOT IN (select actor.first_name, actor.last_name
from actor
join film_actor using(actor_id)
join film using(film_id)
join film_category using(film_id)
join category using (category_id)
WHERE name = 'Horror') GROUP BY T1.first_name, T1.last_name
ORDER BY  T1.last_name, T1.first_name;
