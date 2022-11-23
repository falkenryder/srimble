class CreateDeliveryAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :delivery_addresses do |t|
      t.string :address, null: false
      t.string :contact_number, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
