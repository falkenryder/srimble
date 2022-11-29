# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_11_29_042041) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "delivery_addresses", force: :cascade do |t|
    t.string "address", null: false
    t.string "contact_number", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_delivery_addresses_on_user_id"
  end

  create_table "inventories", force: :cascade do |t|
    t.integer "quantity_bal", null: false
    t.integer "par_bal", null: false
    t.bigint "user_id"
    t.datetime "reconciled_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "product_id"
    t.index ["product_id"], name: "index_inventories_on_product_id"
    t.index ["user_id"], name: "index_inventories_on_user_id"
  end

  create_table "order_details", force: :cascade do |t|
    t.integer "quantity", null: false
    t.bigint "product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "order_type"
    t.bigint "order_id"
    t.index ["order_type", "order_id"], name: "index_order_details_on_order"
    t.index ["product_id"], name: "index_order_details_on_product_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "status", null: false
    t.bigint "supplier_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "delivery_date"
    t.text "comments"
    t.bigint "delivery_address_id", null: false
    t.index ["delivery_address_id"], name: "index_orders_on_delivery_address_id"
    t.index ["supplier_id"], name: "index_orders_on_supplier_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name", null: false
    t.integer "price", null: false
    t.bigint "supplier_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["supplier_id"], name: "index_products_on_supplier_id"
  end

  create_table "suppliers", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.text "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "templates", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id", null: false
    t.bigint "supplier_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["supplier_id"], name: "index_templates_on_supplier_id"
    t.index ["user_id"], name: "index_templates_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "delivery_addresses", "users"
  add_foreign_key "inventories", "products"
  add_foreign_key "inventories", "users", name: "reconciled_id"
  add_foreign_key "order_details", "products"
  add_foreign_key "orders", "delivery_addresses"
  add_foreign_key "orders", "suppliers"
  add_foreign_key "orders", "users"
  add_foreign_key "products", "suppliers"
  add_foreign_key "templates", "suppliers"
  add_foreign_key "templates", "users"
end
