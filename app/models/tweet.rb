class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :replies, class_name: 'Tweet',
                     foreign_key: 'replied_to_id',
                     dependent: :destroy,
                     inverse_of: false
  belongs_to :replied_to, class_name: 'Tweet', optional: true
end
