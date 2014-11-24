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

ActiveRecord::Schema.define(version: 20141121213604) do

  create_table "computers", force: true do |t|
    t.integer  "customer_id"
    t.string   "model"
    t.string   "serial"
    t.string   "type"
    t.string   "warranty"
    t.datetime "purchased_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customers", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
  end

  create_table "employees", force: true do |t|
    t.string   "name"
    t.decimal  "rating",          precision: 10, scale: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "email"
  end

  create_table "parts", force: true do |t|
    t.integer  "repair_id"
    t.string   "model"
    t.string   "serial"
    t.decimal  "cost",       precision: 8, scale: 2, default: 0.0
    t.integer  "quantity",                           default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "repairs", force: true do |t|
    t.integer  "customer_id"
    t.integer  "employee_id"
    t.integer  "computer_id"
    t.text     "description"
    t.decimal  "labor_cost",    precision: 8, scale: 2
    t.decimal  "total_cost",    precision: 8, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "requested_for"
    t.datetime "completed_at"
  end

end
