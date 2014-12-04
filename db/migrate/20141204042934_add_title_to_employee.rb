class AddTitleToEmployee < ActiveRecord::Migration
  def up
    change_table :employees do |t|
      t.string :title
    end

    Employee.reset_column_information
    titles = ['Level 1 Tech', 'Level 2 Tech', 'Level 3 Tech', 'Manager']

    Employee.all.each do |employee|
      employee.title = titles[rand(0..titles.length-1)]
      employee.save
    end
  end

  def down
    remove_column :employees, :title
  end
end
