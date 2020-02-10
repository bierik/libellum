# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_02_04_143620) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "customers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "street"
    t.string "number"
    t.string "place"
    t.string "zip"
    t.integer "distance"
    t.integer "route_flat"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "price_per_hour", default: "50.0"
    t.bigint "organization_id", null: false
    t.index ["organization_id"], name: "index_customers_on_organization_id"
  end

  create_table "flat_templates", force: :cascade do |t|
    t.string "name"
    t.float "price"
    t.bigint "organization_id", null: false
    t.index ["organization_id"], name: "index_flat_templates_on_organization_id"
  end

  create_table "flats", force: :cascade do |t|
    t.string "name"
    t.float "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "organization_id", null: false
    t.bigint "customer_id"
    t.date "used_date", null: false
    t.integer "count", default: 1
    t.index ["customer_id"], name: "index_flats_on_customer_id"
    t.index ["organization_id"], name: "index_flats_on_organization_id"
  end

  create_table "invoices", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "customer_id"
    t.date "date"
    t.boolean "archived"
    t.bigint "organization_id", null: false
    t.index ["organization_id"], name: "index_invoices_on_organization_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "handle", null: false
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "company"
    t.string "first_name"
    t.string "last_name"
    t.string "street"
    t.string "number"
    t.string "zip"
    t.string "place"
    t.float "price_per_hour"
    t.integer "report_invoice_round", default: 300
  end

  create_table "organizations_users", id: false, force: :cascade do |t|
    t.bigint "organization_id"
    t.bigint "user_id"
    t.index ["organization_id"], name: "index_organizations_users_on_organization_id"
    t.index ["user_id"], name: "index_organizations_users_on_user_id"
  end

  create_table "reports", force: :cascade do |t|
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.bigint "organization_id", null: false
    t.bigint "customer_id"
    t.index ["customer_id"], name: "index_reports_on_customer_id"
    t.index ["organization_id"], name: "index_reports_on_organization_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.datetime "start"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "customer_id"
    t.datetime "end"
    t.bigint "organization_id", null: false
    t.index ["organization_id"], name: "index_tasks_on_organization_id"
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
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.boolean "admin", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "last_name"
    t.string "first_name"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "flats", "customers"
  add_foreign_key "invoices", "customers"
  add_foreign_key "reports", "customers"
  add_foreign_key "tasks", "customers"
end
