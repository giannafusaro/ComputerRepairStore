# created by Brandon Cruz

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
DELIMITER ;


# to use this stored procedure:
# set @myvariable = 0;
# call employeeOfTheMonth(@myvariable);
# select @myvariable;
#
#
DROP PROCEDURE IF EXISTS employeeOfTheMonth;
DELIMITER //
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


# Find the lowest rated employee using the MIN function
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