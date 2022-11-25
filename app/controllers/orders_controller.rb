class OrdersController < ApplicationController
  before_action :set_supplier, only: %i[new create]
  before_action :set_user, only: %i[new create]

  def index
    @orders = Order.all

  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new
    @addresses = @user.delivery_addresses
  end

  def create
    @order = Order.new(order_params)
    @order.user = @user
    @order.status = "pending" #TODO: enum this!
    if @order.save!
      redirect_to @order
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = current_user
  end

  def set_supplier
    @supplier = Supplier.find(params[:supplier_id])
  end

  def order_params
    params.require(:order).permit(
      :supplier_id,
      :delivery_date,
      :delivery_address_id,
      :comments,
      order_details_attributes: [:id, :_destroy, :product_id, :quantity]
    )
  end
end
# {"authenticity_token"=>"[FILTERED]",
#   "order"=>
#    {"supplier_id"=>"1",
#     "delivery_date(1i)"=>"2022",
#     "delivery_date(2i)"=>"11",
#     "delivery_date(3i)"=>"25",
#     "delivery_address"=>"1",
#     "order_details_attributes"=>{"TEMPLATE_RECORD"=>{"_destroy"=>"0", "product"=>"34", "quantity"=>"1"}},
#     "comments"=>"fuckkkk"},
#   "commit"=>"Create Order",
#   "supplier_id"=>"1"}
