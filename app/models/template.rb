class Template < ApplicationRecord
  validates :name, presence: true

  belongs_to :user
  belongs_to :supplier
  has_many :order_details, foreign_key: :order_id
end
