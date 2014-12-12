class Employee < ActiveRecord::Base
  has_many :repairs

  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  def self.average_turnaround_time
    self.connection.execute "CALL avg_TurnAroundTime(@average);"
    result = self.connection.execute "SELECT @average;"
    result.each[0][0].to_f.round(2)
  end

  def self.of_the_month
    self.connection.execute "CALL employeeOfTheMonth(@employeeOfTheMonth);"
    result = self.connection.execute "SELECT @employeeOfTheMonth;"
    emp_id = result.each[0][0]
    unless emp_id.nil? || emp_id==0
      self.find emp_id
    end
  end

  def self.lowest_rated
    where('rating IS NOT NULL').order(rating: :asc).first
  end

  def self.n00b
    result = self.connection.execute "SELECT employees.id FROM employees WHERE employees.id NOT IN (SELECT employees.id FROM employees JOIN repairs ON employees.id = repairs.employee_id);"
    result.each[0][0]
  end

  def self.old_hats
    result = self.connection.execute "SELECT e.name, COUNT(r.employee_id) FROM repairs AS r INNER JOIN employees AS e ON r.employee_id = e.id GROUP BY e.name HAVING COUNT(r.employee_id) > 1;"
    # emp_id = result.each[0][0] if result && result.each && result.each[0]
    # unless emp_id.nil? || emp_id==0
    #   self.find emp_id
    # end
  end


end
