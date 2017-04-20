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

ActiveRecord::Schema.define(version: 20170420171243) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "breweries", force: :cascade do |t|
    t.string   "name"
    t.integer  "contact_id"
    t.string   "address_street"
    t.string   "address_city"
    t.string   "address_state"
    t.string   "address_zip"
    t.string   "phone"
    t.string   "email"
    t.string   "website"
    t.integer  "menu_id"
    t.string   "logo"
    t.string   "yelp_url"
    t.text     "description"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "remote_schedule_endpoint"
    t.boolean  "remote_endpoint_requires_date"
    t.string   "event_hours"
    t.string   "schedule_scan_pattern"
    t.string   "schedule_gsub_pattern"
    t.index ["contact_id"], name: "index_breweries_on_contact_id", using: :btree
    t.index ["menu_id"], name: "index_breweries_on_menu_id", using: :btree
  end

  create_table "contacts", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "food_truck_calendars", force: :cascade do |t|
    t.integer  "brewery_id"
    t.integer  "food_truck_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["brewery_id"], name: "index_food_truck_calendars_on_brewery_id", using: :btree
    t.index ["food_truck_id"], name: "index_food_truck_calendars_on_food_truck_id", using: :btree
  end

  create_table "food_trucks", force: :cascade do |t|
    t.string   "name"
    t.integer  "menu_id"
    t.integer  "contact_id"
    t.string   "email"
    t.string   "website"
    t.string   "logo"
    t.string   "yelp_url"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "brewery_id"
    t.index ["brewery_id"], name: "index_food_trucks_on_brewery_id", using: :btree
    t.index ["contact_id"], name: "index_food_trucks_on_contact_id", using: :btree
    t.index ["menu_id"], name: "index_food_trucks_on_menu_id", using: :btree
  end

  create_table "menu_items", force: :cascade do |t|
    t.integer  "menu_id"
    t.string   "name"
    t.text     "description"
    t.string   "image_url"
    t.money    "price",       scale: 2
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["menu_id"], name: "index_menu_items_on_menu_id", using: :btree
  end

  create_table "menus", force: :cascade do |t|
    t.string   "image_url"
    t.string   "owner_type"
    t.integer  "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_type", "owner_id"], name: "index_menus_on_owner_type_and_owner_id", using: :btree
  end

  create_table "ratings", force: :cascade do |t|
    t.string   "owner_type"
    t.integer  "owner_id"
    t.integer  "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_type", "owner_id"], name: "index_ratings_on_owner_type_and_owner_id", using: :btree
  end

  add_foreign_key "breweries", "contacts"
  add_foreign_key "breweries", "menus"
  add_foreign_key "food_truck_calendars", "breweries"
  add_foreign_key "food_truck_calendars", "food_trucks"
  add_foreign_key "food_trucks", "breweries"
  add_foreign_key "food_trucks", "contacts"
  add_foreign_key "food_trucks", "menus"
  add_foreign_key "menu_items", "menus"
end
