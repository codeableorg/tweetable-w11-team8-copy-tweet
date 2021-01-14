class User < ApplicationRecord
  enum role: {
    member: 0,
    admin: 1
  }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :tweets, dependent: :destroy
  has_many :likes, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # email and password was create when we  was creating devise User
  validates :name, :username, presence: true
end
