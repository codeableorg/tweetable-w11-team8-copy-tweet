class Like < ApplicationRecord
  belongs_to :user
  has_and_belongs_to :tweet
  # counter_cache: :likes_count
end
