class MakeOrderDetailsPolymorphic < ActiveRecord::Migration[7.0]
  def change
    remove_reference :order_details, :order, index: true, foreign_key: true
    add_reference :order_details, :order, polymorphic: true, index: true
  end
end
