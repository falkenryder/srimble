class OrdersController < ApplicationController
  def index
    @orders = Order.all

  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
  end

  private

  def order_params
    params.require(:order).permit()
  end
end

private

def set_supplier
end
