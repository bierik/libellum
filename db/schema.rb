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

ActiveRecord::Schema.define(version: 2019_09_17_145447) do

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
    t.string "firstname"
    t.string "lastname"
    t.string "street"
    t.string "number"
    t.string "place"
    t.string "zip"
    t.integer "distance"
    t.integer "route_flat"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "price_per_hour", default: "50.0"
  end

  create_table "flat_templates", force: :cascade do |t|
    t.string "name"
    t.float "price"
  end

  create_table "flats", force: :cascade do |t|
    t.string "name"
    t.float "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "task_id"
  end

  create_table "invoices", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "customer_id"
    t.date "date"
    t.boolean "archived"
  end

  create_table "reports", force: :cascade do |t|
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "task_id"
    t.string "title"
  end

  create_table "settings", force: :cascade do |t|
    t.string "firstname"
    t.string "lastname"
    t.string "street"
    t.string "number"
    t.string "place"
    t.string "zip"
    t.string "maps_api_key"
  end

  create_table "task_containers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.datetime "start"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "customer_id"
    t.bigint "task_container_id"
    t.datetime "end"
    t.index ["task_container_id"], name: "index_tasks_on_task_container_id"
  end

  add_foreign_key "flats", "tasks"
  add_foreign_key "invoices", "customers"
  add_foreign_key "reports", "tasks"
  add_foreign_key "tasks", "customers"
  add_foreign_key "tasks", "task_containers"
end
