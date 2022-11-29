puts "Creating inventories"
product_all = Product.all
product_all.each do | product |
  Inventory.create!(
    quantity_bal: rand(10..100),
    par_bal: rand(10..20),
    user_id: rand(1..4),
    product_id: product_id
  )
end
