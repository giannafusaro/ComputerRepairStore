class Employee < ActiveRecord::Base
  has_many :repairs

  has_secure_password
end
