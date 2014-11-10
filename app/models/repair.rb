class Repair < ActiveRecord::Base
  belongs_to :customer
  belongs_to :employee
  belongs_to :computer
  has_many :parts

  scope :upcoming_repairs, lambda { where('requested_for >= ?', Time.now) }
  scope :past_repairs, lambda { where('requested_for < ?', Time.now) }

  def requested_for=(str)
    self[:requested_for] = DateTime.strptime(str, '%m/%d/%Y %I:%M %p') if str.present?
  end

  def status
    case
    when !employee then "Unassigned"
    when employee && !total_cost then "Pending"
    when total_cost then "Complete"
    end
  end


end
