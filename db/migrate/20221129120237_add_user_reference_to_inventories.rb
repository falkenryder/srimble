class AddUserReferenceToInventories < ActiveRecord::Migration[7.0]
  def change
    add_reference :inventories, :user, foreign_key: true
  end
end
