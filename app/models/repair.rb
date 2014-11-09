class Repair < ActiveRecord::Base
  belongs_to :customer
  belongs_to :employee
  belongs_to :computer
  has_many :parts

  def requested_for=(str)
    self[:requested_for] = DateTime.strptime(str, '%m/%d/%Y %I:%M %p') if str.present?
  end
end
