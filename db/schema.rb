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

ActiveRecord::Schema.define(version: 20141218171452) do

  create_table "administrators", force: true do |t|
    t.integer  "account_id",  null: false
    t.datetime "disabled_at"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "administrators", ["account_id"], name: "index_administrators_on_account_id", unique: true
  add_index "administrators", ["disabled_at"], name: "index_administrators_on_disabled_at"

  create_table "agents", force: true do |t|
    t.integer  "account_id",                     null: false
    t.integer  "application_id",                 null: false
    t.datetime "disabled_at"
    t.boolean  "is_manager",     default: false, null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "agents", ["account_id", "application_id"], name: "index_agents_on_account_id_and_application_id", unique: true
  add_index "agents", ["disabled_at"], name: "index_agents_on_disabled_at"

  create_table "answer_events", force: true do |t|
    t.integer  "platform_id", null: false
    t.integer  "person_id",   null: false
    t.integer  "resource_id", null: false
    t.integer  "attempt",     null: false
    t.string   "selector"
    t.string   "answer_type", null: false
    t.string   "answer",      null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "answer_events", ["person_id", "platform_id", "resource_id", "attempt"], name: "index_answer_events_on_p_id_and_p_id_and_r_id_and_a", unique: true
  add_index "answer_events", ["platform_id", "resource_id", "attempt"], name: "index_answer_events_on_p_id_and_r_id_and_a"
  add_index "answer_events", ["resource_id", "attempt"], name: "index_answer_events_on_r_id_and_a"
  add_index "answer_events", ["selector"], name: "index_answer_events_on_selector"

  create_table "communication_activities", force: true do |t|
    t.integer  "platform_id",    null: false
    t.integer  "person_id",      null: false
    t.integer  "resource_id",    null: false
    t.integer  "attempt",        null: false
    t.integer  "seconds_active", null: false
    t.datetime "first_event_at", null: false
    t.datetime "last_event_at",  null: false
    t.text     "subject",        null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "communication_activities", ["first_event_at"], name: "index_communication_activities_on_first_event_at"
  add_index "communication_activities", ["last_event_at", "first_event_at"], name: "index_communication_activities_on_l_e_at_and_f_e_at"
  add_index "communication_activities", ["person_id", "platform_id", "resource_id", "attempt"], name: "index_communication_activities_on_p_id_and_p_id_and_r_id_and_a", unique: true
  add_index "communication_activities", ["platform_id", "resource_id", "attempt"], name: "index_communication_activities_on_p_id_and_r_id_and_a"
  add_index "communication_activities", ["resource_id", "attempt"], name: "index_communication_activities_on_resource_id_and_attempt"

  create_table "cursor_events", force: true do |t|
    t.integer  "platform_id", null: false
    t.integer  "person_id",   null: false
    t.integer  "resource_id", null: false
    t.integer  "attempt",     null: false
    t.string   "selector"
    t.string   "action",      null: false
    t.string   "href"
    t.integer  "x_position"
    t.integer  "y_position"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "cursor_events", ["action"], name: "index_cursor_events_on_action"
  add_index "cursor_events", ["href"], name: "index_cursor_events_on_href"
  add_index "cursor_events", ["person_id", "platform_id", "resource_id", "attempt"], name: "index_cursor_events_on_p_id_and_p_id_and_r_id_and_a", unique: true
  add_index "cursor_events", ["platform_id", "resource_id", "attempt"], name: "index_cursor_events_on_p_id_and_r_id_and_a"
  add_index "cursor_events", ["resource_id", "attempt"], name: "index_cursor_events_on_r_id_and_a"
  add_index "cursor_events", ["selector"], name: "index_cursor_events_on_selector"

  create_table "event_subscribers", force: true do |t|
    t.integer  "event_id",                      null: false
    t.integer  "subscriber_id",                 null: false
    t.boolean  "read",          default: false, null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "event_subscribers", ["event_id", "subscriber_id"], name: "index_event_subscribers_on_event_id_and_subscriber_id", unique: true
  add_index "event_subscribers", ["subscriber_id", "read"], name: "index_event_subscribers_on_subscriber_id_and_read"

  create_table "exercise_activities", force: true do |t|
    t.integer  "platform_id",    null: false
    t.integer  "person_id",      null: false
    t.integer  "resource_id",    null: false
    t.integer  "attempt",        null: false
    t.integer  "seconds_active", null: false
    t.datetime "first_event_at", null: false
    t.datetime "last_event_at",  null: false
    t.string   "question_type"
    t.string   "answer"
    t.decimal  "correctness"
    t.text     "free_response"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "exercise_activities", ["first_event_at"], name: "index_exercise_activities_on_first_event_at"
  add_index "exercise_activities", ["last_event_at", "first_event_at"], name: "index_exercise_activities_on_l_e_at_and_f_e_at"
  add_index "exercise_activities", ["person_id", "platform_id", "resource_id", "attempt"], name: "index_exercise_activities_on_p_id_and_p_id_and_r_id_and_a", unique: true
  add_index "exercise_activities", ["platform_id", "resource_id", "attempt"], name: "index_exercise_activities_on_p_id_and_r_id_and_a"
  add_index "exercise_activities", ["question_type"], name: "index_exercise_activities_on_question_type"
  add_index "exercise_activities", ["resource_id", "attempt"], name: "index_exercise_activities_on_resource_id_and_attempt"

  create_table "feedback_activities", force: true do |t|
    t.integer  "platform_id",    null: false
    t.integer  "person_id",      null: false
    t.integer  "resource_id",    null: false
    t.integer  "attempt",        null: false
    t.integer  "seconds_active", null: false
    t.datetime "first_event_at", null: false
    t.datetime "last_event_at",  null: false
    t.decimal  "correctness"
    t.string   "grade"
    t.text     "feedback"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "feedback_activities", ["first_event_at"], name: "index_feedback_activities_on_first_event_at"
  add_index "feedback_activities", ["last_event_at", "first_event_at"], name: "index_feedback_activities_on_l_e_at_and_f_e_at"
  add_index "feedback_activities", ["person_id", "platform_id", "resource_id", "attempt"], name: "index_feedback_activities_on_p_id_and_p_id_and_r_id_and_a", unique: true
  add_index "feedback_activities", ["platform_id", "resource_id", "attempt"], name: "index_feedback_activities_on_p_id_and_r_id_and_a"
  add_index "feedback_activities", ["resource_id", "attempt"], name: "index_feedback_activities_on_resource_id_and_attempt"

  create_table "fine_print_contracts", force: true do |t|
    t.string   "name",       null: false
    t.integer  "version"
    t.string   "title",      null: false
    t.text     "content",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "fine_print_contracts", ["name", "version"], name: "index_fine_print_contracts_on_name_and_version", unique: true

  create_table "fine_print_signatures", force: true do |t|
    t.integer  "contract_id", null: false
    t.integer  "user_id",     null: false
    t.string   "user_type",   null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "fine_print_signatures", ["contract_id"], name: "index_fine_print_signatures_on_contract_id"
  add_index "fine_print_signatures", ["user_id", "user_type", "contract_id"], name: "index_fine_print_s_on_u_id_and_u_type_and_c_id", unique: true

  create_table "grading_events", force: true do |t|
    t.integer  "platform_id", null: false
    t.integer  "person_id",   null: false
    t.integer  "resource_id", null: false
    t.integer  "attempt",     null: false
    t.string   "selector"
    t.string   "grade",       null: false
    t.text     "feedback"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "grading_events", ["person_id", "platform_id", "resource_id", "attempt"], name: "index_grading_events_on_p_id_and_p_id_and_r_id_and_a", unique: true
  add_index "grading_events", ["platform_id", "resource_id", "attempt"], name: "index_grading_events_on_p_id_and_r_id_and_a"
  add_index "grading_events", ["resource_id", "attempt"], name: "index_grading_events_on_r_id_and_a"
  add_index "grading_events", ["selector"], name: "index_grading_events_on_selector"

  create_table "heartbeat_events", force: true do |t|
    t.integer  "platform_id", null: false
    t.integer  "person_id",   null: false
    t.integer  "resource_id", null: false
    t.integer  "attempt",     null: false
    t.string   "selector"
    t.integer  "position"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "heartbeat_events", ["person_id", "platform_id", "resource_id", "attempt"], name: "index_heartbeat_events_on_p_id_and_p_id_and_r_id_and_a", unique: true
  add_index "heartbeat_events", ["platform_id", "resource_id", "attempt"], name: "index_heartbeat_events_on_p_id_and_r_id_and_a"
  add_index "heartbeat_events", ["resource_id", "attempt"], name: "index_heartbeat_events_on_r_id_and_a"
  add_index "heartbeat_events", ["selector"], name: "index_heartbeat_events_on_selector"

  create_table "input_events", force: true do |t|
    t.integer  "platform_id", null: false
    t.integer  "person_id",   null: false
    t.integer  "resource_id", null: false
    t.integer  "attempt",     null: false
    t.string   "selector"
    t.string   "input_type",  null: false
    t.text     "value"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "input_events", ["input_type"], name: "index_input_events_on_input_type"
  add_index "input_events", ["person_id", "platform_id", "resource_id", "attempt"], name: "index_input_events_on_p_id_and_p_id_and_r_id_and_a", unique: true
  add_index "input_events", ["platform_id", "resource_id", "attempt"], name: "index_input_events_on_p_id_and_r_id_and_a"
  add_index "input_events", ["resource_id", "attempt"], name: "index_input_events_on_r_id_and_a"
  add_index "input_events", ["selector"], name: "index_input_events_on_selector"

  create_table "interactive_activities", force: true do |t|
    t.integer  "platform_id",    null: false
    t.integer  "person_id",      null: false
    t.integer  "resource_id",    null: false
    t.integer  "attempt",        null: false
    t.integer  "seconds_active", null: false
    t.datetime "first_event_at", null: false
    t.datetime "last_event_at",  null: false
    t.text     "progress",       null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "interactive_activities", ["first_event_at"], name: "index_interactive_activities_on_first_event_at"
  add_index "interactive_activities", ["last_event_at", "first_event_at"], name: "index_interactive_activities_on_l_e_at_and_f_e_at"
  add_index "interactive_activities", ["person_id", "platform_id", "resource_id", "attempt"], name: "index_interactive_activities_on_p_id_and_p_id_and_r_id_and_a", unique: true
  add_index "interactive_activities", ["platform_id", "resource_id", "attempt"], name: "index_interactive_activities_on_p_id_and_r_id_and_a"
  add_index "interactive_activities", ["resource_id", "attempt"], name: "index_interactive_activities_on_resource_id_and_attempt"

  create_table "message_events", force: true do |t|
    t.integer  "platform_id", null: false
    t.integer  "person_id",   null: false
    t.integer  "resource_id", null: false
    t.integer  "attempt",     null: false
    t.string   "selector"
    t.text     "subject",     null: false
    t.text     "to"
    t.text     "cc"
    t.text     "bcc"
    t.text     "body"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "message_events", ["person_id", "platform_id", "resource_id", "attempt"], name: "index_message_events_on_p_id_and_p_id_and_r_id_and_a", unique: true
  add_index "message_events", ["platform_id", "resource_id", "attempt"], name: "index_message_events_on_p_id_and_r_id_and_a"
  add_index "message_events", ["resource_id", "attempt"], name: "index_message_events_on_r_id_and_a"
  add_index "message_events", ["selector"], name: "index_message_events_on_selector"

  create_table "oauth_access_grants", force: true do |t|
    t.integer  "resource_owner_id", null: false
    t.integer  "application_id",    null: false
    t.string   "token",             null: false
    t.integer  "expires_in",        null: false
    t.text     "redirect_uri",      null: false
    t.datetime "created_at",        null: false
    t.datetime "revoked_at"
    t.string   "scopes"
  end

  add_index "oauth_access_grants", ["token"], name: "index_oauth_access_grants_on_token", unique: true

  create_table "oauth_access_tokens", force: true do |t|
    t.integer  "resource_owner_id"
    t.integer  "application_id"
    t.string   "token",             null: false
    t.string   "refresh_token"
    t.integer  "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at",        null: false
    t.string   "scopes"
  end

  add_index "oauth_access_tokens", ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
  add_index "oauth_access_tokens", ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id"
  add_index "oauth_access_tokens", ["token"], name: "index_oauth_access_tokens_on_token", unique: true

  create_table "oauth_applications", force: true do |t|
    t.string   "name",         null: false
    t.string   "uid",          null: false
    t.string   "secret",       null: false
    t.text     "redirect_uri", null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "oauth_applications", ["uid"], name: "index_oauth_applications_on_uid", unique: true

  create_table "openstax_accounts_accounts", force: true do |t|
    t.integer  "openstax_uid", null: false
    t.string   "username",     null: false
    t.string   "access_token"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "full_name"
    t.string   "title"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "openstax_accounts_accounts", ["access_token"], name: "index_openstax_accounts_accounts_on_access_token", unique: true
  add_index "openstax_accounts_accounts", ["first_name"], name: "index_openstax_accounts_accounts_on_first_name"
  add_index "openstax_accounts_accounts", ["full_name"], name: "index_openstax_accounts_accounts_on_full_name"
  add_index "openstax_accounts_accounts", ["last_name"], name: "index_openstax_accounts_accounts_on_last_name"
  add_index "openstax_accounts_accounts", ["openstax_uid"], name: "index_openstax_accounts_accounts_on_openstax_uid", unique: true
  add_index "openstax_accounts_accounts", ["username"], name: "index_openstax_accounts_accounts_on_username", unique: true

  create_table "openstax_accounts_group_members", force: true do |t|
    t.integer  "group_id",   null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "openstax_accounts_group_members", ["group_id", "user_id"], name: "index_openstax_accounts_group_members_on_group_id_and_user_id", unique: true
  add_index "openstax_accounts_group_members", ["user_id"], name: "index_openstax_accounts_group_members_on_user_id"

  create_table "openstax_accounts_group_nestings", force: true do |t|
    t.integer  "member_group_id",    null: false
    t.integer  "container_group_id", null: false
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "openstax_accounts_group_nestings", ["container_group_id"], name: "index_openstax_accounts_group_nestings_on_container_group_id"
  add_index "openstax_accounts_group_nestings", ["member_group_id"], name: "index_openstax_accounts_group_nestings_on_member_group_id", unique: true

  create_table "openstax_accounts_group_owners", force: true do |t|
    t.integer  "group_id",   null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "openstax_accounts_group_owners", ["group_id", "user_id"], name: "index_openstax_accounts_group_owners_on_group_id_and_user_id", unique: true
  add_index "openstax_accounts_group_owners", ["user_id"], name: "index_openstax_accounts_group_owners_on_user_id"

  create_table "openstax_accounts_groups", force: true do |t|
    t.integer  "openstax_uid",                               null: false
    t.boolean  "is_public",                  default: false, null: false
    t.string   "name"
    t.text     "cached_subtree_group_ids"
    t.text     "cached_supertree_group_ids"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "openstax_accounts_groups", ["openstax_uid"], name: "index_openstax_accounts_groups_on_openstax_uid", unique: true

  create_table "page_events", force: true do |t|
    t.integer  "platform_id", null: false
    t.integer  "person_id",   null: false
    t.integer  "resource_id", null: false
    t.integer  "attempt",     null: false
    t.string   "selector"
    t.string   "from"
    t.string   "to"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "page_events", ["from"], name: "index_page_events_on_from"
  add_index "page_events", ["person_id", "platform_id", "resource_id", "attempt"], name: "index_page_events_on_p_id_and_p_id_and_r_id_and_a", unique: true
  add_index "page_events", ["platform_id", "resource_id", "attempt"], name: "index_page_events_on_p_id_and_r_id_and_a"
  add_index "page_events", ["resource_id", "attempt"], name: "index_page_events_on_r_id_and_a"
  add_index "page_events", ["selector"], name: "index_page_events_on_selector"
  add_index "page_events", ["to"], name: "index_page_events_on_to"

  create_table "peer_grading_activities", force: true do |t|
    t.integer  "platform_id",    null: false
    t.integer  "person_id",      null: false
    t.integer  "resource_id",    null: false
    t.integer  "attempt",        null: false
    t.integer  "seconds_active", null: false
    t.datetime "first_event_at", null: false
    t.datetime "last_event_at",  null: false
    t.decimal  "correctness"
    t.string   "grade"
    t.text     "feedback"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "peer_grading_activities", ["first_event_at"], name: "index_peer_grading_activities_on_first_event_at"
  add_index "peer_grading_activities", ["last_event_at", "first_event_at"], name: "index_peer_grading_activities_on_l_e_at_and_f_e_at"
  add_index "peer_grading_activities", ["person_id", "platform_id", "resource_id", "attempt"], name: "index_peer_grading_activities_on_p_id_and_p_id_and_r_id_and_a", unique: true
  add_index "peer_grading_activities", ["platform_id", "resource_id", "attempt"], name: "index_peer_grading_activities_on_p_id_and_r_id_and_a"
  add_index "peer_grading_activities", ["resource_id", "attempt"], name: "index_peer_grading_activities_on_resource_id_and_attempt"

  create_table "people", force: true do |t|
    t.string   "label",         null: false
    t.integer  "superseder_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "people", ["label"], name: "index_people_on_label", unique: true
  add_index "people", ["superseder_id"], name: "index_people_on_superseder_id"

  create_table "platforms", force: true do |t|
    t.integer  "application_id", null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "platforms", ["application_id"], name: "index_platforms_on_application_id", unique: true

  create_table "reading_activities", force: true do |t|
    t.integer  "platform_id",    null: false
    t.integer  "person_id",      null: false
    t.integer  "resource_id",    null: false
    t.integer  "attempt",        null: false
    t.integer  "seconds_active", null: false
    t.datetime "first_event_at", null: false
    t.datetime "last_event_at",  null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "reading_activities", ["first_event_at"], name: "index_reading_activities_on_first_event_at"
  add_index "reading_activities", ["last_event_at", "first_event_at"], name: "index_reading_activities_on_l_e_at_and_f_e_at"
  add_index "reading_activities", ["person_id", "platform_id", "resource_id", "attempt"], name: "index_reading_activities_on_p_id_and_p_id_and_r_id_and_a", unique: true
  add_index "reading_activities", ["platform_id", "resource_id", "attempt"], name: "index_reading_activities_on_p_id_and_r_id_and_a"
  add_index "reading_activities", ["resource_id", "attempt"], name: "index_reading_activities_on_resource_id_and_attempt"

  create_table "researchers", force: true do |t|
    t.integer  "account_id",  null: false
    t.datetime "disabled_at"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "researchers", ["account_id"], name: "index_researchers_on_account_id", unique: true
  add_index "researchers", ["disabled_at"], name: "index_researchers_on_disabled_at"

  create_table "resources", force: true do |t|
    t.string   "reference",   null: false
    t.integer  "platform_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "resources", ["platform_id"], name: "index_resources_on_platform_id"
  add_index "resources", ["reference", "platform_id"], name: "index_resources_on_reference_and_platform_id", unique: true

  create_table "subscribers", force: true do |t|
    t.integer  "application_id", null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "subscribers", ["application_id"], name: "index_subscribers_on_application_id", unique: true

  create_table "tasking_events", force: true do |t|
    t.integer  "platform_id", null: false
    t.integer  "person_id",   null: false
    t.integer  "resource_id", null: false
    t.integer  "attempt",     null: false
    t.string   "selector"
    t.integer  "taskee_id",   null: false
    t.datetime "due_date"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "tasking_events", ["due_date"], name: "index_tasking_events_on_due_date"
  add_index "tasking_events", ["person_id", "platform_id", "resource_id", "attempt"], name: "index_tasking_events_on_p_id_and_p_id_and_r_id_and_a", unique: true
  add_index "tasking_events", ["platform_id", "resource_id", "attempt"], name: "index_tasking_events_on_p_id_and_r_id_and_a"
  add_index "tasking_events", ["resource_id", "attempt"], name: "index_tasking_events_on_r_id_and_a"
  add_index "tasking_events", ["selector"], name: "index_tasking_events_on_selector"
  add_index "tasking_events", ["taskee_id"], name: "index_tasking_events_on_taskee_id"

end
