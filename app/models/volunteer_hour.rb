class VolunteerHour < ApplicationRecord
  belongs_to :event
  belongs_to :user

  validates :time_worked, presence: true
  enum status: { requested: 0, accepted: 1, rejected: 2 }
end
