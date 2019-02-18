# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20190218215759) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "items", force: :cascade do |t|
    t.float "price"
    t.string "name"
    t.integer "stock"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: false
    t.bigint "user_id"
    t.string "image", default: "https://secure.img1-fg.wfcdn.com/im/43152120/resize-h600-w600%5Ecompr-r85/4486/44869893/12+Jar+Spice+Jars+%26+Rack+Set.jpg"
    t.index ["user_id"], name: "index_items_on_user_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.float "order_price"
    t.integer "order_quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "fulfilled", default: false
    t.bigint "item_id"
    t.bigint "order_id"
    t.index ["item_id"], name: "index_order_items_on_item_id"
    t.index ["order_id"], name: "index_order_items_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.integer "status", default: 0
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.string "email"
    t.string "address"
    t.string "city"
    t.string "state"
    t.integer "zip_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 0
    t.boolean "active", default: true
  end

  add_foreign_key "items", "users"
  add_foreign_key "orders", "users"
end
