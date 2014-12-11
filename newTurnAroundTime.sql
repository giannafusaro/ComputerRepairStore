# 1.
# average turnaround time for store, STORED PROCEDURE
DROP PROCEDURE IF EXISTS average_tat;
DELIMITER //
CREATE PROCEDURE average_tat (OUT average FLOAT(4))
BEGIN
  DECLARE total_count FLOAT(4) DEFAULT 0;
  DECLARE sum FLOAT(4) DEFAULT 0;
  DECLARE temp FLOAT(4) DEFAULT 0;
  DECLARE top INT(4) DEFAULT 0;
  DECLARE bottom INT(4) DEFAULT 0;
  SELECT count(*) INTO total_count
  FROM repairs;
  SELECT max(id) INTO top from repairs;
  select min(id) into bottom from repairs;
  WHILE bottom <= top DO
  	select DATEDIFF(completed_at, created_at) FROM repairs
  	WHERE id = bottom INTO temp;
  	set sum = sum + temp;
  END WHILE;
  SET average = sum / total_count;
END //
DELIMITER ;