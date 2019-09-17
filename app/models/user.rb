class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_events
  has_many :events, through: :user_events
  has_many :volunteer_hours
  has_many :comments

  validates :first_name,
            :last_name,
            :address,
            :birthday,
            :gender,
            :phone,
            :city,
            :state,
            :zip_code,
            :parent_email,
            :parent_first_name,
            :parent_last_name,
            :parent_phone,
            :school_year, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } 
  validates :parent_email, format: { with: URI::MailTo::EMAIL_REGEXP }

  enum gender: {
    male: 0,
    female: 1,
    other: 2
  }
end
