use sakila;
show create table actor;
select *
from actor;

select *
from film_actor;

show tables;
describe inventory;
describe film_actor;
describe actor;

select distinct *
from actor;

select *
from film;

select *
from film_actor;

select act.first_name, act.last_name, count(film.actor_id) as Number_of_films
from actor as act
join film_actor as film
on act.actor_id = film.actor_id
group by act.first_name, act.last_name
order by Number_of_films desc
limit 3;

select *
from rental;
select *
from inventory;

select title, rental_duration
from film
order by rental_duration desc
limit 5;

select avg(rental_duration)
from film;

select *
from customer;

select customer_id, count(rental_id)
from rental
group by customer_id
order by count(rental_id) desc;

select cust.customer_id, cust.first_name, cust.last_name, count(rent.rental_id) as total_rental
from customer as cust
join rental as rent
on cust.customer_id = rent.customer_id
group by cust.customer_id, cust.first_name, cust.last_name
order by total_rental desc;

select *
from payment;

select cust.customer_id, cust.first_name, cust.last_name, sum(pay.amount)
from customer AS cust
JOIN payment AS pay
ON cust.customer_id = pay.customer_id
group by cust.customer_id, cust.first_name, cust.last_name
ORDER BY sum(pay.amount) DESC
LIMIT 3;

SELECT *
FROM film_category;

SELECT *
FROM category;

SELECT cat.category_id, cat.`name`, COUNT(film.film_id) AS CNT
FROM category AS cat
JOIN film_category AS film
ON cat.category_id = film.category_id
GROUP BY cat.category_id, cat.`name`
ORDER BY CNT DESC
LIMIT 1;

SELECT *
FROM film;

select *
from rental;
select *
from inventory;

USE sakila;

SELECT *
FROM customer;

SELECT *
FROM address;

SELECT address_id, city_id, postal_code
FROM address
WHERE district = 'california';

SELECT cust.first_name, cust.last_name, cust.email
FROM customer AS cust
JOIN address AS dd
ON cust.address_id = dd.address_id
WHERE district = 'california';

SELECT *
FROM film;

SELECT title, rental_duration
FROM film
WHERE rental_duration > 5;

SELECT *
FROM actor;

SELECT first_name, last_name
FROM actor
WHERE last_name LIKE 'D%';

SELECT *
FROM store;

SELECT * 
FROM address;

SELECT *
FROM country;

SELECT *
FROM city;

SELECT country.country, address.district, city.city, COUNT(store.store_id)
FROM store
JOIN address ON store.address_id = address.address_id
JOIN city ON city.city_id = address.city_id
JOIN country ON country.country_id = city.country_id
GROUP BY 1,2,3;

SELECT *
FROM film;

SELECT title, rental_rate
FROM film
ORDER BY rental_rate DESC
LIMIT 5;

SELECT *
FROM customer;

SELECT *
FROM payment;

SELECT customer.first_name, customer.last_name, sum(payment.amount)
FROM customer
JOIN payment
ON customer.customer_id = payment.customer_id
GROUP BY 1,2;

SELECT *
FROM film;

SELECT AVG(rental_duration)
FROM film;

SELECT *
FROM rental;

SELECT *
FROM customer;

SELECT customer.first_name, customer.last_name, COUNT(*) AS Number_of_rentals
FROM customer
JOIN rental
ON customer.customer_id = rental.customer_id
GROUP BY 1,2
HAVING Number_of_rentals > 10;

SELECT *
FROM staff;

SELECT *
FROM store;

SELECT *
FROM address;

SELECT staff.first_name, staff.last_name, address.district, address.address
FROM staff
JOIN store
ON staff.store_id = store.store_id
JOIN address
ON store.address_id = address.address_id;

SELECT *
FROM rental;

SELECT MAX(rental_date)
FROM rental;

SELECT *
FROM film;

SELECT *
FROM customer;

SELECT *
FROM inventory;

SELECT customer.first_name, customer.last_name, film.title, rental.rental_date, rental.return_date
FROM customer
JOIN rental
ON customer.customer_id = rental.customer_id
JOIN inventory
ON rental.inventory_id = inventory.inventory_id
JOIN film
ON film.film_id = inventory.film_id;

SELECT *
FROM category;

SELECT *
FROM film;

SELECT *
FROM film_category;

SELECT category.`name`, count(film_category.film_id) AS Number_of_films
FROM category 
JOIN film_category
ON category.category_id = film_category.category_id
GROUP BY 1;

SELECT DISTINCT rental.customer_id, customer.first_name, customer.last_name
FROM customer
JOIN rental
ON customer.customer_id = rental.customer_id
WHERE TIMESTAMPDIFF(MONTH, rental.rental_date,'2006-02-14 15:16:03') > 6;

SELECT *
FROM store;

SELECT *
FROM payment;

SELECT *
FROM address;

SELECT address.address, SUM(payment.amount)
FROM payment
JOIN store
ON store.manager_staff_id = payment.staff_id
JOIN address
ON store.address_id = address.address_id
GROUP BY 1;

SELECT *
FROM film;

SELECT title, replacement_cost, rental_rate
FROM film
WHERE replacement_cost > 20;

SELECT *
FROM rental
ORDER BY rental_id;

SELECT *
FROM customer;

SELECT *
FROM payment;

SELECT customer.first_name, customer.last_name, SUM(payment.amount) AS total_amount_spent
FROM customer
JOIN payment
ON customer.customer_id = payment.customer_id
GROUP BY 1,2
ORDER BY total_amount_spent DESC;

SELECT *
FROM rental;

SELECT *
FROM film;

SELECT *
FROM inventory;

SELECT film.film_id, film.title, COUNT(rental.rental_id)
FROM film
JOIN inventory
ON film.film_id = inventory.film_id
JOIN rental
ON rental.inventory_id = inventory.inventory_id
GROUP BY 1,2
ORDER BY COUNT(inventory.inventory_id) DESC
LIMIT 10;

SELECT *
FROM film_category;

SELECT *
FROM payment;

SELECT *
FROM film;

SELECT *
FROM category;

SELECT *
FROM rental;

SELECT *
FROM inventory;

SELECT category.`name`,SUM(payment.amount)
FROM category
JOIN film_category
ON film_category.category_id = category.category_id
JOIN inventory
ON inventory.film_id = film_category.film_id
JOIN rental
ON inventory.inventory_id = rental.inventory_id
JOIN payment
ON payment.rental_id = rental.rental_id
GROUP BY 1 
ORDER BY 2 DESC
LIMIT 1;

SELECT *
FROM customer;

SELECT *
FROM payment;

SELECT YEAR(payment.payment_date) AS `year`, customer.first_name, customer.last_name, SUM(payment.amount) AS 'Total Amount Spent'
FROM payment
JOIN customer
ON payment.customer_id = customer.customer_id
GROUP BY 1,2,3
ORDER BY 1;

SELECT *
FROM film;

SELECT title, rental_rate,
RANK() OVER(ORDER BY rental_rate DESC) AS `rank`
FROM film
LIMIT 10;

SELECT *
FROM store;

SELECT *
FROM payment;

SELECT store.store_id, SUM(payment.amount) AS 'cummulative revenue'
FROM store
JOIN payment
ON store.manager_staff_id = payment.staff_id
GROUP BY 1;

SELECT *
FROM payment;

WITH Ranked_Customers AS
(SELECT customer.first_name, customer.last_name, SUM(payment.amount) AS total_payment
FROM customer
JOIN payment
ON payment.customer_id = customer.customer_id
GROUP BY 1,2)
SELECT first_name, last_name, total_payment,
RANK() OVER(ORDER BY total_payment DESC) AS 'Rank Total Payment'
FROM Ranked_Customers;

SELECT *
FROM rental;

SELECT *
FROM inventory;

SELECT *
FROM film;

WITH RentalDates AS 
(SELECT film.film_id,
rental.rental_date AS rental_start_date,
rental.return_date AS rental_return_date
FROM film
JOIN inventory
ON inventory.film_id = film.film_id
JOIN rental
ON rental.inventory_id = inventory.inventory_id
ORDER BY 1,2),
DatesWithLag AS
(SELECT film_id, rental_start_date, rental_return_date,
LAG(rental_return_date) OVER (PARTITION BY film_id ORDER BY rental_start_date) AS previous_rental_enddate
FROM RentalDates)
SELECT film_id, rental_start_date, rental_return_date, previous_rental_enddate,
DATEDIFF(rental_start_date, previous_rental_enddate) AS gap_duration
FROM DatesWithLag
WHERE DATEDIFF(rental_start_date, previous_rental_enddate) > 0;

SELECT *
FROM rental;

SELECT *
FROM inventory;

SELECT *
FROM film;

SELECT *
FROM customer;

SELECT *
FROM payment;   

SELECT FLOOR(1 + (RAND() * 10));

CREATE VIEW customer_rental_history AS
(SELECT customer.customer_id, customer.last_name, customer.first_name, 
COUNT(rental.rental_id) AS total_rentals, 
SUM(payment.amount) AS total_amount_spent
FROM customer
JOIN payment
ON customer.customer_id = payment.customer_id
JOIN rental
ON rental.rental_id = payment.rental_id
GROUP BY 1,2,3);

SELECT *
FROM customer_rental_history

