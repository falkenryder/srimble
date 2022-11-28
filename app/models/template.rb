class Template < ApplicationRecord
  validates :name, presence: true

  belongs_to :user
  belongs_to :supplier
  has_many :order_details, as: :order, dependent: :destroy
  has_many :products, through: :order_details

  accepts_nested_attributes_for :supplier
  accepts_nested_attributes_for :order_details, reject_if: :all_blank, allow_destroy: true
end
