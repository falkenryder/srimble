class RemoveUserRefToInventories < ActiveRecord::Migration[7.0]
  def change
    remove_column :inventories, :user_id
  end
end
