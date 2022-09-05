-- Lab | SQL Queries 4



-- Get film ratings.
select
	distinct rating
from 
	sakila.film;

-- Get release years.
select
	distinct release_year
from
	sakila.film;

-- Get all films with ARMAGEDDON in the title.
select
	title
from
	sakila.film;

select 
	title
from 
	sakila.film
where
	title regexp '^Armageddon';

-- Get all films with APOLLO in the title
select
	*
from
	sakila.film
where
	title regexp 'apollo';


-- Get all films which title ends with APOLLO.
select
	*
from 
	sakila.film
Where
	title regexp 'apollo';

-- Get all films with word DATE in the title.
select
	*
from 
	sakila.film
where
	title regexp 'date';

-- Get 10 films with the longest title.
select
	title
from 
	sakila.film
order by
	length(title) desc
limit 10;

-- Get 10 the longest films.
select
	length, title
from 
	sakila.film
order by 
	title, length desc
limit 10;

-- How many films include Behind the Scenes content?
select
	count(special_features) 
from
	sakila.film
where 
special_features like 'behind the scenes';


-- List films ordered by release year and title in alphabetical order.
select
	title, release_year
from
	sakila.film
order by
	release_year, title;
