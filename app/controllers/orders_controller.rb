class OrdersController < ApplicationController
  before_action :set_supplier, only: %i[new create]
  before_action :set_user, only: %i[new create]
  attr_reader :id

  # http://localhost:3000/orders?status=template
  def index

    if params[:supplier_id].present?

      # suppliers/:id/orders?status=template
      if params[:status] == "template"
      @orders = Order.where(supplier_id: params[:supplier_id]).where(status: "template")

      # suppliers/:id/orders?status=pending
      elsif params[:status] == "pending"
        @orders = Order.where(supplier_id: params[:supplier_id]).where(status: "pending")

        # suppliers/:id/orders?status=sent
      elsif params[:status] == "sent"
        @orders = Order.where(supplier_id: params[:supplier_id]).where(status: "sent")

        # suppliers/:id/orders?status=delivered
      elsif params[:status] == "delivered"
        @orders = Order.where(supplier_id: params[:supplier_id]).where(status: "delivered")

        # suppliers/:id/orders
      else
        @orders = Order.where(supplier_id: params[:supplier_id])
      # raise
      # if Order.where(supplier_id: params[:user_id]).where(status: "template")
    end

    elsif params[:status] == "template"
      @orders = Order.where(status: "template")

      # /orders?status=pending
    elsif params[:status] == "pending"
      @orders = Order.where(status: "pending")

      # /orders?status=sent
    elsif params[:status] == "sent"
      @orders = Order.where(status: "sent")

      # /orders?status=delivered
    elsif params[:status] == "delivered"
      @orders = Order.where(status: "delivered")

     # /orders
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
  end

  def update
    @order = Order.find(params[:id])
    @order.status = params[:order][:status]
    @order.save!
    redirect_to order_path(@order), notice: "Your order has been marked as delivered"
  end

  private

  def set_user
    @user = current_user
  end

  def set_supplier
    @supplier = Supplier.find(params[:supplier_id])
  end

  def order_params
    params.require(:order).permit(:status)
  end

end
