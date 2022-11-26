class Order < ApplicationRecord
  belongs_to :supplier
  belongs_to :user
  belongs_to :delivery_address
  has_many :order_details, as: :order, dependent: :destroy
  has_many :products, through: :order_details

  validates :status, presence: true
  validates :status, inclusion: { in: %w[pending sent template delivered] }

  accepts_nested_attributes_for :supplier
  accepts_nested_attributes_for :order_details, reject_if: :all_blank, allow_destroy: true
end
