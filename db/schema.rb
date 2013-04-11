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

ActiveRecord::Schema.define(:version => 20130408190918) do

  create_table "api_keys", :force => true do |t|
    t.string   "access_token"
    t.integer  "exchanger_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "api_keys", ["access_token"], :name => "index_api_keys_on_access_token", :unique => true
  add_index "api_keys", ["exchanger_id"], :name => "index_api_keys_on_exchanger_id"

  create_table "exchanger_identities", :force => true do |t|
    t.integer  "exchanger_id"
    t.integer  "identity_id"
    t.boolean  "can_read"
    t.boolean  "can_write"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "exchanger_identities", ["exchanger_id"], :name => "index_exchanger_identities_on_exchanger_id"
  add_index "exchanger_identities", ["identity_id"], :name => "index_exchanger_identities_on_identity_id"

  create_table "exchangers", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "identities", :force => true do |t|
    t.string   "value"
    t.integer  "person_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "people", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
