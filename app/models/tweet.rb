class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :replies, class_name: 'Tweet',
                     foreign_key: 'replied_to_id',
                     dependent: :destroy,
                     inverse_of: false
  belongs_to :replied_to, class_name: 'Tweet', optional: true
  validates :body, presence: true, length: { maximum:150 }
  validate :replies_count, :likes_count, default: 0, numericality: { only_integer: true }
end
