
# add foreign key constraints
# for referential integrity
ALTER TABLE repairs
ADD FOREIGN KEY (customer_id)
REFERENCES customers(id);

ALTER TABLE repairs
ADD FOREIGN KEY (employee_id)
REFERENCES employees(id);

ALTER TABLE repairs
ADD FOREIGN KEY (computer_id)
REFERENCES computers(id);

ALTER TABLE computers
ADD FOREIGN KEY (part_id)
REFERENCES parts(id);



# 1.
# average turnaround time for store, STORED PROCEDURE
DROP PROCEDURE IF EXISTS avg_TurnAroundTime;
DELIMITER //
CREATE PROCEDURE avg_TurnAroundTime (OUT average FLOAT(4))
BEGIN
  DECLARE total_count INT DEFAULT 0;
  DECLARE sum INT DEFAULT 0;
  SELECT count(*) INTO total_count
  FROM repairs;
  SELECT SUM(DATEDIFF(completed_at, created_at)) INTO sum
  FROM repairs;
  SET average = sum / total_count;
END //


# 2.
# return id for lowestRatedEmployee, STORED PROCEDURE
DROP PROCEDURE IF EXISTS lowestRatedEmployee;
DELIMITER //
CREATE PROCEDURE lowestRatedEmployee (OUT lowestRated INT(4))
BEGIN
DECLARE newLowest INT DEFAULT 0;
SELECT id INTO newLowest
FROM employees
WHERE rating IN (SELECT MIN(rating) FROM employees);
SET lowestRated = newLowest;
END //

# 3.
#count => count how many unassigned repairs there are and put badge next to “unassigned repairs” in Employee site
SELECT COUNT(*) FROM repairs  WHERE (employee_id IS NULL);

# 4.
# Co-Related Query
SELECT emp.name, emp.rating, emp.title
FROM employees AS emp
WHERE emp.rating > (
  SELECT AVG(emp2.rating)
  FROM employees AS emp2
  WHERE emp2.title = emp.title
);

# 5.
# Group-By and Having
# return name and number of repairs of employees who have completed more than one repair
SELECT e.name, COUNT(r.employee_id)
FROM repairs AS r
INNER JOIN employees AS e
ON r.employee_id = e.id
GROUP BY e.name
HAVING COUNT(r.employee_id) > 1;

# 6.
# Aggregation
# return name and number of repairs for each employee
SELECT e.name, COUNT(r.employee_id)
FROM repairs AS r
INNER JOIN employees AS e
ON r.employee_id = e.id
GROUP BY e.name

# 7.
# Full-Outer Join
# return customers who have never had a repair
SELECT c.name, r.id FROM customers AS c
LEFT JOIN repairs AS r ON c.id = r.customer_id
UNION
SELECT c.name, r.id FROM customers AS c
RIGHT JOIN repairs AS r ON c.id = r.customer_id;

# 8.
# UPDATE
# EXAMPLE OF AN UPDATE TO REPAIRS
UPDATE repairs SET computer_id = 41, labor_cost = 34.0, updated_at = '2014-12-04 01:53:10'
WHERE repairs.id = 31

# 9.
# DELETE
# Example of delete from repairs
DELETE FROM repairs WHERE repairs.id = 34

# 10.
# Order By
# List all repairs in order of date requested for
SELECT repairs.* FROM repairs  WHERE repairs.employee_id = 40  ORDER BY requested_for desc

# 11.
# Using AND
# Finding all past repairs
SELECT repairs.* FROM repairs  WHERE repairs.customer_id = 39 AND (requested_for < '2014-11-22 00:00:24')  ORDER BY requested_for desc

# 12.
# Intersect
# return customer id of customers who have been served by an employee who hasn't been rated


# 13.
# employee of the month, STORED PROCEDURE
CREATE PROCEDURE employeeOfTheMonth (OUT employeeOfMonth INT(4))
BEGIN
CREATE TEMPORARY TABLE Result (rating INT(4), employee_id INT(4), RepairNumber INT(4));
INSERT INTO Result
SELECT employees.rating, repairs.employee_id, count(*) AS NumberOfRepairs FROM
(repairs INNER JOIN employees
  ON repairs.employee_id = employees.id)
  GROUP BY employee_id
  HAVING max(employees.rating)
  ORDER BY NumberOfRepairs DESC LIMIT 1;
  SELECT employee_id from Result into employeeOfMonth;
  END //
  DELIMETER ;
  
