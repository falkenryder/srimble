class Order < ApplicationRecord
  belongs_to :supplier
  belongs_to :user
#this is a test comment
  validates :status, presence: true
  validates :status, inclusion: { in: %w[pending sent] }
end
