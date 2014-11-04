class CreateParts < ActiveRecord::Migration
  def change
    create_table :parts do |t|
      t.references :repair
      t.string :model
      t.string :serial
      t.decimal :cost, default: 0, precision: 8, scale: 2
      t.integer :quantity, default: 1
      t.timestamps
    end
  end
end
