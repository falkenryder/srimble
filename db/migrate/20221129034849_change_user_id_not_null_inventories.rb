class ChangeUserIdNotNullInventories < ActiveRecord::Migration[7.0]
  def change
    change_column_null :inventories, :user_id, null: true
  end
end
