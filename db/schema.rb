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

ActiveRecord::Schema.define(version: 20150706233120) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "alert_types", force: :cascade do |t|
    t.string   "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "alerts", force: :cascade do |t|
    t.string   "mensaje"
    t.datetime "fecha"
    t.integer  "zone_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "alert_type_id"
  end

  add_index "alerts", ["alert_type_id"], name: "index_alerts_on_alert_type_id", using: :btree
  add_index "alerts", ["zone_id"], name: "index_alerts_on_zone_id", using: :btree

  create_table "people", force: :cascade do |t|
    t.string   "nombre"
    t.string   "apellido"
    t.integer  "zone_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "people", ["zone_id"], name: "index_people_on_zone_id", using: :btree

  create_table "visits", force: :cascade do |t|
    t.text     "descripcion"
    t.datetime "fecha"
    t.integer  "person_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.decimal  "latitud"
    t.decimal  "longitud"
  end

  add_index "visits", ["person_id"], name: "index_visits_on_person_id", using: :btree

  create_table "welcome_messages", force: :cascade do |t|
    t.string   "mensaje"
    t.datetime "fecha_desde"
    t.datetime "fecha_hasta"
    t.integer  "person_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "welcome_messages", ["person_id"], name: "index_welcome_messages_on_person_id", using: :btree

  create_table "zones", force: :cascade do |t|
    t.string   "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "alerts", "alert_types"
  add_foreign_key "alerts", "zones"
  add_foreign_key "people", "zones"
  add_foreign_key "visits", "people"
  add_foreign_key "welcome_messages", "people"
end
