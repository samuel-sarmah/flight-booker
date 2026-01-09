# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2026_01_09_080514) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "airports", force: :cascade do |t|
    t.string "airport_name"
    t.string "airport_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bookings", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "flight_id", null: false
    t.integer "status", default: 0, null: false
    t.string "booking_reference"
    t.integer "total_passengers", default: 1
    t.string "guest_email"
    t.string "phone"
    t.boolean "guest_checkout", default: false
    t.index ["booking_reference"], name: "index_bookings_on_booking_reference", unique: true
    t.index ["flight_id"], name: "index_bookings_on_flight_id"
    t.index ["guest_email"], name: "index_bookings_on_guest_email"
  end

  create_table "flights", force: :cascade do |t|
    t.integer "departure_airport_id"
    t.integer "arrival_airport_id"
    t.integer "flight_duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "startdatetime"
    t.integer "seat_capacity", default: 150, null: false
    t.decimal "price", precision: 10, scale: 2, default: "199.99"
    t.string "flight_number"
    t.index ["flight_number"], name: "index_flights_on_flight_number", unique: true
  end

  create_table "passengers", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "booking_id", null: false
    t.string "ticket_number"
    t.index ["booking_id"], name: "index_passengers_on_booking_id"
  end

  add_foreign_key "bookings", "flights"
  add_foreign_key "passengers", "bookings"
end
