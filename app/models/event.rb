class Event < ApplicationRecord
  has_many :user_events, dependent: :destroy
  has_many :users, through: :user_events
  has_many :comments, dependent: :destroy
  has_many :volunteer_hours, dependent: :destroy
  belongs_to :region

  has_one_attached :event_image

  validates :max_limit, presence: true
end
