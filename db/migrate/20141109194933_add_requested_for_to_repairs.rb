class AddRequestedForToRepairs < ActiveRecord::Migration
  def change
    change_table :repairs do |t|
      t.datetime :requested_for
    end
  end
end
