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

ActiveRecord::Schema.define(:version => 20140618230955) do

  create_table "administrators", :force => true do |t|
    t.integer  "account_id",  :null => false
    t.datetime "disabled_at"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "administrators", ["account_id"], :name => "index_administrators_on_account_id", :unique => true
  add_index "administrators", ["disabled_at"], :name => "index_administrators_on_disabled_at"

  create_table "agents", :force => true do |t|
    t.integer  "account_id",                        :null => false
    t.datetime "disabled_at"
    t.integer  "application_id",                    :null => false
    t.boolean  "is_manager",     :default => false, :null => false
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  add_index "agents", ["account_id"], :name => "index_agents_on_account_id", :unique => true
  add_index "agents", ["application_id", "is_manager"], :name => "index_agents_on_application_id_and_is_manager"
  add_index "agents", ["disabled_at"], :name => "index_agents_on_disabled_at"

  create_table "fine_print_contracts", :force => true do |t|
    t.string   "name",       :null => false
    t.integer  "version"
    t.string   "title",      :null => false
    t.text     "content",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "fine_print_contracts", ["name", "version"], :name => "index_fine_print_contracts_on_name_and_version", :unique => true

  create_table "fine_print_signatures", :force => true do |t|
    t.integer  "contract_id", :null => false
    t.integer  "user_id",     :null => false
    t.string   "user_type",   :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "fine_print_signatures", ["contract_id"], :name => "index_fine_print_signatures_on_contract_id"
  add_index "fine_print_signatures", ["user_id", "user_type", "contract_id"], :name => "index_fine_print_s_on_u_id_and_u_type_and_c_id", :unique => true

  create_table "identifiers", :force => true do |t|
    t.integer  "person_id",   :null => false
    t.integer  "platform_id", :null => false
    t.string   "value",       :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "identifiers", ["person_id"], :name => "index_identifiers_on_person_id"
  add_index "identifiers", ["platform_id"], :name => "index_identifiers_on_platform_id"
  add_index "identifiers", ["value"], :name => "index_identifiers_on_value", :unique => true

  create_table "oauth_access_grants", :force => true do |t|
    t.integer  "resource_owner_id", :null => false
    t.integer  "application_id",    :null => false
    t.string   "token",             :null => false
    t.integer  "expires_in",        :null => false
    t.text     "redirect_uri",      :null => false
    t.datetime "created_at",        :null => false
    t.datetime "revoked_at"
    t.string   "scopes"
  end

  add_index "oauth_access_grants", ["token"], :name => "index_oauth_access_grants_on_token", :unique => true

  create_table "oauth_access_tokens", :force => true do |t|
    t.integer  "resource_owner_id"
    t.integer  "application_id"
    t.string   "token",             :null => false
    t.string   "refresh_token"
    t.integer  "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at",        :null => false
    t.string   "scopes"
  end

  add_index "oauth_access_tokens", ["refresh_token"], :name => "index_oauth_access_tokens_on_refresh_token", :unique => true
  add_index "oauth_access_tokens", ["resource_owner_id"], :name => "index_oauth_access_tokens_on_resource_owner_id"
  add_index "oauth_access_tokens", ["token"], :name => "index_oauth_access_tokens_on_token", :unique => true

  create_table "oauth_applications", :force => true do |t|
    t.string   "name",         :null => false
    t.string   "uid",          :null => false
    t.string   "secret",       :null => false
    t.text     "redirect_uri", :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "oauth_applications", ["uid"], :name => "index_oauth_applications_on_uid", :unique => true

  create_table "openstax_accounts_accounts", :force => true do |t|
    t.integer  "openstax_uid", :null => false
    t.string   "username",     :null => false
    t.string   "access_token"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "full_name"
    t.string   "title"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "openstax_accounts_accounts", ["access_token"], :name => "index_openstax_accounts_accounts_on_access_token", :unique => true
  add_index "openstax_accounts_accounts", ["first_name"], :name => "index_openstax_accounts_accounts_on_first_name"
  add_index "openstax_accounts_accounts", ["full_name"], :name => "index_openstax_accounts_accounts_on_full_name"
  add_index "openstax_accounts_accounts", ["last_name"], :name => "index_openstax_accounts_accounts_on_last_name"
  add_index "openstax_accounts_accounts", ["openstax_uid"], :name => "index_openstax_accounts_accounts_on_openstax_uid", :unique => true
  add_index "openstax_accounts_accounts", ["username"], :name => "index_openstax_accounts_accounts_on_username", :unique => true

  create_table "people", :force => true do |t|
    t.string   "label",                             :null => false
    t.text     "superseded_labels", :default => "", :null => false
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  add_index "people", ["label"], :name => "index_people_on_label", :unique => true

  create_table "platforms", :force => true do |t|
    t.integer  "application_id", :null => false
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "platforms", ["application_id"], :name => "index_platforms_on_application_id", :unique => true

  create_table "researchers", :force => true do |t|
    t.integer  "account_id",  :null => false
    t.datetime "disabled_at"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "researchers", ["account_id"], :name => "index_researchers_on_account_id", :unique => true
  add_index "researchers", ["disabled_at"], :name => "index_researchers_on_disabled_at"

  create_table "resources", :force => true do |t|
    t.integer  "platform_id"
    t.string   "reference"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "resources", ["platform_id"], :name => "index_resources_on_platform_id"
  add_index "resources", ["reference", "platform_id"], :name => "index_resources_on_reference_and_platform_id", :unique => true

  create_table "subscriber_events", :force => true do |t|
    t.integer  "subscriber_id"
    t.integer  "event_id"
    t.boolean  "read"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "subscriber_events", ["event_id", "subscriber_id"], :name => "index_subscriber_events_on_event_id_and_subscriber_id", :unique => true
  add_index "subscriber_events", ["subscriber_id", "read"], :name => "index_subscriber_events_on_subscriber_id_and_read"

  create_table "subscribers", :force => true do |t|
    t.integer  "application_id", :null => false
    t.text     "base_api_uri",   :null => false
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "subscribers", ["application_id"], :name => "index_subscribers_on_application_id", :unique => true

end
