class RemoveReconciledIdToInventories < ActiveRecord::Migration[7.0]
  def change
    remove_column :inventories, :reconciled_id
  end
end
