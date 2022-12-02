class UpdateInventoryService
  def initialize(user)
    @user = user
  end

  def call
    raise ActiveRecord::RecordInvalid if search_order_response.errors

    sync_inventory
  end

  private

  attr_reader :user

  def sync_inventory
    search_order_response.data.each do |result|
      result.map do |order|
        order[:line_items].each do |line_item|
          process_line_item(line_item)
        end
      end
    end
  end

  def process_line_item(line_item)
    product = Product.find_by(name: line_item[:name])
    quantity = line_item[:quantity].to_i

    # for simplicity, we will update the first inventory found only
    inventory = Inventory.find_by(product: product)
    inventory.quantity_bal -= quantity
    inventory.user = user
    inventory.save!
  end

  def search_order_response
    @search_order_response ||=
      client.orders.search_orders(
        body: {
          location_ids: ["L96YBEE82HN3Z"],
          query: query_body
        }
      )
  end

  def query_body
    {
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
  end

  def client
    @client ||= Square::Client.new(
      access_token: ENV.fetch('SQUARE_ACCESS_TOKEN'),
      environment: 'production',
      timeout: 1
    )
  end
end
