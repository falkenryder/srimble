class Order < ApplicationRecord
  belongs_to :supplier
  belongs_to :user
  has_many :order_details
  has_many :products, through: :order_details

  validates :status, presence: true
  validates :status, inclusion: { in: %w[pending sent template] }
end
