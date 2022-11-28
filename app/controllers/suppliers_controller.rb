class SuppliersController < ApplicationController
  def index
    @suppliers = Supplier.all
  end

  def show
    @supplier = Supplier.find(params[:id])
    @orders_of_supplier = (Order.where(supplier_id: (params[:id]))).count
  end

  def new
    @supplier = Supplier.new
  end

  def create
    @supplier = Supplier.new(supplier_params)
    if @supplier.save
      redirect_to suppliers_path
    else
      render :new
    end
  end

  private

  def supplier_params
    params.require(:supplier).permit(:name, :address, :email)
  end
end
