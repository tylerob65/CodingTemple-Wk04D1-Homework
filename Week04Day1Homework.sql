-- Week 4 Day 1 Homework - answer the following questions


-- 1. How many actors are there with the last name ‘Wahlberg’?
-- answer = 2
SELECT COUNT(last_name)
FROM actor
WHERE last_name = 'Wahlberg';


-- 2. How many payments were made between $3.99 and $5.99?
-- answer = currently 0
-- Note: was unclear if it was supposed to be inclusive or not. Can be made
-- inclusive if '> and <' are changed to '>=' and '<='
SELECT COUNT(amount)
FROM payment
WHERE amount > 3.99 and amount < 5.99;


-- 3. What film does the store have the most of? (search in inventory)
-- answer = A bunch of films. Query below should find answer
SELECT title
FROM film
WHERE film_id IN (
    SELECT film_id
    FROM inventory
    GROUP BY film_id
    HAVING COUNT(inventory_id) = (
        SELECT COUNT(inventory_id)
        FROM inventory
        GROUP BY film_id
        ORDER BY COUNT(inventory_id) DESC
        LIMIT 1
    ));


-- 4. How many customers have the last name ‘William’?
-- answer = none. But there is one person to have last name 'Williams'
SELECT COUNT(last_name) 
FROM customer
WHERE last_name = 'William';


-- 5. What store employee (get the id) sold the most rentals?
-- answer = staff_id = 1
SELECT staff_id, count(rental_id)
FROM rental
GROUP BY staff_id
ORDER BY count(rental_id) DESC
LIMIT 1;


-- 6. How many different district names are there?
-- answer = 378
SELECT COUNT(DISTINCT district)
FROM address;


-- 7. What film has the most actors in it? (use film_actor table and get film_id)
-- answer = film_id = 508
SELECT film_id, COUNT(actor_id)
FROM film_actor
GROUP BY film_id
ORDER BY COUNT(actor_id) DESC
LIMIT 1;


-- 8. From store_id 1, how many customers have a last name ending with ‘es’? (use customer table)
-- answer = 13
SELECT COUNT(last_name)
FROM customer
WHERE last_name LIKE '%es' AND store_id = 1;


-- 9. How many payment amounts (4.99, 5.99, etc.) had a number of rentals above 250 
-- for customers with ids between 380 and 430? (use group by and having > 250)
-- answer = 3
SELECT COUNT(*)
FROM (
    SELECT amount
    FROM payment
    WHERE customer_id > 380 and customer_id < 430
    GROUP BY amount
    HAVING COUNT(rental_id) > 250
    ORDER BY COUNT(rental_id) DESC) AS query;


-- 10. Within the film table, how many rating categories are there? And what rating has 
-- the most movies total?
-- Answer = 5 categories. The rating category is PG-13 and currently there are 223 films with rating
SELECT COUNT(DISTINCT rating)
FROM film;

SELECT rating, COUNT(*)
FROM film
GROUP BY rating
HAVING COUNT(*) = (
    SELECT COUNT(*)
    FROM film
    GROUP BY rating
    ORDER BY COUNT(*) DESC
    LIMIT 1
);