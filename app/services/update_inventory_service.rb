class UpdateInventoryService
  def initialize(user)
    @user = user
  end

  def call
    search_orders
    sync_inventory
  end

  private

  attr_reader :user

  def search_orders
    client = Square::Client.new(
      access_token: ENV.fetch('SQUARE_ACCESS_TOKEN'),
      environment: 'production',
      timeout: 1
    )
    # to convert date to rfc3339 format
    require 'date'

    result = client.orders.search_orders(
      body: {
        location_ids: [
          "L96YBEE82HN3Z"
        ],
        query: {
          filter: {
            date_time_filter: {
              created_at: {
                # between now and a day before
                start_at: (Time.now - (60 * 60 * 24)).to_datetime.rfc3339,
                end_at: Time.now.to_datetime.rfc3339
              }
            }
          }
        }
      }
    )
    return result
  end

  def sync_inventory
    result = search_orders
    if result.success?
      results = result.data
      results.each do |result|
        # result refers to all orders created during specificed time
        result.map do |order|
          order[:line_items].each do |line_item|
            product = Product.find_by(name: line_item[:name])
            quantity = line_item[:quantity].to_i
            # for simplicity, we will update the first inventory found only
            @inventory = Inventory.find_by(product: product)
            @inventory.quantity_bal -= quantity
            @inventory.user = user
            @inventory.save!
          end
        end
      end
    elsif result.error?
      warn result.errors
    end
  end

end
