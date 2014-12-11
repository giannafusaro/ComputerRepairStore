class AddForeignKeyContraintsToModels < ActiveRecord::Migration
  def up
    execute "ALTER TABLE repairs ADD FOREIGN KEY (customer_id) REFERENCES customers(id);"
    execute "ALTER TABLE repairs ADD FOREIGN KEY (employee_id) REFERENCES employees(id);"
    execute "ALTER TABLE repairs ADD FOREIGN KEY (computer_id) REFERENCES computers(id);"
    execute "ALTER TABLE parts ADD FOREIGN KEY (repair_id) REFERENCES repairs(id);"
  end

  def down
    # execute "ALTER TABLE repairs DROP FOREIGN KEY customer_id;"
    # execute "ALTER TABLE repairs DROP FOREIGN KEY employee_id;"
    # execute "ALTER TABLE repairs DROP FOREIGN KEY computer_id;"
    # execute "ALTER TABLE parts DROP FOREIGN KEY repair_id;"
  end
end
