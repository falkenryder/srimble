class Order < ApplicationRecord
  belongs_to :supplier
  belongs_to :user

  validates :status, presence: true
  validates :status, inclusion: { in: %w[pending sent] }
end
