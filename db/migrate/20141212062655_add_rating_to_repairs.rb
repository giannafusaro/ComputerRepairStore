class AddRatingToRepairs < ActiveRecord::Migration
  def change
    change_table :repairs do |t|
      t.decimal :rating
    end
  end
end
