/*
 * The film 'BUCKET BROTHERHOOD' is your favorite movie, but you're tired of watching it.
 * You want to find something new to watch that is still similar to 'BUCKET BROTHERHOOD'.
 * To find a similar movie, you decide to search the history of movies that other people have rented.
 * Your idea is that if a lot of people have rented both 'BUCKET BROTHERHOOD' and movie X,
 * then movie X must be similar and something you'd like to watch too.
 * Your goal is to create a SQL query that finds movie X.
 * Specifically, write a SQL query that returns all films that have been rented by at least 3 customers who have also rented 'BUCKET BROTHERHOOD'.
 *
 * HINT:
 * This query is very similar to the query from problem 06,
 * but you will have to use joins to connect the rental table to the film table.
 *
 * HINT:
 * If your query is *almost* getting the same results as mine, but off by 1-2 entries, ensure that:
 * 1. You are not including 'BUCKET BROTHERHOOD' in the output.
 * 2. Some customers have rented movies multiple times.
 *    Ensure that you are not counting a customer that has rented a movie twice as 2 separate customers renting the movie.
 *    I did this by using the SELECT DISTINCT clause.
 */


WITH bb AS (SELECT film_id from film WHERE title = 'BUCKET BROTHERHOOD')

SELECT DISTINCT  T.title
FROM (SELECT DISTINCT f1.title, r1.customer_id
FROM film f1
JOIN inventory iv1 ON (f1.film_id = iv1.film_id)
JOIN rental r1 ON (iv1.inventory_id = r1.inventory_id)
JOIN rental r2 ON (r1.customer_id = r2.customer_id)
JOIN inventory iv2 ON (r2.inventory_id = iv2.inventory_id)
JOIN film f2 ON (iv2.film_id = f2.film_id)
WHERE 
	f1.film_id NOT IN (SELECT * from bb)
        AND f2.film_id IN (SELECT * from bb))T
GROUP BY T.title
HAVING count(*)>=3
ORDER BY T.title;
