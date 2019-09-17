class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :event
  has_many_attached :image

  validates :text, presence: true
end
