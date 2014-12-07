class AddTriggerToUpdateTotalCost < ActiveRecord::Migration
  def up
    execute <<-SQL
      CREATE TRIGGER update_cost AFTER UPDATE ON parts
      FOR EACH ROW
      BEGIN
        DECLARE existing_total INT(11) DEFAULT 0;

        SELECT repairs.total_cost INTO existing_total FROM repairs
        WHERE repairs.id = OLD.repair_id;

        UPDATE repairs SET repairs.total_cost=(NEW.cost*NEW.quantity)
        WHERE repairs.id = NEW.repair_id;
      END
    SQL
  end

  def down
    execute "DROP TRIGGER update_cost"
  end
end
