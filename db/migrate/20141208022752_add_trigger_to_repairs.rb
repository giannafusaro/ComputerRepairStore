class AddTriggerToRepairs < ActiveRecord::Migration
  def up
    execute <<-SQL
      CREATE TRIGGER update_labor_cost BEFORE UPDATE ON repairs
      FOR EACH ROW
      BEGIN
        DECLARE parts_total DECIMAL(8,2) DEFAULT 0;
        DROP TEMPORARY TABLE IF EXISTS t1;
        CREATE TEMPORARY TABLE t1 (cost DECIMAL(8,2), quantity INT(11), total DECIMAL(8,2));

        INSERT INTO t1
        SELECT cost, quantity, (cost*quantity) FROM parts
        WHERE repair_id = NEW.id;

        SELECT sum(total) INTO parts_total FROM t1;
        SET NEW.total_cost = (parts_total+NEW.labor_cost);
      END
    SQL
  end

  def down
    execute "DROP TRIGGER update_labor_cost;"
  end
end
