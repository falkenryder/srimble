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

private

def set_supplier
end
