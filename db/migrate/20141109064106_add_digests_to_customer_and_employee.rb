class AddDigestsToCustomerAndEmployee < ActiveRecord::Migration
  def change
    change_table :customers do |t|
      t.string :password_digest
    end

    change_table :employees do |t|
      t.string :password_digest
    end
  end
end
