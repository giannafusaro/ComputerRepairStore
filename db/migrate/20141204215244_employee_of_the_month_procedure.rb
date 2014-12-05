class EmployeeOfTheMonthProcedure < ActiveRecord::Migration
  def up
    execute <<-SQL
      CREATE PROCEDURE employeeOfTheMonth
      (OUT employeeOfMonth INT(4))
      BEGIN
        DECLARE eom INT(4) DEFAULT 0;
        DROP TEMPORARY TABLE IF EXISTS t1;
        CREATE TEMPORARY TABLE t1 (employee_id INT(4), employee_rating INT(1), employee_repairs INT(4));
        DROP TEMPORARY TABLE IF EXISTS t2;
        CREATE TEMPORARY TABLE t2 (employee_id INT(4), score DECIMAL(4, 2));

        INSERT INTO t1
          SELECT e.id, e.rating, COUNT(r.employee_id) FROM employees e
          JOIN repairs r ON e.id = r.employee_id
            WHERE
            r.created_at >= DATE_FORMAT( CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m-%d 00:00:00' )
            AND
            r.created_at < DATE_FORMAT( CURRENT_DATE, '%Y-%m-%d 23:59:59' )
          GROUP BY e.id;

        INSERT INTO t2
          SELECT employee_id, AVG(employee_rating + employee_repairs) AS score FROM t1
          GROUP BY employee_id;

        SELECT employee_id INTO eom FROM t2
        ORDER BY score DESC
        LIMIT 1;

        SET employeeOfMonth = eom;
      END
    SQL
  end

  def down
    execute <<-SQL
      DROP PROCEDURE IF EXISTS employeeOfTheMonth;
    SQL
  end
end
