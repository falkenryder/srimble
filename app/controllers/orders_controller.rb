class OrdersController < ApplicationController
  before_action :set_supplier, only: %i[new create]
  before_action :set_user, only: %i[new create]
  before_action :set_order, only: %i[show update]

  def index
    if params[:type] == "order"
      if params[:supplier_id].present?
        set_supplier
        @orders = params[:status].present? ? @supplier.orders.where(status: params[:status]).order(created_at: :desc) : @supplier.orders.order(created_at: :desc)
      else
        @orders = params[:status].present? ? Order.where(status: params[:status]).order(created_at: :desc) : Order.all.order(created_at: :desc)
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
    if params[:type] == "order"
      set_order
    end
  end

  def new
    @order = Order.new
    @addresses = @user.delivery_addresses
  end

  def create
    if params[:order][:name]
      @template = Template.new(template_params)
      @template.user = @user
      if @template.save!
        redirect_to templates_path
      else
        render :new, status: :unprocessable_entity
      end
    else
      @order = Order.new(order_params)
      @order.user = @user
      @order.status = "pending" #TODO: enum this!
      if @order.save!
        redirect_to @order
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  def edit
    if params[:type] == "template"
      set_template
      @order = Order.new
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

  def set_template
    @template = Template.find(params[:id])
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

  def template_params
    params.require(:order).permit(
      :name,
      :supplier_id,
      order_details_attributes: [:id, :_destroy, :product_id, :quantity]
    )
  end
end
