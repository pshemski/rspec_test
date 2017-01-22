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

ActiveRecord::Schema.define(version: 20161230100623) do

  create_table "brands", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "confirmations", force: :cascade do |t|
    t.boolean  "confirmed"
    t.string   "otp"
    t.string   "phone_number"
    t.integer  "customer_id"
    t.integer  "order_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "customers", force: :cascade do |t|
    t.text     "delivery_address"
    t.string   "email"
    t.string   "name"
    t.string   "postcode"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "deliveries", force: :cascade do |t|
    t.string   "name"
    t.string   "phone_number"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "orders", force: :cascade do |t|
    t.text     "notes"
    t.integer  "payment_amount_in_cents"
    t.datetime "preffered_time"
    t.integer  "quantity"
    t.integer  "weight_in_kg"
    t.integer  "brand_id"
    t.integer  "delivery_id"
    t.integer  "state_id"
    t.integer  "customer_id"
    t.integer  "confirmation_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "states", force: :cascade do |t|
    t.string   "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
