class VolunteerHour < ApplicationRecord
  belongs_to :event
  belongs_to :user

  delegate :region, to: :event, allow_nil: true

  REQUESTED = 'requested'
  ACCEPTED = 'accepted'
  REJECTED = 'rejected'

  validates_presence_of :event
  validates_presence_of :user

  scope :reviewed, -> { where(status: [ACCEPTED, REJECTED]) }
  scope :pending_review, -> { where(status: REQUESTED) }

  enum status: { requested: 0, accepted: 1, rejected: 2 }

  before_save :max_limit_check

  private

  def max_limit_check
  	throw :abort if time_worked > event.max_limit
  end
end
