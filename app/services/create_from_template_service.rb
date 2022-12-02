class CreateFromTemplateService
  attr_reader :template_id

  def initialize(template_id)
    @template = Template.find(template_id)
  end

  def call
    Order.new
    @order = Order.new
    @supplier = @template.supplier
    @order.supplier = @supplier
    @order.order_details = @template.order_details
    return @order
  end
end
