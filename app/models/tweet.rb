class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :liked_tweets, through: :likes, source: :tweet
  has_many :replies, class_name: 'Tweet',
                     foreign_key: 'replied_to_id',
                     dependent: :destroy,
                     inverse_of: false
  belongs_to :replied_to, class_name: 'Tweet', optional: true
  # counter_cache: :replies_count
  validates :body, presence: true, length: { maximum: 150 }

  def replies_count
    replies.count
  end
end
