class AddDeliveryAddressRef < ActiveRecord::Migration[7.0]
  def change
    add_reference :orders, :delivery_address, null: false, foreign_key: true
  end
end
