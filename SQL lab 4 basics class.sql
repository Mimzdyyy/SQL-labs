-- recap
use bank;

select * from bank.loan;

select count(*) from loan; -- count numner rows of loan

select * from trans;

select distinct type as TYPE from trans; -- show different types of table trans

select * from trans;

-- order by balance where operation is not VKLAD order by balance asc

select * from trans where operation != "VKLAD" order by balance asc; -- also <>

select * from trans;

select count(distinct operation) from trans; -- number different operations on table trans

select * from district;

-- rename columns of cities and region and show
select A2 as cities, A3 as region from district;

-- how many cities exist in central Bohemia region
select count(distinct A2) from district where A3 ="central Bohemia";

-- rounding

select order_id, round(amount/100,2) from bank.order; -- give amount divided by 100k with two decimals in bank order showing order_id
select avg(amount) from bank.order; -- mean = 3280.63569
select floor(avg(amount)) from bank.order;-- 3280
select avg(amount) from bank.order;
select ceil(avg(amount)) from bank.order;-- 3281

-- count

select * from bank.order where k_symbol is Null; -- no nulls after manual inspecting weird
select * from bank.order;  
select * from bank.order where not k_symbol is Null;
select count(*) from bank.order; -- confirm no null values ans:6471 (IGNORE)
select count(*) from bank.order where k_symbol is Null; -- no nulls

-- Answer: Null indicates there is no value within a database field for a given record. It does not mean zero because zero is a value. 
-- Blank indicates there is a value within a database but the field is blank.

select * from bank.order where  k_symbol = ""; -- blank vs null
select count(*) from bank.order where  k_symbol = ""; -- blank vs null-- 1379 blanks
-- min/max
select max(amount) from bank.order; -- 14882
select min(amount) from bank.order;  -- 1

--- END RECAP -----

-- Recap

/* Order of Processing
SQL WHERE clause
SQL Arithmetic operators
SQL Comparison operator
SQL Numeric functions
SQL String functions


FSQL DATE_FORMAT() function
SQL CONVERT() function
SQL logical query processing
SQL ORDER BY keyword
SQL ISNULL() function
SQL CASE statement



read more at: https://www.sqlservercentral.com/blogs/sql-server-logical-query-processing
*/

select * from card;
select isnull(card_id) from bank.card; -- returns booleans
select count(isnull(card_id)) from bank.card; -- counts nans like isna().sum()

-- nulls vs blanks // convert

select 10/2;


select *, convert(card_id, date) from card; -- convert card_id into a date
select *, convert(card_id, date) from card where convert(card_id, date) is not null ;

-- replacing nulls
select * from card;

select *, convert(card_id, date) from card; -- convert card_id into a date

-- multiple clauses

select *,
case
when convert(card_id, date) is null then 'Not informed'
else convert(card_id, date)
end as 'ID_to_date' -- giving name of the new column
from bank.card;

-- coalesce special function to replace nulls

select *, coalesce(convert(card_id, date), 'Not informed') from bank.card;

-- note: the NULL values are replaced with the user-given value during the expression value evaluation process.

-- From last class
-- converting to date type
select account_id, district_id, frequency, date, convert(date,date) from bank.account; -- cast(date as date)

-- as timestamp
select account_id, district_id, frequency, date, convert(date,datetime) from bank.account; -- date vs datetime
-- the first argument is the column name and the second is the type you want to convert 
 
 
 -- Pause --
 
 
select issued from bank.card;

select substring(issued, 1, 6) from bank.card; -- 6 digits of the first string column issued

-- the left selects the date
select left(issued, position(' ' in issued)) from card; -- the date

-- the right selects the precision to hours
select right(issued, position(' ' in issued)) from card; -- the time

-- how to select the seconds
select substring(right(issued, position(":" in issued)), 7,8) from card; -- the seconds
select substring(right(issued, position(":" in issued)), 5,8) from card; -- the minutes and seconds 

select issued, convert(substring(issued, 1, 6), date) from bank.card; -- convert to date
select issued, convert(substring(issued, 1, 6), datetime) from bank.card; -- convert to time stamp

-- converting the original format to the date format that we need:
select date_format(convert(date,date), '%Y-%M-%D') from bank.loan; -- interesting format

-- if we just want to extract some specific part of the date
select date_format(convert(date,date), '%M') from bank.loan; -- month 

-- year, month and day in two new columns
select date_format(convert(date,date), '%Y') as year, 
date_format(convert(date,date), '%M') as month, 
date_format(convert(date,date), '%D') as day from bank.loan; 


-- extract

select * from loan;

select CAST(date as date) from bank.loan; -- cast the date

SELECT EXTRACT(DAY from CAST(date as date)) AS day from bank.loan; -- extracts the day of the datestamp
SELECT EXTRACT(month from CAST(date as date)) AS month from bank.loan;
SELECT EXTRACT(year from CAST(date as date)) AS year from bank.loan;

-- solving the blank problem in bank order

select * from bank.order
where k_symbol is null;

select distinct k_symbol from bank.order;

select * from bank.order
where k_symbol is not null and k_symbol = ' '; -- just to show that nulls and emptys are not the same thing

-- case clausule

select loan_id, account_id,
case
when status = 'A' then 'Good - Contract Finished'
when status = 'B' then 'Defaulter - Contract Finished'
when status = 'C' then 'Good - Contract Running'
else 'In Debt - Contract Running'
end as 'Status_Description' -- gives a column name for this new construction
from bank.loan;
