class CreateOrderTypeColumn < ActiveRecord::Migration[7.0]
  def change
    add_column :order_details, :order_type, :string
  end
end
