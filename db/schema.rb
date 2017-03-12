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

ActiveRecord::Schema.define(version: 20170312132850) do

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

  create_table "areas_notificaciones", id: false, force: :cascade do |t|
    t.integer "notificacion_id", null: false
    t.integer "area_id",         null: false
  end

  create_table "auditorias", force: :cascade do |t|
    t.datetime "fecha"
    t.string   "email"
    t.string   "accion"
    t.string   "entidad"
    t.integer  "entity_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.text     "descripcion"
    t.integer  "user_id"
  end

  add_index "auditorias", ["user_id"], name: "index_auditorias_on_user_id", using: :btree

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "departamentos", force: :cascade do |t|
    t.string  "nombre"
    t.integer "state_id"
  end

  add_index "departamentos", ["state_id"], name: "index_departamentos_on_state_id", using: :btree

  create_table "departamentos_people", id: false, force: :cascade do |t|
    t.integer "departamento_id", null: false
    t.integer "person_id",       null: false
  end

  create_table "estados", force: :cascade do |t|
    t.string   "nombre"
    t.integer  "state_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "estados", ["state_id"], name: "index_estados_on_state_id", using: :btree

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

  create_table "frecuencia_tipos", force: :cascade do |t|
    t.string   "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "code"
  end

  create_table "jornadas", force: :cascade do |t|
    t.string   "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "jornadas_users", id: false, force: :cascade do |t|
    t.integer "user_id",    null: false
    t.integer "jornada_id", null: false
  end

  create_table "meetings", force: :cascade do |t|
    t.string   "name"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notificacion_roles", force: :cascade do |t|
    t.integer  "notificacion_id"
    t.integer  "rol_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "notificacion_roles", ["notificacion_id"], name: "index_notificacion_roles_on_notificacion_id", using: :btree
  add_index "notificacion_roles", ["rol_id"], name: "index_notificacion_roles_on_rol_id", using: :btree

  create_table "notificacion_tipos", force: :cascade do |t|
    t.string   "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "code"
  end

  create_table "notificaciones", force: :cascade do |t|
    t.string   "titulo"
    t.string   "subtitulo"
    t.datetime "fecha_desde"
    t.datetime "fecha_hasta"
    t.integer  "notificacion_tipo_id"
    t.text     "descripcion"
    t.integer  "frecuencia_cant"
    t.integer  "frecuencia_tipo_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "state_id"
    t.datetime "prox_envio"
    t.boolean  "finalizada"
  end

  add_index "notificaciones", ["frecuencia_tipo_id"], name: "index_notificaciones_on_frecuencia_tipo_id", using: :btree
  add_index "notificaciones", ["notificacion_tipo_id"], name: "index_notificaciones_on_notificacion_tipo_id", using: :btree
  add_index "notificaciones", ["state_id"], name: "index_notificaciones_on_state_id", using: :btree

  create_table "pedidos", force: :cascade do |t|
    t.datetime "fecha"
    t.string   "descripcion"
    t.integer  "person_id"
    t.boolean  "completado"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "state_id"
  end

  add_index "pedidos", ["person_id"], name: "index_pedidos_on_person_id", using: :btree
  add_index "pedidos", ["state_id"], name: "index_pedidos_on_state_id", using: :btree

  create_table "people", force: :cascade do |t|
    t.string   "nombre"
    t.string   "apellido"
    t.integer  "zone_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "state_id"
    t.string   "dni"
    t.date     "fecha_nacimiento"
    t.string   "telefono"
    t.integer  "familia_id"
    t.text     "descripcion"
    t.integer  "ranchada_id"
    t.string   "pantalon"
    t.string   "remera"
    t.string   "zapatillas"
    t.integer  "estado_id"
  end

  add_index "people", ["estado_id"], name: "index_people_on_estado_id", using: :btree
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

  create_table "roles", force: :cascade do |t|
    t.string   "nombre"
    t.boolean  "puede_crear_persona"
    t.boolean  "puede_editar_persona"
    t.boolean  "puede_borrar_persona"
    t.boolean  "puede_ver_telefono_persona"
    t.boolean  "puede_ver_web"
    t.boolean  "puede_crear_visita"
    t.boolean  "puede_editar_visita"
    t.boolean  "puede_borrar_visita"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "code"
  end

  create_table "states", force: :cascade do |t|
    t.string   "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",      null: false
    t.string   "encrypted_password",     default: "",      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "provider",               default: "email", null: false
    t.string   "uid",                    default: ""
    t.string   "name"
    t.string   "nickname"
    t.string   "image"
    t.text     "tokens"
    t.integer  "rol_id"
    t.string   "apellido"
    t.integer  "area_id"
    t.integer  "state_id"
    t.string   "dia"
    t.date     "fecha_nacimiento"
    t.string   "telefono"
  end

  add_index "users", ["area_id"], name: "index_users_on_area_id", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["rol_id"], name: "index_users_on_rol_id", using: :btree
  add_index "users", ["state_id"], name: "index_users_on_state_id", using: :btree
  add_index "users", ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree

  create_table "visits", force: :cascade do |t|
    t.text     "descripcion"
    t.datetime "fecha"
    t.integer  "person_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.decimal  "latitud"
    t.decimal  "longitud"
    t.integer  "state_id"
    t.string   "direccion"
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
  add_foreign_key "auditorias", "users"
  add_foreign_key "departamentos", "states"
  add_foreign_key "estados", "states"
  add_foreign_key "familias", "ranchadas"
  add_foreign_key "familias", "states"
  add_foreign_key "familias", "zones"
  add_foreign_key "notificacion_roles", "notificaciones"
  add_foreign_key "notificacion_roles", "roles"
  add_foreign_key "notificaciones", "frecuencia_tipos"
  add_foreign_key "notificaciones", "notificacion_tipos"
  add_foreign_key "notificaciones", "states"
  add_foreign_key "pedidos", "people"
  add_foreign_key "pedidos", "states"
  add_foreign_key "people", "estados"
  add_foreign_key "people", "familias"
  add_foreign_key "people", "ranchadas"
  add_foreign_key "people", "states"
  add_foreign_key "people", "zones"
  add_foreign_key "ranchadas", "states"
  add_foreign_key "ranchadas", "zones"
  add_foreign_key "referentes", "areas"
  add_foreign_key "referentes", "states"
  add_foreign_key "users", "areas"
  add_foreign_key "users", "roles"
  add_foreign_key "users", "states"
  add_foreign_key "visits", "people"
  add_foreign_key "visits", "states"
  add_foreign_key "welcome_messages", "people"
  add_foreign_key "zones", "areas"
  add_foreign_key "zones", "states"
end
