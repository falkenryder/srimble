class DeliveryAddress < ApplicationRecord
  validates :address, :contact_number, presence: true

  belongs_to :user
end
