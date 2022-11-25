class OrdersController < ApplicationController
  before_action :set_supplier, only: %i[new create]
  before_action :set_user, only: %i[new create]
  before_action :set_order, only: %i[show update single_template]
  attr_reader :id

  # http://localhost:3000/orders?status=template
  def index

    if params[:supplier_id].present?

      # suppliers/:id/orders?status=pending
      if params[:status] == "pending"
        @orders = Order.where(supplier_id: params[:supplier_id]).where(status: "pending")

        # suppliers/:id/orders?status=sent
      elsif params[:status] == "sent"
        @orders = Order.where(supplier_id: params[:supplier_id]).where(status: "sent")

        # suppliers/:id/orders?status=delivered
      elsif params[:status] == "delivered"
        @orders = Order.where(supplier_id: params[:supplier_id]).where(status: "delivered")

        # suppliers/:id/orders
      else
        @orders = Order.where(supplier_id: params[:supplier_id]).where.not(status: "template")
      # raise
      # if Order.where(supplier_id: params[:user_id]).where(status: "template")
    end

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
      @orders = Order.where.not(status: "template")
    end
  end

  def show
  end

  def new
    @order = Order.new
  end

  def create
  end

  def update
    @order.status = params[:order][:status]
    @order.save!
    redirect_to order_path(@order)
  end

  # /templates
  def all_templates
    @templates = Order.where(status: 'template')
  end

  # /suppliers/:id/templates
  def supplier_templates
    @templates = Order.where(supplier_id: params[:supplier_id]).where(status: 'template')
  end

  # /templates/:id
  def single_template
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

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
