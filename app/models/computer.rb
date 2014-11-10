class Computer < ActiveRecord::Base
  belongs_to :customer

  attr_accessor :offset

  def purchased_at=(str)
    Rails.logger.debug "=========================================================="
    Rails.logger.debug str
    Rails.logger.debug DateTime.strptime(str, '%m/%d/%Y %I:%M %p')
    Rails.logger.debug offset.inspect
    Rails.logger.debug DateTime.strptime(str, '%m/%d/%Y %I:%M %p') + -(offset.to_i.hours)
    Rails.logger.debug "=========================================================="
    if str.present?
      self[:purchased_at] = DateTime.strptime(str, '%m/%d/%Y %I:%M %p') + -(offset.to_i.hours)
    end
  end
end
