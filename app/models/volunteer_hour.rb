class VolunteerHour < ApplicationRecord
  belongs_to :event
  belongs_to :user

  enum status: { requested: 0, accepted: 1, rejected: 2 }

  before_save :max_limit_check

  private

  def max_limit_check
  	throw :abort if time_worked > event.max_limit
  end
end
