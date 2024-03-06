class ChangeUserIdToInterger < ActiveRecord::Migration[7.1]
  def change
    change_column :recipes, :user_id, :integer, using: 'user_id::integer'
  end
end