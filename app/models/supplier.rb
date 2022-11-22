class Supplier < ApplicationRecord
  validates :name, :email, :address, presence: true
end
