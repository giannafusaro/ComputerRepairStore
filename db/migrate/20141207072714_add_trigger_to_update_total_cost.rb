class AddTriggerToUpdateTotalCost < ActiveRecord::Migration
  def up
    execute <<-SQL
      CREATE TRIGGER update_part_cost AFTER UPDATE ON parts
      FOR EACH ROW
      BEGIN
        DECLARE parts_total DECIMAL(8,2) DEFAULT 0;
        DECLARE labor_total DECIMAL(8,2) DEFAULT 0;
        DROP TEMPORARY TABLE IF EXISTS t1;
        CREATE TEMPORARY TABLE t1 (cost DECIMAL(8,2), quantity INT(11), total DECIMAL(8,2));

        INSERT INTO t1
          SELECT cost, quantity, (cost*quantity) FROM parts
          WHERE repair_id = NEW.repair_id;

        SELECT sum(total) INTO parts_total FROM t1;
        SELECT labor_cost INTO labor_total FROM repairs
        WHERE id = NEW.repair_id;

        UPDATE repairs SET repairs.total_cost = (parts_total+labor_total)
        WHERE repairs.id = NEW.repair_id;
      END
    SQL
  end

  def down
    execute "DROP TRIGGER update_part_cost"
  end
end
