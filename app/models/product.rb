class Product < ApplicationRecord
  include PgSearch::Model
  multisearchable against: [:name]

  validates :name, :price, presence: true

  belongs_to :supplier
end
