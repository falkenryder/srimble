class OrdersController < ApplicationController
  before_action :set_supplier, only: %i[create]
  before_action :set_user, only: %i[new create]
  before_action :set_order, only: %i[show update]

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
    if params[:type] == "order"
      set_order
    end
  end

  def new
    if params[:template].present?
      @template = Template.find(params[:template])
      @order = Order.new
      @supplier = @template.supplier
      @order.supplier = @supplier
      @order.order_details = @template.order_details
    else
      set_supplier
      @order = Order.new
      @addresses = @user.delivery_addresses
    end
  end

  def create
    if params[:order][:name] == ""
      @order = Order.new(order_params)
      @order.user = @user
      @order.status = "pending" #TODO: enum this!
      if @order.save!
        SupplierMailer.with(supplier: @supplier, order: @order, user: @user).order_email.deliver_now
        redirect_to @order
      else
        render :new, status: :unprocessable_entity
      end
    else
      @template = Template.new(template_params)
      @template.user = @user
      if @template.save!
        redirect_to supplier_templates_path
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  def edit
    if params[:type] == "template"
      set_template
      @order = Order.new
      @supplier = @template.supplier
      @order.supplier = @supplier
      @order.order_details = @template.order_details
    end
  end

  # Order update is tailered for mark as delievered to adjust inventory
  def update

    if params[:type] == "order"
      set_order
      @order.photo.attach(update_order_params[:photo])
      @order.status = params[:order][:status]
      @order.save!
      @order.order_details.each do |order_detail|
        @inventory = Inventory.find(order_detail.product_id)
        @inventory.quantity_bal += order_detail.quantity
        @inventory.save!
      end
      # redirect_to order_path(@order), notice: "Your order has been marked as #{@order.status}"
      redirect_to inventories_path, notice: "Your order has been marked as #{@order.status} and items have been added to
      inventory"
    elsif params[:type] == "template"
      set_template
      if @template.update(update_template_params)
        redirect_to templates_path
      else
        render :edit, status: :unprocessable_entity
      end
    end

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
      order_details_attributes: [:_destroy, :product_id, :quantity]
    )
  end

  def template_params
    params.require(:order).permit(
      :name,
      :supplier_id,
      order_details_attributes: [:_destroy, :product_id, :quantity]
    )
  end
  def update_template_params
    params.require(:template).permit(
      :name,
      :supplier_id,
      order_details_attributes: [:id, :_destroy, :product_id, :quantity]
    )
  end

  def update_order_params
    params.require(:order).permit(
      # :name,
      # :supplier_id,
      :status,
      :photo
    )
  end
end
