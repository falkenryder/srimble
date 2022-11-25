class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :template, class_name: "Template"
  belongs_to :product

  validates :quantity, presence: true
end
