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

ActiveRecord::Schema.define(version: 20150812070850) do

  create_table "addresses", force: :cascade do |t|
    t.string   "city"
    t.string   "phone"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "zip"
    t.string   "street_address"
  end

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
    t.string   "cover"
    t.integer  "count_pages"
    t.datetime "publication_date"
    t.integer  "author_id"
    t.integer  "category_id"
  end

  add_index "books", ["author_id"], name: "index_books_on_author_id"
  add_index "books", ["category_id"], name: "index_books_on_category_id"

  create_table "categories", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "categories", ["title"], name: "index_categories_on_title", unique: true

  create_table "coupons", force: :cascade do |t|
    t.string   "number"
    t.string   "discount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "credit_cards", force: :cascade do |t|
    t.string   "number"
    t.string   "CVV"
    t.integer  "expiration_month"
    t.integer  "expiration_year"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "deliveries", force: :cascade do |t|
    t.string   "title"
    t.decimal  "price",      precision: 5, scale: 2
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

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
    t.decimal  "total_price",         precision: 5, scale: 2
    t.datetime "completed_date"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.integer  "user_id"
    t.integer  "credit_card_id"
    t.integer  "delivery_id"
    t.integer  "coupon_id"
    t.string   "state"
    t.integer  "billing_address_id"
    t.integer  "shipping_address_id"
  end

  add_index "orders", ["coupon_id"], name: "index_orders_on_coupon_id"

  create_table "ratings", force: :cascade do |t|
    t.text     "review"
    t.integer  "rating_number"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.boolean  "approve",       default: false
    t.integer  "user_id"
    t.integer  "book_id"
  end

  add_index "ratings", ["book_id"], name: "index_ratings_on_book_id"
  add_index "ratings", ["user_id"], name: "index_ratings_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.boolean  "admin"
    t.string   "uid"
    t.string   "provider"
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "billing_address_id"
    t.integer  "shipping_address_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "wish_lists", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "book_id"
    t.integer  "user_id"
  end

  add_index "wish_lists", ["book_id"], name: "index_wish_lists_on_book_id"
  add_index "wish_lists", ["user_id", "book_id"], name: "index_wish_lists_on_user_id_and_book_id", unique: true
  add_index "wish_lists", ["user_id"], name: "index_wish_lists_on_user_id"

end
