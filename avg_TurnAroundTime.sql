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
