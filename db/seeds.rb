# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'
puts "Cleaning up database..."
OrderDetail.destroy_all
Order.destroy_all
User.destroy_all
Product.destroy_all
Supplier.destroy_all
puts "Database cleaned"

puts "Populating supplier seeds"
puts "Database cleaned"


puts "Populating supplier seeds"
10.times do
  Supplier.create!(
    name:  Faker::Company.name,
    # email:  "kenneth@gmail.com",
    # email: "test@mail.com",
    email: Faker::Internet.email,
    address: Faker::Address.full_address
  )
end

puts "Populating product seeds"
supplier_id_range = Supplier.last.id - Supplier.first.id
60.times do
  Product.create!(
    name:  ["Wine", "Coffee", "Iced tea", "Hot chocolate", "Juice", "Water", "Tea", "Milk", "Beer", "Soda", "Coffee", "Baked goods", "Breads", "Cereals", "Dairy products", "Edible plants", "Edible fungi", "nuts and seeds", "Legumes", "Meat", "Eggs", "Rice"].sample,
    price: rand(1..10),
    supplier_id: Supplier.first.id + rand(0..supplier_id_range)
  )
end

supplier_id_range = Supplier.last.id - Supplier.first.id

puts "Populating user seeds"
User.create!(
  email: "jega@gmail.com",
  password: "password"
)
User.create!(
  email: "kenneth@gmail.com",
  password: "password"
)
User.create!(
  email: "christina@gmail.com",
  password: "password"
)
User.create!(
  email: "mike@gmail.com",
  password: "password"
)

user_id_range = User.last.id - User.first.id

puts "Populating order seeds"
10.times do
  Order.create!(
    status: ["pending", "sent", "template"].sample,
    supplier_id: Supplier.first.id + rand(0..supplier_id_range),
    user_id:   User.first.id + rand(0..user_id_range),
    delivery_date: Faker::Date.between(from: '2022-12-01', to: '2022-12-31'),
    comments: "Please deliver to the front desk"
    )
end

puts "Populating order details seeds"
count = 0
  (Order.count).times do |order|
    OrderDetail.create!(
      quantity: rand(1..100),
      order_id: Order.first.id + count,
      product_id: Product.first.id
    )
    count += 1
  end

puts "Seeding completed!"
