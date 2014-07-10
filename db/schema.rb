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

ActiveRecord::Schema.define(:version => 20140702151603) do

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
  add_index "agents", ["application_id"], :name => "index_agents_on_application_id"
  add_index "agents", ["disabled_at"], :name => "index_agents_on_disabled_at"

  create_table "communication_activities", :force => true do |t|
    t.integer  "person_id",                         :null => false
    t.integer  "resource_id",                       :null => false
    t.integer  "attempt_id"
    t.datetime "first_activity_at",                 :null => false
    t.datetime "last_activity_at",                  :null => false
    t.integer  "seconds_active",                    :null => false
    t.text     "to",                                :null => false
    t.text     "cc",                :default => "", :null => false
    t.text     "bcc",               :default => "", :null => false
    t.text     "subject",                           :null => false
    t.text     "body",              :default => "", :null => false
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  add_index "communication_activities", ["attempt_id"], :name => "index_communication_activities_on_attempt_id"
  add_index "communication_activities", ["first_activity_at"], :name => "index_communication_activities_on_first_activity_at"
  add_index "communication_activities", ["last_activity_at"], :name => "index_communication_activities_on_last_activity_at"
  add_index "communication_activities", ["person_id"], :name => "index_communication_activities_on_person_id"
  add_index "communication_activities", ["resource_id"], :name => "index_communication_activities_on_resource_id"
  add_index "communication_activities", ["seconds_active"], :name => "index_communication_activities_on_seconds_active"

  create_table "cursor_events", :force => true do |t|
    t.integer  "platform_id", :null => false
    t.integer  "person_id",   :null => false
    t.integer  "resource_id", :null => false
    t.integer  "attempt",     :null => false
    t.string   "selector"
    t.text     "metadata"
    t.string   "action",      :null => false
    t.string   "href"
    t.integer  "x_position"
    t.integer  "y_position"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "cursor_events", ["action"], :name => "index_cursor_events_on_action"
  add_index "cursor_events", ["attempt"], :name => "index_cursor_events_on_attempt"
  add_index "cursor_events", ["href"], :name => "index_cursor_events_on_href"
  add_index "cursor_events", ["person_id"], :name => "index_cursor_events_on_person_id"
  add_index "cursor_events", ["platform_id"], :name => "index_cursor_events_on_platform_id"
  add_index "cursor_events", ["resource_id"], :name => "index_cursor_events_on_resource_id"
  add_index "cursor_events", ["selector"], :name => "index_cursor_events_on_selector"
  add_index "cursor_events", ["x_position"], :name => "index_cursor_events_on_x_position"
  add_index "cursor_events", ["y_position"], :name => "index_cursor_events_on_y_position"

  create_table "event_subscribers", :force => true do |t|
    t.integer  "event_id",                         :null => false
    t.integer  "subscriber_id",                    :null => false
    t.boolean  "read",          :default => false, :null => false
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  add_index "event_subscribers", ["event_id", "subscriber_id"], :name => "index_event_subscribers_on_event_id_and_subscriber_id", :unique => true
  add_index "event_subscribers", ["subscriber_id", "read"], :name => "index_event_subscribers_on_subscriber_id_and_read"

  create_table "exercise_activities", :force => true do |t|
    t.integer  "person_id",                         :null => false
    t.integer  "resource_id",                       :null => false
    t.integer  "attempt_id"
    t.datetime "first_activity_at",                 :null => false
    t.datetime "last_activity_at",                  :null => false
    t.integer  "seconds_active",                    :null => false
    t.string   "answer",                            :null => false
    t.boolean  "correct",                           :null => false
    t.text     "free_response",     :default => "", :null => false
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  add_index "exercise_activities", ["answer"], :name => "index_exercise_activities_on_answer"
  add_index "exercise_activities", ["attempt_id"], :name => "index_exercise_activities_on_attempt_id"
  add_index "exercise_activities", ["first_activity_at"], :name => "index_exercise_activities_on_first_activity_at"
  add_index "exercise_activities", ["last_activity_at"], :name => "index_exercise_activities_on_last_activity_at"
  add_index "exercise_activities", ["person_id"], :name => "index_exercise_activities_on_person_id"
  add_index "exercise_activities", ["resource_id"], :name => "index_exercise_activities_on_resource_id"
  add_index "exercise_activities", ["seconds_active"], :name => "index_exercise_activities_on_seconds_active"

  create_table "feedback_activities", :force => true do |t|
    t.integer  "person_id",                         :null => false
    t.integer  "resource_id",                       :null => false
    t.integer  "attempt_id"
    t.datetime "first_activity_at",                 :null => false
    t.datetime "last_activity_at",                  :null => false
    t.integer  "seconds_active",                    :null => false
    t.boolean  "correct",                           :null => false
    t.string   "grade"
    t.text     "feedback",          :default => "", :null => false
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  add_index "feedback_activities", ["attempt_id"], :name => "index_feedback_activities_on_attempt_id"
  add_index "feedback_activities", ["first_activity_at"], :name => "index_feedback_activities_on_first_activity_at"
  add_index "feedback_activities", ["grade"], :name => "index_feedback_activities_on_grade"
  add_index "feedback_activities", ["last_activity_at"], :name => "index_feedback_activities_on_last_activity_at"
  add_index "feedback_activities", ["person_id"], :name => "index_feedback_activities_on_person_id"
  add_index "feedback_activities", ["resource_id"], :name => "index_feedback_activities_on_resource_id"
  add_index "feedback_activities", ["seconds_active"], :name => "index_feedback_activities_on_seconds_active"

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

  create_table "grading_events", :force => true do |t|
    t.integer  "platform_id", :null => false
    t.integer  "person_id",   :null => false
    t.integer  "resource_id", :null => false
    t.integer  "attempt",     :null => false
    t.string   "selector"
    t.text     "metadata"
    t.integer  "grader_id"
    t.string   "grade"
    t.text     "feedback"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "grading_events", ["attempt"], :name => "index_grading_events_on_attempt"
  add_index "grading_events", ["grade"], :name => "index_grading_events_on_grade"
  add_index "grading_events", ["grader_id"], :name => "index_grading_events_on_grader_id"
  add_index "grading_events", ["person_id"], :name => "index_grading_events_on_person_id"
  add_index "grading_events", ["platform_id"], :name => "index_grading_events_on_platform_id"
  add_index "grading_events", ["resource_id"], :name => "index_grading_events_on_resource_id"
  add_index "grading_events", ["selector"], :name => "index_grading_events_on_selector"

  create_table "heartbeat_events", :force => true do |t|
    t.integer  "platform_id", :null => false
    t.integer  "person_id",   :null => false
    t.integer  "resource_id", :null => false
    t.integer  "attempt",     :null => false
    t.string   "selector"
    t.text     "metadata"
    t.integer  "y_position"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "heartbeat_events", ["attempt"], :name => "index_heartbeat_events_on_attempt"
  add_index "heartbeat_events", ["person_id"], :name => "index_heartbeat_events_on_person_id"
  add_index "heartbeat_events", ["platform_id"], :name => "index_heartbeat_events_on_platform_id"
  add_index "heartbeat_events", ["resource_id"], :name => "index_heartbeat_events_on_resource_id"
  add_index "heartbeat_events", ["selector"], :name => "index_heartbeat_events_on_selector"
  add_index "heartbeat_events", ["y_position"], :name => "index_heartbeat_events_on_y_position"

  create_table "input_events", :force => true do |t|
    t.integer  "platform_id", :null => false
    t.integer  "person_id",   :null => false
    t.integer  "resource_id", :null => false
    t.integer  "attempt",     :null => false
    t.string   "selector"
    t.text     "metadata"
    t.string   "category"
    t.string   "input_type"
    t.text     "value"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "input_events", ["attempt"], :name => "index_input_events_on_attempt"
  add_index "input_events", ["category"], :name => "index_input_events_on_category"
  add_index "input_events", ["input_type"], :name => "index_input_events_on_input_type"
  add_index "input_events", ["person_id"], :name => "index_input_events_on_person_id"
  add_index "input_events", ["platform_id"], :name => "index_input_events_on_platform_id"
  add_index "input_events", ["resource_id"], :name => "index_input_events_on_resource_id"
  add_index "input_events", ["selector"], :name => "index_input_events_on_selector"

  create_table "interactive_activities", :force => true do |t|
    t.integer  "person_id",                         :null => false
    t.integer  "resource_id",                       :null => false
    t.integer  "attempt_id"
    t.datetime "first_activity_at",                 :null => false
    t.datetime "last_activity_at",                  :null => false
    t.integer  "seconds_active",                    :null => false
    t.text     "progress",          :default => "", :null => false
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  add_index "interactive_activities", ["attempt_id"], :name => "index_interactive_activities_on_attempt_id"
  add_index "interactive_activities", ["first_activity_at"], :name => "index_interactive_activities_on_first_activity_at"
  add_index "interactive_activities", ["last_activity_at"], :name => "index_interactive_activities_on_last_activity_at"
  add_index "interactive_activities", ["person_id"], :name => "index_interactive_activities_on_person_id"
  add_index "interactive_activities", ["resource_id"], :name => "index_interactive_activities_on_resource_id"
  add_index "interactive_activities", ["seconds_active"], :name => "index_interactive_activities_on_seconds_active"

  create_table "message_events", :force => true do |t|
    t.integer  "platform_id",        :null => false
    t.integer  "person_id",          :null => false
    t.integer  "resource_id",        :null => false
    t.integer  "attempt",            :null => false
    t.string   "selector"
    t.text     "metadata"
    t.integer  "number",             :null => false
    t.integer  "in_reply_to_number"
    t.text     "to"
    t.text     "cc"
    t.text     "bcc"
    t.text     "subject"
    t.text     "body"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "message_events", ["attempt"], :name => "index_message_events_on_attempt"
  add_index "message_events", ["in_reply_to_number", "platform_id"], :name => "index_message_events_on_in_reply_to_number_and_platform_id"
  add_index "message_events", ["number", "platform_id"], :name => "index_message_events_on_number_and_platform_id", :unique => true
  add_index "message_events", ["person_id"], :name => "index_message_events_on_person_id"
  add_index "message_events", ["platform_id"], :name => "index_message_events_on_platform_id"
  add_index "message_events", ["resource_id"], :name => "index_message_events_on_resource_id"
  add_index "message_events", ["selector"], :name => "index_message_events_on_selector"

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

  create_table "page_events", :force => true do |t|
    t.integer  "platform_id", :null => false
    t.integer  "person_id",   :null => false
    t.integer  "resource_id", :null => false
    t.integer  "attempt",     :null => false
    t.string   "selector"
    t.text     "metadata"
    t.string   "from"
    t.string   "to"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "page_events", ["attempt"], :name => "index_page_events_on_attempt"
  add_index "page_events", ["from"], :name => "index_page_events_on_from"
  add_index "page_events", ["person_id"], :name => "index_page_events_on_person_id"
  add_index "page_events", ["platform_id"], :name => "index_page_events_on_platform_id"
  add_index "page_events", ["resource_id"], :name => "index_page_events_on_resource_id"
  add_index "page_events", ["selector"], :name => "index_page_events_on_selector"
  add_index "page_events", ["to"], :name => "index_page_events_on_to"

  create_table "peer_grading_activities", :force => true do |t|
    t.integer  "person_id",                                       :null => false
    t.integer  "resource_id",                                     :null => false
    t.integer  "attempt_id"
    t.datetime "first_activity_at",                               :null => false
    t.datetime "last_activity_at",                                :null => false
    t.integer  "seconds_active",                                  :null => false
    t.binary   "gradee_id",         :limit => 16,                 :null => false
    t.string   "grade",                                           :null => false
    t.text     "feedback",                        :default => "", :null => false
    t.datetime "created_at",                                      :null => false
    t.datetime "updated_at",                                      :null => false
  end

  add_index "peer_grading_activities", ["attempt_id"], :name => "index_peer_grading_activities_on_attempt_id"
  add_index "peer_grading_activities", ["first_activity_at"], :name => "index_peer_grading_activities_on_first_activity_at"
  add_index "peer_grading_activities", ["grade"], :name => "index_peer_grading_activities_on_grade"
  add_index "peer_grading_activities", ["gradee_id"], :name => "index_peer_grading_activities_on_gradee_id"
  add_index "peer_grading_activities", ["last_activity_at"], :name => "index_peer_grading_activities_on_last_activity_at"
  add_index "peer_grading_activities", ["person_id"], :name => "index_peer_grading_activities_on_person_id"
  add_index "peer_grading_activities", ["resource_id"], :name => "index_peer_grading_activities_on_resource_id"
  add_index "peer_grading_activities", ["seconds_active"], :name => "index_peer_grading_activities_on_seconds_active"

  create_table "people", :force => true do |t|
    t.string   "label",         :null => false
    t.integer  "superseder_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "people", ["label"], :name => "index_people_on_label", :unique => true
  add_index "people", ["superseder_id"], :name => "index_people_on_superseder_id"

  create_table "platforms", :force => true do |t|
    t.integer  "application_id", :null => false
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "platforms", ["application_id"], :name => "index_platforms_on_application_id", :unique => true

  create_table "reading_activities", :force => true do |t|
    t.integer  "person_id",         :null => false
    t.integer  "resource_id",       :null => false
    t.integer  "attempt_id"
    t.datetime "first_activity_at", :null => false
    t.datetime "last_activity_at",  :null => false
    t.integer  "seconds_active",    :null => false
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "reading_activities", ["attempt_id"], :name => "index_reading_activities_on_attempt_id"
  add_index "reading_activities", ["first_activity_at"], :name => "index_reading_activities_on_first_activity_at"
  add_index "reading_activities", ["last_activity_at"], :name => "index_reading_activities_on_last_activity_at"
  add_index "reading_activities", ["person_id"], :name => "index_reading_activities_on_person_id"
  add_index "reading_activities", ["resource_id"], :name => "index_reading_activities_on_resource_id"
  add_index "reading_activities", ["seconds_active"], :name => "index_reading_activities_on_seconds_active"

  create_table "researchers", :force => true do |t|
    t.integer  "account_id",  :null => false
    t.datetime "disabled_at"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "researchers", ["account_id"], :name => "index_researchers_on_account_id", :unique => true
  add_index "researchers", ["disabled_at"], :name => "index_researchers_on_disabled_at"

  create_table "resources", :force => true do |t|
    t.string   "reference",   :null => false
    t.integer  "platform_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "resources", ["platform_id"], :name => "index_resources_on_platform_id"
  add_index "resources", ["reference", "platform_id"], :name => "index_resources_on_reference_and_platform_id", :unique => true

  create_table "subscribers", :force => true do |t|
    t.integer  "application_id", :null => false
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "subscribers", ["application_id"], :name => "index_subscribers_on_application_id", :unique => true

  create_table "task_events", :force => true do |t|
    t.integer  "platform_id", :null => false
    t.integer  "person_id",   :null => false
    t.integer  "resource_id", :null => false
    t.integer  "attempt",     :null => false
    t.string   "selector"
    t.text     "metadata"
    t.integer  "number"
    t.integer  "assigner_id"
    t.datetime "due_date"
    t.string   "status"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "task_events", ["assigner_id"], :name => "index_task_events_on_assigner_id"
  add_index "task_events", ["attempt"], :name => "index_task_events_on_attempt"
  add_index "task_events", ["due_date"], :name => "index_task_events_on_due_date"
  add_index "task_events", ["number", "platform_id"], :name => "index_task_events_on_number_and_platform_id"
  add_index "task_events", ["person_id"], :name => "index_task_events_on_person_id"
  add_index "task_events", ["platform_id"], :name => "index_task_events_on_platform_id"
  add_index "task_events", ["resource_id"], :name => "index_task_events_on_resource_id"
  add_index "task_events", ["selector"], :name => "index_task_events_on_selector"
  add_index "task_events", ["status"], :name => "index_task_events_on_status"

end
