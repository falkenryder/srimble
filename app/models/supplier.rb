class Supplier < ApplicationRecord
  has_many :orders
  validates :name, :email, :address, presence: true
  validates :email, format: { with: Devise.email_regexp }

  has_many :products
end
