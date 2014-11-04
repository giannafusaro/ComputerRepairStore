class CreateRepairs < ActiveRecord::Migration
  def change
    create_table :repairs do |t|
      t.references :customer
      t.references :employee
      t.references :computer
      t.text :description
      t.decimal :labor_cost, precision: 8, scale: 2
      t.decimal :total_cost, precision: 8, scale: 2
      t.string :status
      t.timestamps
    end
  end
end
