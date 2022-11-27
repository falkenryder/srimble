class OrdersController < ApplicationController
  before_action :set_supplier, only: %i[new create]
  before_action :set_user, only: %i[new create]
  before_action :set_order, only: %i[show update single_template]
  attr_reader :id

  def index
    if params[:type] == "order"
      if params[:supplier_id].present?
        set_supplier
        @orders = params[:status].present? ? @supplier.orders.where(status: params[:status]) : @supplier.orders
      else
        @orders = params[:status].present? ? Order.where(status: params[:status]) : Order.all
      end
    elsif params[:type] == "template"
      if params[:supplier_id].present?
        set_supplier
        @templates = @supplier.templates
      else
        @templates = Template.all
      end
    end
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

  def update
    @order.status = params[:order][:status]
    @order.save!
    redirect_to order_path(@order), notice: "Your order has been marked as #{@order.status}"
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
    params.require(:order).permit(
      :supplier_id,
      :delivery_date,
      :delivery_address_id,
      :comments,
      order_details_attributes: [:id, :_destroy, :product_id, :quantity]
    )
  end
end
