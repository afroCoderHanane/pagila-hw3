/*
 * Compute the country with the most customers in it. 
 */
SELECT T.country
FROM (
SELECT country.country, COUNT(customer_id)
FROM customer JOIN address USING(address_id)
JOIN city USING(city_id)
JOIN country USING(country_id)
GROUP BY country.country
ORDER BY count DESC) T
LIMIT 1;
