class EmployeeOfTheMonthProcedure < ActiveRecord::Migration
  def up
    execute <<-SQL
      CREATE PROCEDURE employeeOfTheMonth
      (OUT employeeOfMonth INT(4))
      BEGIN
        DROP TEMPORARY TABLE IF EXISTS Result;
        CREATE TEMPORARY TABLE Result (rating INT(4), employee_id INT(4), RepairNumber INT(4));
        INSERT INTO Result
          SELECT employees.rating, repairs.employee_id, count(*) AS NumberOfRepairs
          FROM (repairs INNER JOIN employees ON repairs.employee_id = employees.id)
          GROUP BY employee_id
          HAVING max(employees.rating)
          ORDER BY NumberOfRepairs DESC LIMIT 1;
        SELECT employee_id from Result into employeeOfMonth;
      END
    SQL
  end

  def down
    execute <<-SQL
      DROP PROCEDURE IF EXISTS employeeOfTheMonth;
    SQL
  end
end
