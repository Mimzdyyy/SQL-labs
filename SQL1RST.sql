use bank;

select * from trans;
select * from client;
select * from client limit 100;
select * from trans;
select trans_id, account_id, date, type from trans; -- selecting just some columns from the table trans
select trans_id from trans limit 5;


-- aliasing columns
select * from trans;
select trans_id as Trans_id, account_id as Acount_ID, date as DATE , type as Typpe_of_account from trans; -- rename/aliansing columns

-- check loans table
select * from loan;
select *, amount - payment as balance from loan; -- this created a new column on your table loan that is the balance of the bank account as it should begin

-- renaming the table
select *from trans;


select trans_id as Trans_id, account_id as Acount_ID, date as DATE , type as Typpe_of_account from trans as bt limit 14;

-- ordering

select * from account;
select * from account order by account_id desc limit 100; -- i get the last 100 rolls of the table account
select * from district order by A4 asc; -- i want to order by column A4 ascending valoues on table district

-- distinct values of the column frequency ordered in descending order from the table account
select * from account;
select distinct frequency, account_id from account order by frequency desc;

-- printing stuff in the console
select "Hello world";
select 5*10;
select power(2,5);

-- the clause where


-- select all table order where column amount has values bigger than 100 ordered in asc order

select * from bank.order;
select * from bank.order where amount > 100 order by amount;

-- select all table order where k_symbol is SIPO

select * from bank.order where k_symbol = "SIPO";

-- multiple clauses where examples

-- filter the table loan where the column amount has values bigger than 200 and where status can be A or B begin

select * from loan where amount > 200 and (status = "B" or status = "A");

select * from loan where amount > 200 and status in ("A", "B");

-- method count

select * from bank.order;
select count(*) from bank.order; -- counts the number of rows of the table order
select * from bank.order;
select count(distinct k_symbol) from bank.order; -- selecting the number of different entries on the column k_symbol
select count(*) from bank.order;
select distinct k_symbol from bank.order; -- where we get the possible entries on the column k_symbol


-- Use an appropriate select statement to retrieve a list of unique card types from the bank database. (Hint: You can use DISTINCT function here.)
select distinct type from bank.card;

-- Get a list of all the district names in the bank database. Suggestion is to use the files_for_activities/case_study_extended here to work out
-- which column is required here because we are looking for the names of places, not just the IDs. It would be great to see the results under the heading
-- district_name. (Hint: Use an alias.). You should have 77 rows.
select * from district;
select distinct A2 as District_Name from district;

