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

ActiveRecord::Schema.define(version: 20150105230553) do

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
    t.integer  "task_id",     null: false
    t.string   "answer_type", null: false
    t.string   "answer",      null: false
    t.decimal  "correctness"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "answer_events", ["task_id", "answer_type"], name: "index_answer_events_on_task_id_and_answer_type"
  add_index "answer_events", ["task_id", "correctness"], name: "index_answer_events_on_task_id_and_correctness"

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
    t.integer  "task_id",        null: false
    t.integer  "seconds_active", null: false
    t.datetime "first_event_at", null: false
    t.datetime "last_event_at",  null: false
    t.string   "answer_type"
    t.string   "answer"
    t.decimal  "correctness"
    t.text     "free_response"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "exercise_activities", ["first_event_at"], name: "index_exercise_activities_on_first_event_at"
  add_index "exercise_activities", ["last_event_at", "first_event_at"], name: "index_exercise_activities_on_l_e_at_and_f_e_at"
  add_index "exercise_activities", ["task_id"], name: "index_exercise_activities_on_task_id"

  create_table "feedback_activities", force: true do |t|
    t.integer  "task_id",        null: false
    t.integer  "seconds_active", null: false
    t.datetime "first_event_at", null: false
    t.datetime "last_event_at",  null: false
    t.string   "grade"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "feedback_activities", ["first_event_at"], name: "index_feedback_activities_on_first_event_at"
  add_index "feedback_activities", ["last_event_at", "first_event_at"], name: "index_feedback_activities_on_l_e_at_and_f_e_at"
  add_index "feedback_activities", ["task_id"], name: "index_feedback_activities_on_task_id"

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
    t.integer  "task_id",    null: false
    t.string   "grader",     null: false
    t.string   "grade",      null: false
    t.text     "feedback"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "grading_events", ["grader"], name: "index_grading_events_on_grader"
  add_index "grading_events", ["task_id"], name: "index_grading_events_on_task_id"

  create_table "heartbeat_events", force: true do |t|
    t.integer  "task_id",    null: false
    t.boolean  "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "heartbeat_events", ["task_id"], name: "index_heartbeat_events_on_task_id"

  create_table "identifiers", force: true do |t|
    t.integer  "platform_id",    null: false
    t.integer  "person_id",      null: false
    t.string   "research_label", null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "identifiers", ["person_id", "platform_id"], name: "index_identifiers_on_person_id_and_platform_id"
  add_index "identifiers", ["research_label"], name: "index_identifiers_on_research_label", unique: true

  create_table "interactive_activities", force: true do |t|
    t.integer  "task_id",        null: false
    t.integer  "seconds_active", null: false
    t.datetime "first_event_at", null: false
    t.datetime "last_event_at",  null: false
    t.text     "progress"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "interactive_activities", ["first_event_at"], name: "index_interactive_activities_on_first_event_at"
  add_index "interactive_activities", ["last_event_at", "first_event_at"], name: "index_interactive_activities_on_l_e_at_and_f_e_at"
  add_index "interactive_activities", ["task_id"], name: "index_interactive_activities_on_task_id"

  create_table "link_events", force: true do |t|
    t.integer  "task_id",    null: false
    t.string   "href"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "link_events", ["href"], name: "index_link_events_on_href"
  add_index "link_events", ["task_id"], name: "index_link_events_on_task_id"

  create_table "links", force: true do |t|
    t.integer  "resource_id", null: false
    t.string   "href",        null: false
    t.string   "rel",         null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "links", ["href", "rel"], name: "index_links_on_href_and_rel", unique: true
  add_index "links", ["resource_id"], name: "index_links_on_resource_id"

  create_table "load_events", force: true do |t|
    t.integer  "task_id",    null: false
    t.string   "referer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "load_events", ["referer"], name: "index_load_events_on_referer"
  add_index "load_events", ["task_id"], name: "index_load_events_on_task_id"

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

  create_table "peer_grading_activities", force: true do |t|
    t.integer  "task_id",        null: false
    t.integer  "seconds_active", null: false
    t.datetime "first_event_at", null: false
    t.datetime "last_event_at",  null: false
    t.integer  "grader_id",      null: false
    t.string   "grade"
    t.text     "feedback"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "peer_grading_activities", ["first_event_at"], name: "index_peer_grading_activities_on_first_event_at"
  add_index "peer_grading_activities", ["grader_id"], name: "index_peer_grading_activities_on_grader_id"
  add_index "peer_grading_activities", ["last_event_at", "first_event_at"], name: "index_peer_grading_activities_on_l_e_at_and_f_e_at"
  add_index "peer_grading_activities", ["task_id"], name: "index_peer_grading_activities_on_task_id"

  create_table "people", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "platforms", force: true do |t|
    t.integer  "application_id", null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "platforms", ["application_id"], name: "index_platforms_on_application_id", unique: true

  create_table "reading_activities", force: true do |t|
    t.integer  "task_id",        null: false
    t.integer  "seconds_active", null: false
    t.datetime "first_event_at", null: false
    t.datetime "last_event_at",  null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "reading_activities", ["first_event_at"], name: "index_reading_activities_on_first_event_at"
  add_index "reading_activities", ["last_event_at", "first_event_at"], name: "index_reading_activities_on_l_e_at_and_f_e_at"
  add_index "reading_activities", ["task_id"], name: "index_reading_activities_on_task_id"

  create_table "researchers", force: true do |t|
    t.integer  "account_id",  null: false
    t.datetime "disabled_at"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "researchers", ["account_id"], name: "index_researchers_on_account_id", unique: true
  add_index "researchers", ["disabled_at"], name: "index_researchers_on_disabled_at"

  create_table "resources", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subscribers", force: true do |t|
    t.integer  "application_id", null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "subscribers", ["application_id"], name: "index_subscribers_on_application_id", unique: true

  create_table "tasking_events", force: true do |t|
    t.integer  "task_id",    null: false
    t.string   "tasker",     null: false
    t.datetime "due_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "tasking_events", ["due_date"], name: "index_tasking_events_on_due_date"
  add_index "tasking_events", ["task_id"], name: "index_tasking_events_on_task_id"
  add_index "tasking_events", ["tasker"], name: "index_tasking_events_on_tasker"

  create_table "tasks", force: true do |t|
    t.integer  "identifier_id", null: false
    t.integer  "resource_id",   null: false
    t.string   "trial",         null: false
    t.datetime "due_at"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "tasks", ["due_at"], name: "index_tasks_on_due_at"
  add_index "tasks", ["identifier_id", "resource_id", "trial"], name: "index_tasks_on_identifier_id_and_resource_id_and_trial", unique: true
  add_index "tasks", ["resource_id", "trial"], name: "index_tasks_on_resource_id_and_trial"

  create_table "unload_events", force: true do |t|
    t.integer  "task_id",     null: false
    t.string   "destination"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "unload_events", ["destination"], name: "index_unload_events_on_destination"
  add_index "unload_events", ["task_id"], name: "index_unload_events_on_task_id"

end
