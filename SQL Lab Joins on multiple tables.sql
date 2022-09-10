#Lab | SQL Joins on multiple tables



-- 1 Write a query to display for each store its store ID, city, and country.
-- 2 Write a query to display how much business, in dollars, each store brought in.
-- 3 What is the average running time of films by category?
-- 4 Which film categories are longest?
-- 5 Display the most frequently rented movies in descending order.
-- 6 List the top five genres in gross revenue in descending order.
-- 7 Is "Academy Dinosaur" available for rent from Store 1?


-- 1
select a.store_id, b.address, c.city, d.country from sakila.store as a
inner join sakila.address as b
using(address_id)
inner join sakila.city as c
using(city_id)
inner join sakila.country as d
using(country_id);


-- 2
select a.store_id, round(sum(c.amount)) as business_brought from sakila.store as a
inner join sakila.staff as b
using(store_id)
inner join sakila.payment as c
using(staff_id)
group by store_id;


-- 3
select a.category_id, a.name, round(avg(c.length)) as avg_duration from sakila.category as a
inner join sakila.film_category as b
using(category_id)
inner join sakila.film as c
using(film_id)
group by category_id
order by avg_duration desc;



-- 4
select a.name, avg(length) as avgl
from film f
join sakila.film_category b on b.film_id = b.film_id
join category_id c on c.category_id = c.category_id
group by c.category_id
order by avgl desc
limit 3;




-- 6
select a.category_id, a.name, sum(e.amount) as gross_revenue from sakila.category as a
inner join sakila.film_category as b
using(category_id)
inner join sakila.inventory as c
using(film_id)
inner join sakila.rental as d
using(inventory_id)
inner join sakila.payment as e
using(rental_id)
group by category_id
order by gross_revenue desc
limit 5;


-- 7
select a.film_id, a.title, b.store_id from sakila.film as a
inner join sakila.inventory as b
using(film_id)
inner join sakila.store as c
using(store_id)
where a.title="Academy Dinosaur"
group by store_id;