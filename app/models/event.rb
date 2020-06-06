class Event < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :volunteer_hours, dependent: :destroy
  has_many :users, through: :volunteer_hours
  belongs_to :region

  has_one_attached :event_image

  validates :name, presence: true
  validates :venue, presence: true
  validates :max_limit, presence: true
  validates :description, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true

  scope :search, -> (search) { where('events.name ILIKE ?', "%#{search}%") }
end
