class AddDeliveryDateAndCommentsColumns < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :delivery_date, :date
    add_column :orders, :comments, :text
  end
end
