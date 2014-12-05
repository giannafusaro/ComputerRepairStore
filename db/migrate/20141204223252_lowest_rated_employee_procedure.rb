class LowestRatedEmployeeProcedure < ActiveRecord::Migration
  def up
    execute <<-SQL
      CREATE PROCEDURE lowestRatedEmployee (OUT lowestRated INT(4))
      BEGIN
        DECLARE newLowest INT DEFAULT 0;
        SELECT id INTO newLowest
        FROM employees
        WHERE rating IN (SELECT MIN(rating) FROM employees);
        SET lowestRated = newLowest;
      END
    SQL
  end

  def down
    execute <<-SQL
      DROP PROCEDURE IF EXISTS lowestRatedEmployee;
    SQL
  end


end
