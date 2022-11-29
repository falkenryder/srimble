class InventoriesController < ApplicationController
  def index
    @inventories =
      if params[:user_id].present?
        Inventory.where(user_id: params[:user_id])
      else
        Inventory.all
      end
  end
end
