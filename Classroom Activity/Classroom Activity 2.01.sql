-- 3.01 Activity 1
-- Keep working on the bank database.


-- 1 Get the number of clients by district, returning district name.
-- 2 Are there districts with no clients? Move all clients from Strakonice to a new district with district_id = 100. Check again. Hint:
-- In case you have some doubts, you can check here how to use the update statement.
-- 3 How would you spot clients with wrong or missing district_id?
-- 4 Return clients to Strakonice.


-- 1
Use bank;

select * from district;
select * from client;


select count(*), A1, A2 from bank.district p
inner join bank.client c
on p.A1 = c.district_id
group by A2
order by A1;

-- 2
	#NO - all districts have some clients
SELECT d.A2, COUNT(c.client_id) AS TotalClients 
FROM bank.district AS d
LEFT JOIN bank.client AS c
	ON c.district_id = d.A1
GROUP BY d.A2
ORDER BY TotalClients ASC;

#Move all clients from Strakonice to a new district with district_id = 100. 
INSERT INTO bank.district (A1, A2)
VALUES ('100', 'district 100');

UPDATE bank.client
SET district_id = REPLACE(district_id,'20','100')
WHERE district_id IS NOT NULL;

	#Check again. Hint: In case you have some doubts, you can check here how to use the update statement.
SELECT d.A2, COUNT(c.client_id) AS TotalClients 
FROM bank.district AS d
LEFT JOIN bank.client AS c
	ON c.district_id = d.A1
GROUP BY d.A2
ORDER BY TotalClients ASC;   

-- 3
select * from client
where district_id <> ' ' or district_id is null;

#Return clients to Strakonice.
select count(*), client.district_id, A2 
from bank.district d
left join bank.client c
on d.A1 = c.district_id
group by A2
order by client.district_id;

-- 4
UPDATE client
SET district_id = 20 
WHERE district_id = 100;