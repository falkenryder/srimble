class Order < ApplicationRecord
  has_one_attached :photo

  include PgSearch::Model
  multisearchable against: %i[status delivery_date delivery_address]

  attr_accessor :name
  belongs_to :supplier
  belongs_to :user
  belongs_to :delivery_address
  has_many :order_details, as: :order, dependent: :destroy
  has_many :products, through: :order_details

  validates :status, presence: true
  validates :status, inclusion: { in: %w[pending sent delivered] }

  accepts_nested_attributes_for :supplier
  accepts_nested_attributes_for :order_details, reject_if: :all_blank, allow_destroy: true
end
