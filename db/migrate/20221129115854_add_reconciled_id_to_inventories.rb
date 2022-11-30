class AddReconciledIdToInventories < ActiveRecord::Migration[7.0]
  def change
    add_column :inventories, :reconciled_id, :integer
  end
end
