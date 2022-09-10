use bank;

#saturday 10.09.22

#wrm update
-- 0. gather account_id, district_id,frequency, district name, region, loan_id, amount, pauments

-- tables: account, district, loan

select * from account; -- a
select * from loan; -- l
select * from district; -- d

select a.account_id, a.district_id, a.frequency, d.A2, d.A3, l.loan_id, l.amount, l.payments
from bank.account a
join bank.district as d on a.district_id = d.A1
join bank.loan as l
on l.account_id = a.account_id;

-- 1. list the clients with no credit card

-- table client
select * from client;
-- credit cards are on table card 
select * from card;
-- operation on the query: group by by client_id
-- disp table in going to be our linking table
select * from disp; -- client_id, disp_id, d

select cl.client_id, count(c.card_id) as number_cards
from client cl
join disp d on cl.client_id = d.client_id
left join card c on c.disp_id = d.disp_id
group by client_id
having number_cards = 0;

-- 2. list districts together with total amount borrowed and avg loan amount.alter



## tables: districts, loan
## columns:
## query: group by districts and the aggregation sum(amount), sum(amount)/count(*)

select * from district; -- key districts is A1
select count(distinct A1) from district;
select * from account; -- account_id, district_id

select A as district_name,sum(l.amount) as total_borrowed, sum(l.amount)/count(*) as avereged_loan
from bank.loan as l
left join bank.account as a
on l.account_id = a.account_id
left join district d on d.A1 = a.district_id
group by A2
order by district_name;


-- store on a temporary table the regions together with the total_borrowed and the avg loan_amount

create temporary table if not exists bank_table_region
select A3 as region, sum(l.amount) as total_borrowed, sum(l.amount)/count(*) as averaged_loan
from bank.loan as l
left join bank.account as a
on l.account_id = a.account_id
left join district d on d.A1 = a.district_id
group by A3
order by region;

select * from bank_table_region;

-- self join:
## it allows you to join a table with itself, useful when comaring rows within the same
-- you use it if you have two or more different values in the same column that you want to display

select * from disp;
-- list the accounts that both OWNER and DISOPONENT on the column type
select * from bank.disp d1
join bank.disp d2
on d1.account_id = d2.account_id
and d1.type <> d2.type
where d1.type ="DISPONENT";

-- cross join
-- (A,B,C) x (1,2) : (A,1

-- find all the possible combinations of different card and ownership of the account

select * from disp;
select * from card;

-- syntax of the query

select * from (select distinct type from bank.card
) sub1
cross join( select distinct type from bank.disp
) sub2;

-- another way(less efficient)

select distinct d.type, c.type from bank.card c
join bank.disp d;

-- exercise: identify the customers who borrowed an amount higher than the average loan


-- SELECT
  -- c.cust_name,
 --  l.loan_number,
--   l.amount
-- FROM customer c
-- LEFT JOIN take t ON t.cust_id = c.cust_id
-- LEFT JOIN loan l ON l.loan_number = t.loan_number
-- WHERE l.branch_name = ’perryridge’ AND NOT l.loan_number IS NULL


-- table: loan
select * from bank.loan;
select avg(amount) from bank.loan;

select * from bank.loan where amount>(select avg(amount) from bank.loan)
order by amount;

## a nice one: return the regions with highes number of inhabitants per district
select * from district;
## A4 is the number_inhabitants
##A3 is the region
##aggrigation is in A3

# step 1: subquery
-- example 1
select A2, A3, max(A4) from district
group by A3;

-- example 2
select A3, count(A2) amount_districts, sum(A4) inhabitants from bank.district
group by A3
order by amount_districts;

#step 2: we write the main query

select A3, amount_districts, inhabitants,
rank() over(partition by amount_districts order by inhabitants) as "ranking"
from (select A3, count(A2) amount_districts, sum(A4) inhabitants from bank.district
group by A3
order by amount_districts
) alias;

# step 3:final query ranking=1

select A3, amount_districts, inhabitants
from (select A3, amount_districts, inhabitants,
rank() over (partition by amount_districts order by inhabitants) as "ranking"
from(select A3,count(A2) as amount_districts, sum(A4) inhabitants from bank.district
group by A3
order by amount_districts) sub_in
) as sub_out
where ranking =1;