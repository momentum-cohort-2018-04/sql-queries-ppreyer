The original question text
Your final SQL query (which you must have run and validated on the included database)
The number of results returned (if more than one)
The specific result returned (if a single record is returned)

1. Find all time entries.
-- Query
SELECT *
FROM time_entries;
-- Results: 500 rows

2. Find the developer who joined most recently.
-- Query
SELECT *
FROM developers
ORDER BY joined_on DESC
LIMIT 1;
-- Result: Dr. Danielle McLaughlin

3. Find the number of projects for each client.
-- Query
SELECT clients.id, 
			clients.name,
			COUNT(projects.client_id) AS num_of_projects
FROM clients
LEFT JOIN projects ON projects.client_id = clients.id
GROUP BY clients.id
ORDER BY num_of_projects DESC;
-- Results: 12 rows

4. Find all time entries, and show each one client name next to it.
-- Query
SELECT p.id,
			c.name AS client_name,
			te.id AS time_entries_id,
			te.created_at as time_stamp
FROM projects AS p
LEFT JOIN time_entries AS te ON te.project_id = p.id
JOIN clients AS c ON c.id = p.client_id
ORDER BY c.name;
-- Results: 500 rows

5. Find all developers in the "Ohio sheep" group.
-- Query
SELECT ga.id, 
			g.name, 
			d.name, 
			d.email
FROM developers AS d 
JOIN group_assignments AS ga ON ga.developer_id = d.id
JOIN groups AS g ON g.id = ga.group_id
WHERE g.name = 'Ohio sheep';
-- Results: 3 rows

6. Find the total number of hours worked for each client.
-- Query
SELECT c.id,
			c.name,
			SUM(te.duration) AS project_hours_count
FROM clients AS c
JOIN projects AS p ON c.id = p.client_id
JOIN time_entries AS te ON te.project_id = p.id
GROUP BY c.name
ORDER BY project_hours_count DESC;
-- Results: 9 rows

7. Find the client for whom Mrs. Lupe Schowalter (the developer) has worked the greatest number of hours.
-- Query
SELECT d.id,
			c.name AS client_name,
			d.name AS dev_name,
			d.email,
			SUM(te.duration) AS hours_billed
FROM developers AS d
JOIN time_entries AS te ON te.developer_id = d.id
JOIN projects AS p ON p.id = te.project_id
JOIN clients AS c ON c.id = p.client_id
WHERE d.name = "Mrs. Lupe Schowalter"
GROUP BY c.name
ORDER BY hours_billed DESC
LIMIT 1;
-- Result: Kuhic-Bartoletti

8. List all client names with their project names (multiple rows for one client is fine). Make sure that clients still show up even if they have no projects.
-- Query
SELECT c.id,
			c.name,
			p.name
FROM clients AS c
LEFT JOIN projects AS p ON p.client_id = c.id
ORDER BY c.name;
-- Result: 33 rows

9. Find all developers who have written no comments.
-- Query
SELECT d.id,
			d.name,
			d.email,
			c.comment
FROM developers AS d
LEFT JOIN comments AS c ON c.developer_id = d.id
WHERE c.comment IS NULL;
-- Result: 13 rows

10. Find all developers with at least five comments.
-- Query
SELECT d.id,
			d.name,
			d.email,
			COUNT(c.id) AS num_of_dev_comments
FROM developers AS d
LEFT JOIN comments AS c ON c.developer_id = d.id
GROUP BY d.name
ORDER BY num_of_dev_comments DESC;
-- Result: 50 rows

11. Find the developer who worked the fewest hours in January of 2015.
-- Query
SELECT d.id,
			d.name,
			d.email,
			SUM(te.duration) AS hours_billed
FROM developers AS d
JOIN time_entries AS te ON te.developer_id = d.id
WHERE te.worked_on >= '2015-01-01' AND te.worked_on < '2015-02-01';
-- Result: Mr. Leopold Carter