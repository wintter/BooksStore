# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150630121632) do

  create_table "addresses", force: :cascade do |t|
    t.text     "billing_address"
    t.string   "shipping_address"
    t.string   "city"
    t.string   "phone"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "user_id"
  end

  add_index "addresses", ["user_id"], name: "index_addresses_on_user_id"

  create_table "authors", force: :cascade do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "biography"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "books", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.decimal  "price",            precision: 5, scale: 2
    t.integer  "in_stock"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.integer  "author_id"
    t.integer  "category_id"
    t.string   "image"
    t.integer  "count_pages"
    t.datetime "publication_date"
  end

  add_index "books", ["author_id"], name: "index_books_on_author_id"
  add_index "books", ["category_id"], name: "index_books_on_category_id"

  create_table "books_users", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "book_id"
  end

  add_index "books_users", ["book_id"], name: "index_books_users_on_book_id"
  add_index "books_users", ["user_id", "book_id"], name: "index_books_users_on_user_id_and_book_id", unique: true
  add_index "books_users", ["user_id"], name: "index_books_users_on_user_id"

  create_table "cart_items", force: :cascade do |t|
    t.integer  "cart_id"
    t.integer  "book_id"
    t.integer  "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "cart_items", ["book_id"], name: "index_cart_items_on_book_id"
  add_index "cart_items", ["cart_id"], name: "index_cart_items_on_cart_id"

  create_table "carts", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "carts", ["user_id"], name: "index_carts_on_user_id"

  create_table "categories", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "categories", ["title"], name: "index_categories_on_title", unique: true

  create_table "credit_cards", force: :cascade do |t|
    t.string   "number"
    t.string   "CVV"
    t.integer  "expiration_month"
    t.integer  "expiration_year"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "user_id"
  end

  add_index "credit_cards", ["user_id"], name: "index_credit_cards_on_user_id"

  create_table "order_items", force: :cascade do |t|
    t.integer  "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "book_id"
    t.integer  "order_id"
  end

  add_index "order_items", ["book_id"], name: "index_order_items_on_book_id"
  add_index "order_items", ["order_id"], name: "index_order_items_on_order_id"

  create_table "orders", force: :cascade do |t|
    t.decimal  "total_price",      precision: 5, scale: 2
    t.datetime "completed_date"
    t.string   "state"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.integer  "user_id"
    t.integer  "credit_card_id"
    t.string   "billing_address"
    t.string   "shipping_address"
  end

  add_index "orders", ["billing_address"], name: "index_orders_on_billing_address"
  add_index "orders", ["credit_card_id"], name: "index_orders_on_credit_card_id"
  add_index "orders", ["shipping_address"], name: "index_orders_on_shipping_address"
  add_index "orders", ["user_id"], name: "index_orders_on_user_id"

  create_table "ratings", force: :cascade do |t|
    t.text     "review"
    t.integer  "rating_number"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "user_id"
    t.integer  "book_id"
    t.boolean  "approve",       default: false
  end

  add_index "ratings", ["book_id"], name: "index_ratings_on_book_id"
  add_index "ratings", ["user_id"], name: "index_ratings_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
