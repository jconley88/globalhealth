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

ActiveRecord::Schema.define(:version => 20130217001637) do

  create_table "ages", :force => true do |t|
    t.string   "code"
    t.string   "name"
    t.integer  "min_age"
    t.integer  "max_age"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "clinics", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "practice_director"
    t.string   "medical_director"
    t.string   "lab_director"
    t.string   "phone"
    t.string   "fax"
    t.string   "email"
    t.string   "link"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "clinics_services", :id => false, :force => true do |t|
    t.integer "clinic_id",  :null => false
    t.integer "service_id", :null => false
  end

  create_table "complications", :force => true do |t|
    t.string   "code"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "complications_services", :id => false, :force => true do |t|
    t.integer "complication_id", :null => false
    t.integer "service_id",      :null => false
  end

  create_table "egg_types", :force => true do |t|
    t.string   "code"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "services", :force => true do |t|
    t.string   "code"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
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
