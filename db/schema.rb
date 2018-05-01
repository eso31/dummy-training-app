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

ActiveRecord::Schema.define(version: 20180206190456) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assignment_queues", force: :cascade do |t|
    t.integer "assignment_order", null: false
    t.string "status", null: false
    t.bigint "user_id"
    t.bigint "training_request_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["training_request_id"], name: "index_assignment_queues_on_training_request_id"
    t.index ["user_id"], name: "index_assignment_queues_on_user_id"
  end

  create_table "audits", force: :cascade do |t|
    t.integer "auditable_id"
    t.string "auditable_type"
    t.integer "associated_id"
    t.string "associated_type"
    t.integer "user_id"
    t.string "user_type"
    t.string "username"
    t.string "action"
    t.text "audited_changes"
    t.integer "version", default: 0
    t.string "comment"
    t.string "remote_address"
    t.string "request_uuid"
    t.datetime "created_at"
    t.index ["associated_id", "associated_type"], name: "associated_index"
    t.index ["auditable_id", "auditable_type"], name: "auditable_index"
    t.index ["created_at"], name: "index_audits_on_created_at"
    t.index ["request_uuid"], name: "index_audits_on_request_uuid"
    t.index ["user_id", "user_type"], name: "user_index"
  end

  create_table "class_locations", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "timezone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "courses", force: :cascade do |t|
    t.string "title", null: false
    t.string "description"
    t.integer "duration_in_minutes", null: false
    t.integer "min_group_size", null: false
    t.integer "max_group_size", null: false
    t.bigint "taught_by_user_id"
    t.bigint "series_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["series_id"], name: "index_courses_on_series_id"
    t.index ["taught_by_user_id"], name: "index_courses_on_taught_by_user_id"
  end

  create_table "enrollments", force: :cascade do |t|
    t.boolean "attended", default: false
    t.bigint "user_id"
    t.bigint "training_session_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["training_session_id"], name: "index_enrollments_on_training_session_id"
    t.index ["user_id"], name: "index_enrollments_on_user_id"
  end

  create_table "financial_accounts", force: :cascade do |t|
    t.string "name", null: false
    t.string "status", null: false
    t.bigint "parent_account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parent_account_id"], name: "index_financial_accounts_on_parent_account_id"
  end

  create_table "general_ledgers", force: :cascade do |t|
    t.string "transaction_type", null: false
    t.text "description", null: false
    t.datetime "transaction_date"
    t.decimal "amount", null: false
    t.bigint "financial_account_id"
    t.bigint "ledger_category_id"
    t.bigint "training_request_id"
    t.bigint "training_session_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["financial_account_id"], name: "index_general_ledgers_on_financial_account_id"
    t.index ["ledger_category_id"], name: "index_general_ledgers_on_ledger_category_id"
    t.index ["training_request_id"], name: "index_general_ledgers_on_training_request_id"
    t.index ["training_session_id"], name: "index_general_ledgers_on_training_session_id"
  end

  create_table "instructors", id: false, force: :cascade do |t|
    t.bigint "training_session_id", null: false
    t.bigint "user_id", null: false
    t.index ["training_session_id", "user_id"], name: "index_instructors_on_training_session_id_and_user_id"
  end

  create_table "ledger_categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rating_reasons", force: :cascade do |t|
    t.string "description"
    t.string "rating_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "requesters", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "training_request_id"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["training_request_id"], name: "index_requesters_on_training_request_id"
    t.index ["user_id"], name: "index_requesters_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
  end

  create_table "series", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "session_rating_reasons", id: false, force: :cascade do |t|
    t.bigint "session_rating_id", null: false
    t.bigint "rating_reason_id", null: false
    t.bigint "session_rating_id_id"
    t.bigint "rating_reason_id_id"
    t.index ["rating_reason_id_id"], name: "index_session_rating_reasons_on_rating_reason_id_id"
    t.index ["session_rating_id_id"], name: "index_session_rating_reasons_on_session_rating_id_id"
  end

  create_table "session_ratings", force: :cascade do |t|
    t.integer "rating"
    t.string "user_type"
    t.text "comment"
    t.bigint "enrollment_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["enrollment_id"], name: "index_session_ratings_on_enrollment_id"
    t.index ["user_id"], name: "index_session_ratings_on_user_id"
  end

  create_table "training_request_polls", force: :cascade do |t|
    t.string "vote", null: false
    t.text "comment"
    t.bigint "training_request_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["training_request_id"], name: "index_training_request_polls_on_training_request_id"
    t.index ["user_id"], name: "index_training_request_polls_on_user_id"
  end

  create_table "training_requests", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", null: false
    t.string "location"
    t.integer "duration_in_minutes"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string "status", null: false
    t.string "reference_file"
    t.bigint "assigned_to_user_id"
    t.bigint "requested_by_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assigned_to_user_id"], name: "index_training_requests_on_assigned_to_user_id"
    t.index ["requested_by_user_id"], name: "index_training_requests_on_requested_by_user_id"
  end

  create_table "training_sessions", force: :cascade do |t|
    t.string "title", null: false
    t.text "description", null: false
    t.integer "min_group_size", default: 5, null: false
    t.integer "max_group_size", default: 10, null: false
    t.datetime "start_date", null: false
    t.string "url"
    t.integer "duration_in_minutes", default: 120, null: false
    t.decimal "compensation"
    t.boolean "compensation_delivered"
    t.string "session_type", null: false
    t.string "google_calendar_id"
    t.string "google_calendar_event_id"
    t.bigint "course_id"
    t.bigint "class_location_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "published", default: true
    t.index ["class_location_id"], name: "index_training_sessions_on_class_location_id"
    t.index ["course_id"], name: "index_training_sessions_on_course_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "image"
    t.boolean "vegetarian"
    t.boolean "notification", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  add_foreign_key "assignment_queues", "training_requests", on_delete: :cascade
  add_foreign_key "assignment_queues", "users", on_delete: :cascade
  add_foreign_key "courses", "series"
  add_foreign_key "courses", "users", column: "taught_by_user_id"
  add_foreign_key "enrollments", "training_sessions", on_delete: :cascade
  add_foreign_key "enrollments", "users"
  add_foreign_key "financial_accounts", "financial_accounts", column: "parent_account_id"
  add_foreign_key "general_ledgers", "financial_accounts"
  add_foreign_key "general_ledgers", "ledger_categories"
  add_foreign_key "general_ledgers", "training_requests"
  add_foreign_key "general_ledgers", "training_sessions"
  add_foreign_key "instructors", "training_sessions", on_delete: :cascade
  add_foreign_key "instructors", "users", on_delete: :restrict
  add_foreign_key "requesters", "training_requests", on_delete: :cascade
  add_foreign_key "requesters", "users", on_delete: :cascade
  add_foreign_key "session_rating_reasons", "rating_reasons", on_delete: :restrict
  add_foreign_key "session_rating_reasons", "session_ratings", on_delete: :cascade
  add_foreign_key "session_ratings", "enrollments", on_delete: :cascade
  add_foreign_key "session_ratings", "users", on_delete: :cascade
  add_foreign_key "training_request_polls", "training_requests"
  add_foreign_key "training_request_polls", "users"
  add_foreign_key "training_requests", "users", column: "assigned_to_user_id"
  add_foreign_key "training_requests", "users", column: "requested_by_user_id"
  add_foreign_key "training_sessions", "class_locations"
  add_foreign_key "training_sessions", "courses"
  add_foreign_key "users_roles", "roles", on_delete: :restrict
  add_foreign_key "users_roles", "users", on_delete: :cascade
end
