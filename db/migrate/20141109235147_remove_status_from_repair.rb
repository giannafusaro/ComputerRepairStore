class RemoveStatusFromRepair < ActiveRecord::Migration
  def up
    remove_column :repairs, :status
  end
  def down
    add_column :repairs, :status, :string
  end
end
