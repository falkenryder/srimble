class Inventory < ApplicationRecord
  belongs_to :product
  belongs_to :user

  scope :running_low, -> { where("(quantity_bal - par_bal) < 0") }
end
