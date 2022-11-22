class CreateSuppliers < ActiveRecord::Migration[7.0]
  def change
    create_table :suppliers do |t|
      t.string :name
      t.string :email
      t.text :address

      t.timestamps
    end
  end
end
