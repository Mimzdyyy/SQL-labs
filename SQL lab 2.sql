-- How many distinct (different) actors' last names are there?
select count(distinct last_name) as "Total of Different Last Names" from sakila.actor;

-- In how many different languages where the films originally produced? (Use the column language_id from the film table)
select count(distinct language_id) as "Total of Different Languages Produced" from sakila.film;

-- How many movies were released with "PG-13" rating?
select count(rating) from sakila.film where rating =  "PG-13";  

-- Get 10 the longest movies from 2006.
select title, length, release_year from sakila.film where release_year = '2006' order by length desc limit 10;

-- How many days has been the company operating (check DATEDIFF() function)?
select datediff(min(rental_date), max(rental_date)) as "Days Operating" from sakila.rental;
		
-- Show rental info with additional columns month and weekday. Get 20.


-- Show rental info with additional columns month and weekday. Get 20.
select
	*, 
    case
	when 
		date_format(rental_date, '%W') in ('Saturday', 'Sunday') then 'Weekend'
	else 'Workday'
end as Days_type
from
	sakila.rental;

-- Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.
select *, 
    case
	when 
		date_format(rental_date, '%W') in ('Saturday', 'Sunday') then 'Weekend'
	else 'Workday'
end as Days_type from sakila.rental;

-- How many rentals were in the last month of activity?
select date(max(rental_date)) - interval 30 day, date(max(rental_date)) from sakila.rental;    
select max(rental_date) from sakila.rental;
select count(*) from sakila.rental where date(rental_date) between date('2006-02-01') and date ('2006-02-14')
