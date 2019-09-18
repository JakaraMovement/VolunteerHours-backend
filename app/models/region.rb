class Region < ApplicationRecord
  has_many :events, dependent: :destroy
end
