class Event < ApplicationRecord
  has_many :user_events, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :users, through: :user_events
  has_many :volunteer_hours, dependent: :destroy
  belongs_to :region
end
