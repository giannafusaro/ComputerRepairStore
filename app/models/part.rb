class Part < ActiveRecord::Base
  belongs_to :repair

  validates :model, presence: true
  validates :serial, presence: true
  validates :cost, presence: true, numericality: true
  validates :quantity, presence: true, numericality: true
end
