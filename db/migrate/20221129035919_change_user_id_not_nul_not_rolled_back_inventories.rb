class ChangeUserIdNotNulNotRolledBackInventories < ActiveRecord::Migration[7.0]
  def change
    change_column_null(:inventories, :user_id, true)
  end
end
