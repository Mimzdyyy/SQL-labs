use bank;

select * from loan; 
-- count number of rows of table loan
select count(*) from loan;
select * from trans;
select * from trans;
select distinct type as TYPE from loan;

select * from trans;

-- i want the table where operation is not VKLAD and ordered by balance in order ascenden

select * from trans where operation != "VKLAD";
select * from trans where operation != "VKLAD" order by balance asc;

-- number of different operations on the table trans
select count(distinct operation) from trans; -- 6 types operations on the table trans

select * from district;

-- haw many districts exist in south Bohemia
select count(distinct a2) from district where a3="south Bohemia";

-- rounding
select * from bank.order;
select order_id, round(amount/1000, 3) as easymath from bank.order; -- here we get 3 decimals for the new column easymath

select avg(amount) from bank.order;
select round(avg(amount),2) from bank.order; -- i get the mean of the column amount

select floor(avg(amount)) from bank.order; -- floor needs to give 3280
select ceiling(avg(amount)) from bank.order; -- ceiling of the avg of the column amount that is the smallest integer after that value

select * from bank.order;
-- to get the nans/null values of the column k_symbol

select count(*) from bank.order where k_symbol is null; -- is null

select * from bank.order;
select count(*) from bank.order where k_symbol= ""; -- 1379 blanks on the column k_symbol

-- min vs max of a column
select min(amount) from bank.order;
select max(amount) from bank.order; -- 14882


----- second part ------
select * from card;

-- illustrate the connversation of data types for date and datetime

select *, convert(card_id, date) from card;

select * , convert(card_id, date) from card where convert (card_id, date) is not null;

-- multiple clauses

-- i want the display column telling me if the conversion cards id to date was
-- ccesfull or not, succesfull means that the output is not null

select *
case
when convert(card_id, date) is null then "something wrong" -- null values
else convert (card_id, date)
end as "ID_to_date"
from card;

select * convert(card_id, date) from card where convert(card_id, date);


-- that shows the user when the conversion originated a null value

-- function coalesce

select*, coalesce(convert(card_id, date), "something wrong") from card;

select * from account;
-- i want to convert the column date into a new column called dateformat where the date is in date format

select *, convert(date, date) as dateformat from accouunt;
select *, convert(date,date) as dateformat, convert (date, datetime) as timestampt from account; -- convert always applies to a column in first place
-- secong place you apply the date type
-- nb: date vs datetime




strings

select * from card;

-- goal: take the first substring of the string on the column issued
-- nb: the two substrrings are separated by a space

select left(issued, position(" " in issued)) from card;
-- position gives you the index of what character you write there
-- left is a function that is applied to issued relative to a certain index here chosen by the methhod position

select distinct type from card;

select left(type, position("a" in type)) from card;  -- re we get the left part of the string where an shows up 
-- nb: it creates empty values for the entries that do not have an a

select * from card;
-- now i would like to have the hour,min,sec of the column issued
-- introduce the function right

select right(issued, position(" " in issued)) from card;

-- i want the date now for the column in the right format date

select * from card;
select convert(