-- 3.01 Activity 4


-- 1 Make a list of all the clients together with region and district, ordered by region and district.
-- 2 Count how many clients do we have per region and district.
-- How many clients do we have per 10000 inhabitants?


-- 1
SELECT  client_id, A2 as district_name, A3 as region
FROM bank.client as client_table
JOIN bank.district as district_table on client_table.district_id = district_table.A1
ORDER BY region, district_name;


-- 2
-- per region
SELECT A3 as region,count(client_id)
FROM bank.client as client_table
JOIN bank.district as district_table on client_table.district_id = district_table.A1
GROUP BY region;

-- per district
SELECT  A2 as district_name, count(client_id)
FROM bank.client as client_table
JOIN bank.district as district_table on client_table.district_id = district_table.A1
GROUP BY district_name;

--  per 10000 inhabitants per district
SELECT count(client_id), (count(client_id)*10000/A4), A2
FROM bank.client as client_table
JOIN bank.district as district_table on client_table.district_id = district_table.A1
GROUP BY A4, A2;

