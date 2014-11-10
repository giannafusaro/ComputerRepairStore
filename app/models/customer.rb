class Customer < ActiveRecord::Base
  has_many :repairs
  has_many :computers

  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true


end
