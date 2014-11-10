class Employee < ActiveRecord::Base
  has_many :repairs

  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true


end
