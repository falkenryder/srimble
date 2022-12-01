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

  def sync
    client = Square::Client.new(
      access_token: ENV.fetch('SQUARE_ACCESS_TOKEN'),
      environment: 'production',
      timeout: 1
    )
    # to convert date to rfc3339 format
    require 'date'

    result = client.orders.search_orders(
      body: {
        location_ids: [
          "L96YBEE82HN3Z"
        ],
        query: {
          filter: {
            date_time_filter: {
              created_at: {
                # between now and a day before
                start_at: (Time.now - (60 * 60 * 24)).to_datetime.rfc3339,
                end_at: Time.now.to_datetime.rfc3339
              }
            }
          }
        }
      }
    )
    if result.success?
      results = result.data
      results.each do |result|
        # result refers to all orders created during specificed time
        result.map do |order|
          order[:line_items].each do |line_item|
            # for simplicity, we will update the first inventory found only
            product = Product.find_by(name: line_item[:name])
            # product = Product.where(name: line_item[:name]).first
            quantity = line_item[:quantity].to_i
            @inventory = Inventory.find_by(product: product)
            @inventory.quantity_bal -= quantity
            @inventory.user = current_user
            @inventory.save!
          end
        end
      end
      redirect_to inventories_path, notice: "Your inventory is now synced with your POS data"
    elsif result.error?
      warn result.errors
    end
  end

  def inventory_params
    params.require(:inventory).permit(
      :quantity_bal
    )
  end
end
