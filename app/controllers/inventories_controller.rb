class InventoriesController < ApplicationController
  # before_action :set_inventory, only: %i[show update]

  def index
    @inventories =
      if params[:user_id].present?
        Inventory.where(user_id: params[:user_id]).order(updated_at: :desc)

      else
        Inventory.all.order(updated_at: :desc)

      end
  end

  def show
    @inventory = Inventory.find(params[:id])
  end
end
