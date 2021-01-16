class User < ApplicationRecord
  enum role: {
    member: 0,
    admin: 1
  }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one_attached :avatar
  has_many :tweets, dependent: :destroy
  has_many :likes, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # email and password was create when we  was creating devise User
  validates :name, presence: true
  validates :username, presence: true, uniqueness: true

end
