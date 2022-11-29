class ChangeColumnInventories < ActiveRecord::Migration[7.0]
  def change
    remove_reference :inventories, :products, foreign_key: true
  end
end
