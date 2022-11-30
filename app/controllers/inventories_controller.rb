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

  def update
    # raise
    @inventory = Inventory.find(params[:id])
    # @inventory.user_id = curent_user.email
    # @inventory.user_id = [params[current_user]]
    @inventory.update(inventory_params)
    @inventory.user = current_user
    @inventory.save!
    redirect_to inventories_path
  end
  private

  def inventory_params
    params.require(:inventory).permit(
      :quantity_bal,
      # :user_id == @inventory.curent_user
    )
  end

end
