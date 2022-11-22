# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


supplier = Supplier.create!(
  name: "Cornerstone",
  email: "cornerstone@cornerstone.com",
  address: "123 Sunset Boulevard"
)

Product.create!(
  name: "Gordon's Dry Gin",
  price: 34,
  supplier: supplier
)
