class Computer < ActiveRecord::Base
  belongs_to :customer
  has_many :repairs

  def purchased_at=(str)
    if str.present?
      self[:purchased_at] = DateTime.strptime(str, '%m/%d/%Y %l:%M %p').change(offset: "-0800")
    end
  end
end
