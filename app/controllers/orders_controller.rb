class OrdersController < ApplicationController

  # http://localhost:3000/orders?status=template
  def index
    if params[:supplier_id].present?
      @orders = Order.where(supplier_id: params[:user_id])
    elsif params[:status] == "template"
      @orders = Order.where(status: "template")

    else
      @orders = Order.all
    end
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
