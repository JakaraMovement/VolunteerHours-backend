class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :volunteer_hours, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :user_events
  has_many :events, through: :user_events

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :address, presence: true
  validates :birthday, presence: true
  validates :gender, presence: true
  validates :phone, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true
  validates :parent_email, presence: true
  validates :parent_first_name, presence: true
  validates :parent_last_name, presence: true
  validates :parent_phone, presence: true
  validates :school_year, presence: true
  validates :email, presence: true, uniqueness: true
  validates :parent_email, presence: true

  enum gender: {
    Female: 0,
    Male: 1,
    Other: 2
  }

  def name
    "#{first_name} #{last_name}"
  end

  def parent_name
    "#{parent_first_name} #{parent_last_name}"
  end

  def volunteer
    gender.eql?('Female') ? 'Sevadarni' : 'Sevadar'
  end
end
