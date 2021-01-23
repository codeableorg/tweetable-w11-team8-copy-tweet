class AddReferenceToTweet < ActiveRecord::Migration[6.0]
  def change
    add_reference :tweets, :replied_to
  end
end
