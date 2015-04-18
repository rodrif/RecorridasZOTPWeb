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

ActiveRecord::Schema.define(version: 20150418014951) do

  create_table "alert_types", force: :cascade do |t|
    t.string   "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "alerts", force: :cascade do |t|
    t.string   "mensaje"
    t.datetime "fecha"
    t.integer  "zone_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "alerts", ["zone_id"], name: "index_alerts_on_zone_id"

  create_table "locations", force: :cascade do |t|
    t.string   "latitud"
    t.string   "longitud"
    t.datetime "fecha"
    t.integer  "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "locations", ["person_id"], name: "index_locations_on_person_id"

  create_table "people", force: :cascade do |t|
    t.string   "nombre"
    t.string   "apellido"
    t.integer  "zone_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "people", ["zone_id"], name: "index_people_on_zone_id"

  create_table "visits", force: :cascade do |t|
    t.text     "descripcion"
    t.datetime "fecha"
    t.integer  "person_id"
    t.integer  "location_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "visits", ["location_id"], name: "index_visits_on_location_id"
  add_index "visits", ["person_id"], name: "index_visits_on_person_id"

  create_table "zones", force: :cascade do |t|
    t.string   "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
