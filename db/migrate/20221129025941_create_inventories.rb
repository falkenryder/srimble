class CreateInventories < ActiveRecord::Migration[7.0]
  def change
    create_table :inventories do |t|
      t.references :products, null: false, foreign_key: true
      t.integer :quantity_bal, null: false
      t.integer :par_bal, null: false
      t.references :user, null: false, foreign_key: {name: 'reconciled_id'}
      t.datetime "reconciled_at"
      t.timestamps
    end
  end
end
