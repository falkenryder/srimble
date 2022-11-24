class OrdersController < ApplicationController
  before_action :set_supplier, only: %i[new create]
  before_action :set_user, only: %i[new create]

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
  end

  private

  def set_user
    @user = current_user
  end

  def set_supplier
    @supplier = Supplier.find(params[:supplier_id])
  end


end
