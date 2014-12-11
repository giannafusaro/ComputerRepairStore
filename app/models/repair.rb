class Repair < ActiveRecord::Base
  belongs_to :customer
  belongs_to :employee
  belongs_to :computer
  has_many :parts

  scope :upcoming, -> { where('requested_for >= ?', Time.now) }
  scope :past, -> { where('requested_for < ?', Time.now) }
  scope :unassigned, -> { where('employee_id IS NULL') }
  scope :order_by_date, -> { order('requested_for desc')}

  accepts_nested_attributes_for :computer, allow_destroy: true

  validates :description, presence: true
  validates :requested_for, presence: true

  def status
    case
    when !employee then "Unassigned"
    when employee && !total_cost then "Pending"
    when total_cost then "Complete"
    end
  end

  def completed_at=(str)
    if str.present?
      self[:completed_at] = DateTime.strptime(str, '%m/%d/%Y %l:%M %p').change(offset: "-0800")
    end
  end


  def requested_for=(str)
    if str.present?
      self[:requested_for] = DateTime.strptime(str, '%m/%d/%Y %l:%M %p').change(offset: "-0800")
    end
  end

  def self.perform_archive
    archive_date = 90.days.ago.strftime('%Y-%m-%d 23:59:59')
    self.connection.execute "CALL archiveRepairs('#{archive_date}');"
    true
  end

end
