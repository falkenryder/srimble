class Product < ApplicationRecord
  validates :name, :price, presence: true

  belongs_to :supplier
end
