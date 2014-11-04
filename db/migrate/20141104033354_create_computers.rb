class CreateComputers < ActiveRecord::Migration
  def change
    create_table :computers do |t|
      t.references :customer
      t.string :model
      t.string :serial
      t.string :type
      t.string :warranty
      t.datetime :purchased_at
      t.timestamps
    end
  end
end
