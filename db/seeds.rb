# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'
require 'csv'
puts "Cleaning up database..."
Order.destroy_all
Template.destroy_all
DeliveryAddress.destroy_all
Inventory.destroy_all
User.destroy_all
Product.destroy_all
Supplier.destroy_all
puts "Database cleaned"

puts "Populating supplier seeds"
puts "Database cleaned"

# Add your own email address as a supplier to test action mailer :)
puts "Populating supplier seed for mailer test"
Supplier.create!(
  name:  "Eastern Brewdog Co",
    email: "easternbrewdog@gmail.com",
    address: "301 Jalan Klapa, Singapore 200321"
  )
  Supplier.create!(
    name:  "Viet'Spice",
    email: "helen@vietspice.com",
    address: "14 Circular Rd, Singapore 049370"
  )
  Supplier.create!(
    name:  "Resonant Coffee Co",
    email: "resonantcoffeeco@gmail.com",
    address: "239 Bukit Batok East Ave 5, Singapore 650239"
  )

  puts "Populating supplier seeds"
  7.times do
    Supplier.create!(
      name:  Faker::Company.name,
      # email:  "kenneth@gmail.com",
      # email: "test@mail.com",
      email: Faker::Internet.email,
      address: Faker::Address.full_address
    )
  end

puts "Populating user seeds"
User.create!(
  email: "christina@gmail.com",
  password: "password"
)
User.create!(
  email: "jega@gmail.com",
  password: "password"
)
User.create!(
  email: "kenneth@gmail.com",
  password: "password"
)
User.create!(
  email: "mike@gmail.com",
  password: "password"
)

puts "Creating product and inventory seeds"

csv_text = File.read(Rails.root.join('lib', 'seeds', 'product_seeds.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  p = Product.new
  p.name = row['name']
  p.price = row['price']
  p.supplier = Supplier.all.sample
  p.save!

  Inventory.create!(
    product: p,
    quantity_bal: rand(1..100),
    par_bal: rand(20..30),
    user: User.all.sample,
    reconciled_at: Faker::Date.between(from: 30.days.ago, to: Date.today)
  )
end

puts "[Temporary] Creating square order inventory seeds"

  # temporary until we finalize seed file
square_array = ["Sapporo", "Heineken"]
square_array.each do |item|
  product = Product.new
  product.name = item
  product.price = rand(1..10)
  product.supplier = Supplier.find(1)
  product.save!
    Inventory.create!(
      product: product,
      quantity_bal: rand(20..100),
      par_bal: rand(20..30),
      user: User.find(1),
      reconciled_at: Faker::Date.between(from: 30.days.ago, to: Date.today)
    )
end

puts "Populating address details"

User.all.each do |u|
  2.times do
    DeliveryAddress.create!(
      address: Faker::Address.full_address,
      contact_number: Faker::PhoneNumber.phone_number_with_country_code,
      user: u
    )
  end
end

puts "Populating order seeds"

50.times do
  rand_supplier = Supplier.all.sample
  rand_user = User.all.sample
  order_details_rows = []
  rand(1..5).times do
    order_details_rows << { product: rand_supplier.products.sample, quantity: rand(1..100) }
  end
  Order.create!(
    status: ["pending", "sent", "delivered"].sample,
    supplier: rand_supplier,
    user: rand_user,
    delivery_date: Faker::Date.between(from: '2022-12-01', to: '2022-12-31'),
    comments: "Please deliver before 2pm",
    delivery_address: rand_user.delivery_addresses.sample,
    order_details_attributes: order_details_rows
  )
end

User.all.each_with_index do |u, i|
  2.times do
    rand_supplier = Supplier.all.sample
    order_details_rows = []
    rand(1..5).times do
      order_details_rows << { product: rand_supplier.products.sample, quantity: rand(1..100) }
    end
    Template.create!(
      supplier: rand_supplier,
      user: u,
      name: "Template #{i}- #{rand_supplier.name}",
      order_details_attributes: order_details_rows
    )
  end
end
