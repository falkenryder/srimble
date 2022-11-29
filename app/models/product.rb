class Product < ApplicationRecord
  validates :name, :price, presence: true

  belongs_to :supplier
  has_many :inventories
end
