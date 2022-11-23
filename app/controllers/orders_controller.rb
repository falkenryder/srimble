class OrdersController < ApplicationController
  before_action :set_supplier, only: %i[new create]
  before_action :set_user, only: %i[new create]

  def index
  end

  def show
  end

  def new
    @order = Order.new
    2.times { @order.order_details.build }
  end

  def create
    @order = Order.new(order_params)

  end

  private

  def set_user
    @user = current_user
  end

  def set_supplier
    @supplier = Supplier.find(params[:supplier_id])
  end

  def order_params
    params.require(:order).permit()
  end
end
