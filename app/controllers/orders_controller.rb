class OrdersController < ApplicationController
  def index
  end

  def show
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
