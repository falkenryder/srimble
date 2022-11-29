class SupplierMailer < ApplicationMailer
  default from: "srimble.mailer@gmail.com"

  def order_email
    @supplier = params[:supplier]
    @order = params[:order]
    @user = params[:user]
    mail(to: @supplier.email, subject: "Order for #{@user.email}")
  end
end
