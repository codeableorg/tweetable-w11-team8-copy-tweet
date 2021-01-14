class CreateTweets < ActiveRecord::Migration[6.0]
  def change
    create_table :tweets do |t|
      t.text :body
      t.integer :replies_count
      t.integer :likes_count
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
