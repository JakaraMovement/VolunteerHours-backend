class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :event
  has_many_attached :image

  validates_length_of :text, minimum: 1, maximum: 500
end
