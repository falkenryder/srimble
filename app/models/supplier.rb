class Supplier < ApplicationRecord
  include PgSearch::Model
  multisearchable against: [:name]

  has_many :orders
  has_many :templates
  validates :name, :email, :address, presence: true
  validates :email, format: { with: Devise.email_regexp }

  has_many :products
end
