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

ActiveRecord::Schema.define(version: 2021_03_02_114927) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "batches", id: :string, limit: 7, force: :cascade do |t|
    t.string "file_guid", null: false
    t.boolean "status", default: true
    t.date "creation_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["file_guid"], name: "index_batches_on_file_guid"
  end

  create_table "parcels", force: :cascade do |t|
    t.string "batch_id"
    t.string "company_code", limit: 4, null: false
    t.string "invoice_operation_number", limit: 9, null: false
    t.date "invoice_operation_date", null: false
    t.string "parcel_code", limit: 15, null: false
    t.integer "item_qty", null: false
    t.integer "parcel_price", null: false
    t.index ["batch_id"], name: "index_parcels_on_batch_id"
    t.index ["invoice_operation_number"], name: "index_parcels_on_invoice_operation_number"
    t.index ["parcel_code"], name: "index_parcels_on_parcel_code"
  end

  add_foreign_key "parcels", "batches"
end
