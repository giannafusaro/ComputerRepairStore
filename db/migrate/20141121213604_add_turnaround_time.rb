class AddTurnaroundTime < ActiveRecord::Migration
  def change
  	change_table :repairs do |t|
  		t.datetime :completed_at
  	end
  end
end
