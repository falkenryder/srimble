class OrderDetail < ApplicationRecord
  belongs_to :order, polymorphic: true
  belongs_to :product

  validates :quantity, presence: true
end
