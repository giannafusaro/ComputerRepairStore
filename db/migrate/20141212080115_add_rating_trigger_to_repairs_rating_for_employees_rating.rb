class AddRatingTriggerToRepairsRatingForEmployeesRating < ActiveRecord::Migration
  def up
    execute <<-SQL
      CREATE TRIGGER update_employee_rating AFTER UPDATE ON repairs
      FOR EACH ROW
      BEGIN
        DECLARE average_rating FLOAT(4) default 0;
        DROP TEMPORARY TABLE IF EXISTS t1;
        CREATE TEMPORARY TABLE t1 (rating INT(4));

        INSERT INTO t1
          SELECT rating FROM repairs
          WHERE employee_id = NEW.employee_id;

        SELECT avg(rating) INTO average_rating FROM t1;

        UPDATE employees SET rating = average_rating
        WHERE id = NEW.employee_id;
      END
    SQL
  end

  def down
    execute "DROP trigger update_employee_rating;"
  end
end
