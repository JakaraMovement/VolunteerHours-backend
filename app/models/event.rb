class Event < ApplicationRecord
  has_many :user_events
  has_many :comments
  has_many :users, through: :user_events
  has_many :volunteer_hours
  belongs_to :region
end
