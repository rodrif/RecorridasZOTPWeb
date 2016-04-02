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

ActiveRecord::Schema.define(version: 20160225230654) do

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

  create_table "areas", force: :cascade do |t|
    t.string   "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "state_id"
  end

  add_index "areas", ["state_id"], name: "index_areas_on_state_id", using: :btree

  create_table "familias", force: :cascade do |t|
    t.string   "nombre"
    t.integer  "zone_id"
    t.integer  "ranchada_id"
    t.text     "descripcion"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "state_id"
  end

  add_index "familias", ["ranchada_id"], name: "index_familias_on_ranchada_id", using: :btree
  add_index "familias", ["state_id"], name: "index_familias_on_state_id", using: :btree
  add_index "familias", ["zone_id"], name: "index_familias_on_zone_id", using: :btree

  create_table "people", force: :cascade do |t|
    t.string   "nombre"
    t.string   "apellido"
    t.integer  "zone_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "state_id"
    t.integer  "dni"
    t.date     "fecha_nacimiento"
    t.string   "telefono"
    t.integer  "familia_id"
    t.text     "descripcion"
    t.integer  "ranchada_id"
  end

  add_index "people", ["familia_id"], name: "index_people_on_familia_id", using: :btree
  add_index "people", ["ranchada_id"], name: "index_people_on_ranchada_id", using: :btree
  add_index "people", ["state_id"], name: "index_people_on_state_id", using: :btree
  add_index "people", ["zone_id"], name: "index_people_on_zone_id", using: :btree

  create_table "ranchadas", force: :cascade do |t|
    t.string   "nombre"
    t.integer  "zone_id"
    t.text     "descripcion"
    t.decimal  "latitud"
    t.decimal  "longitud"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "state_id"
  end

  add_index "ranchadas", ["state_id"], name: "index_ranchadas_on_state_id", using: :btree
  add_index "ranchadas", ["zone_id"], name: "index_ranchadas_on_zone_id", using: :btree

  create_table "referentes", force: :cascade do |t|
    t.string   "nombre"
    t.string   "apellido"
    t.string   "telefono"
    t.integer  "area_id"
    t.string   "dia"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "state_id"
  end

  add_index "referentes", ["area_id"], name: "index_referentes_on_area_id", using: :btree
  add_index "referentes", ["state_id"], name: "index_referentes_on_state_id", using: :btree

  create_table "states", force: :cascade do |t|
    t.string   "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "visits", force: :cascade do |t|
    t.text     "descripcion"
    t.datetime "fecha"
    t.integer  "person_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.decimal  "latitud"
    t.decimal  "longitud"
    t.integer  "state_id"
  end

  add_index "visits", ["person_id"], name: "index_visits_on_person_id", using: :btree
  add_index "visits", ["state_id"], name: "index_visits_on_state_id", using: :btree

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
    t.integer  "area_id"
    t.float    "latitud"
    t.float    "longitud"
    t.integer  "state_id"
  end

  add_index "zones", ["area_id"], name: "index_zones_on_area_id", using: :btree
  add_index "zones", ["state_id"], name: "index_zones_on_state_id", using: :btree

  add_foreign_key "alerts", "alert_types"
  add_foreign_key "alerts", "zones"
  add_foreign_key "areas", "states"
  add_foreign_key "familias", "ranchadas"
  add_foreign_key "familias", "states"
  add_foreign_key "familias", "zones"
  add_foreign_key "people", "familias"
  add_foreign_key "people", "ranchadas"
  add_foreign_key "people", "states"
  add_foreign_key "people", "zones"
  add_foreign_key "ranchadas", "states"
  add_foreign_key "ranchadas", "zones"
  add_foreign_key "referentes", "areas"
  add_foreign_key "referentes", "states"
  add_foreign_key "visits", "people"
  add_foreign_key "visits", "states"
  add_foreign_key "welcome_messages", "people"
  add_foreign_key "zones", "areas"
  add_foreign_key "zones", "states"
end
