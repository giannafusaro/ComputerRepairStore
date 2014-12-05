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
    self.find result.each[0][0]
  end

  def self.lowest_rated
    self.connection.execute "CALL lowestRatedEmployee(@lowestRatedEmployee);"
    result = self.connection.execute "SELECT @lowestRatedEmployee;"
    result.each[0][0]
  end


end
