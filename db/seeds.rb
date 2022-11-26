# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'
puts "Cleaning up database..."
Order.destroy_all
Template.destroy_all
DeliveryAddress.destroy_all
User.destroy_all
Product.destroy_all
Supplier.destroy_all
puts "Database cleaned"

puts "Populating supplier seeds"
puts "Database cleaned"

no_of_orders = 50

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

60.times do
  products_array = []
  products_array << Faker::Food.vegetables
  products_array << Faker::Food.spice
  products_array << Faker::Food.fruits
  products_array << Faker::Food.ingredient
  Product.create!(
    name: products_array.sample,
    price: rand(1..10),
    supplier: Supplier.all.sample
  )
end


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

puts "Populating address details"
no_of_orders.times do
  DeliveryAddress.create!(
    address: Faker::Address.full_address,
    contact_number: Faker::PhoneNumber.phone_number_with_country_code,
    user: User.all.sample
  )
end

puts "Populating order seeds"

no_of_orders.times do
  rand_supplier = Supplier.all.sample
  rand_user = User.all.sample
  order_details_rows = []
  rand(1..5) do
    order_details_rows << { product: rand_supplier.products.sample, quantity: rand(1..100) }
  end
  Order.create!(
    status: ["pending", "sent", "delivered"].sample,
    supplier: rand_supplier,
    user: rand_user,
    delivery_date: Faker::Date.between(from: '2022-12-01', to: '2022-12-31'),
    comments: "Please deliver to the front desk",
    delivery_address: rand_user.delivery_addresses.sample,
    order_details_attributes: order_details_rows
  )
end

User.all.each_with_index do |user|
  no_of_orders.times do
    rand_supplier = Supplier.all.sample
    order_details_rows = []
    rand(1..5) do
      order_details_rows << { product: rand_supplier.products.sample, quantity: rand(1..100) }
    end
    Template.create!(
      supplier: rand_supplier,
      user: user,
      name: "Template",
      order_details_attributes: order_details_rows
    )
  end
end
