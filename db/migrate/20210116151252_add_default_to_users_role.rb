class AddDefaultToUsersRole < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :role, :integer, null: false,  default: 0
  end
end
