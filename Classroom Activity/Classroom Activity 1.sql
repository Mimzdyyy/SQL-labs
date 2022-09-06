-- 2.08 Activity 1
-- In this activity, we will be using the table district from the bank database and according to the description for the different columns:


use bank;
-- 01 Rank districts by different variables.
select A2, A12, dense_rank() over(order by A12) as Unemployment_Rate
from bank.district;
-- 02 Do the same but group by region.
select A2, A3, dense_rank() over(partition by A3 order by A2) as region
from bank.district;

-- 2.08 Activity 2

-- 1 Use the transactions table in the bank database to find the Top 20 account_ids based on the amount.
select account_id, amount, DENSE_RANK() over(order by amount desc) as Top20
from bank.trans
Limit 20;
-- 2 Illustrate the difference between rank() and dense_rank().
select account_id, amount, DENSE_RANK() over(order by amount desc) as Top20, RANK() over(order by amount desc) as Ranked20
from bank.trans
Limit 20;

-- 2.08 Activity 3

-- 1 Get a rank of districts ordered by the number of customers.
select count(client_id) as 'Client', rank () over (order by count(client_id)) from client
group by district_id;

-- 2 Get a rank of regions ordered by the number of customers.
select count(client_id) as NofClients, A3, rank() over (order by count(client_id)) as 'Rank' from client a
join district l on a.district_id = l.A1
group by A3
order by NofCLients;

-- 3 Get the total amount borrowed by the district together with the average loan in that district.
select sum(amount) as TotalAmount, avg(amount) as AvgLoan, district_id from disp a
join loan l on a.account_id = l.account_id
join client d on a.client_id = d.client_id
group by district_id
order by district_id;

-- 4 Get the number of accounts opened by district and year.
select district_id, substr(date,1,2) as 'Year', count(a.account_id) as NumberofAccounts from disp a
join client d on a.client_id = d.client_id
join trans l on a.account_id = l.account_id
group by district_id, 'Year'
order by district_id;
select district_id, count(account_id), substr(date,1,2) as 'year' from bank.account
group by district_id, 'year';
