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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130217000856) do

  create_table "ages", :force => true do |t|
    t.string  "name"
    t.integer "min_age"
    t.integer "max_age"
  end

  create_table "clinics", :force => true do |t|
    t.string   "name"
    t.string   "address_1"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "clinics_services", :id => false, :force => true do |t|
    t.integer "clinic_id"
    t.integer "service_id"
  end

  create_table "services", :force => true do |t|
    t.string "name"
  end

  create_table "stats", :force => true do |t|
    t.integer  "clinic_id"
    t.integer  "age_id"
    t.integer  "egg_type_id"
    t.string   "value"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

end
