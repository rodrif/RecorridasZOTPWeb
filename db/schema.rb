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

ActiveRecord::Schema.define(version: 20201201005935) do

  create_table "areas", force: :cascade do |t|
    t.string   "nombre",     limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "state_id",   limit: 4
  end

  add_index "areas", ["state_id"], name: "index_areas_on_state_id", using: :btree

  create_table "areas_notificaciones", id: false, force: :cascade do |t|
    t.integer "notificacion_id", limit: 4, null: false
    t.integer "area_id",         limit: 4, null: false
  end

  create_table "auditorias", force: :cascade do |t|
    t.datetime "fecha"
    t.string   "email",       limit: 255
    t.string   "accion",      limit: 255
    t.string   "entidad",     limit: 255
    t.integer  "entity_id",   limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.text     "descripcion", limit: 65535
    t.integer  "user_id",     limit: 4
  end

  add_index "auditorias", ["user_id"], name: "index_auditorias_on_user_id", using: :btree

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   limit: 4,     default: 0, null: false
    t.integer  "attempts",   limit: 4,     default: 0, null: false
    t.text     "handler",    limit: 65535,             null: false
    t.text     "last_error", limit: 65535
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.string   "queue",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "departamentos", force: :cascade do |t|
    t.string  "nombre",   limit: 255
    t.integer "state_id", limit: 4
  end

  add_index "departamentos", ["state_id"], name: "index_departamentos_on_state_id", using: :btree

  create_table "departamentos_people", id: false, force: :cascade do |t|
    t.integer "departamento_id", limit: 4, null: false
    t.integer "person_id",       limit: 4, null: false
  end

  create_table "estados", force: :cascade do |t|
    t.string   "nombre",     limit: 255
    t.integer  "state_id",   limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "estados", ["state_id"], name: "index_estados_on_state_id", using: :btree

  create_table "eventos", force: :cascade do |t|
    t.string   "titulo",      limit: 255
    t.string   "descripcion", limit: 255
    t.datetime "fecha_desde"
    t.datetime "fecha_hasta"
    t.string   "ubicacion",   limit: 255
    t.integer  "person_id",   limit: 4
    t.integer  "user_id",     limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "eventos", ["person_id"], name: "index_eventos_on_person_id", using: :btree
  add_index "eventos", ["user_id"], name: "index_eventos_on_user_id", using: :btree

  create_table "frecuencia_tipos", force: :cascade do |t|
    t.string   "nombre",     limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "code",       limit: 4
  end

  create_table "institucion_tipos", force: :cascade do |t|
    t.string   "nombre",     limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "instituciones", force: :cascade do |t|
    t.string   "nombre",              limit: 255
    t.text     "descripcion",         limit: 65535
    t.string   "direccion",           limit: 255
    t.string   "contacto",            limit: 255
    t.string   "telefono",            limit: 255
    t.string   "codigo_postal",       limit: 255
    t.decimal  "latitud",                           precision: 20, scale: 17
    t.decimal  "longitud",                          precision: 20, scale: 17
    t.integer  "state_id",            limit: 4
    t.datetime "created_at",                                                  null: false
    t.datetime "updated_at",                                                  null: false
    t.integer  "institucion_tipo_id", limit: 4
  end

  add_index "instituciones", ["institucion_tipo_id"], name: "index_instituciones_on_institucion_tipo_id", using: :btree
  add_index "instituciones", ["state_id"], name: "index_instituciones_on_state_id", using: :btree

  create_table "jornadas", force: :cascade do |t|
    t.string   "nombre",     limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "jornadas_users", id: false, force: :cascade do |t|
    t.integer "user_id",    limit: 4, null: false
    t.integer "jornada_id", limit: 4, null: false
  end

  create_table "meetings", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "notificacion_roles", force: :cascade do |t|
    t.integer  "notificacion_id", limit: 4
    t.integer  "rol_id",          limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "notificacion_roles", ["notificacion_id"], name: "index_notificacion_roles_on_notificacion_id", using: :btree
  add_index "notificacion_roles", ["rol_id"], name: "index_notificacion_roles_on_rol_id", using: :btree

  create_table "notificacion_tipos", force: :cascade do |t|
    t.string   "nombre",     limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "code",       limit: 4
  end

  create_table "notificaciones", force: :cascade do |t|
    t.string   "titulo",               limit: 255
    t.string   "subtitulo",            limit: 255
    t.datetime "fecha_desde"
    t.datetime "fecha_hasta"
    t.integer  "notificacion_tipo_id", limit: 4
    t.text     "descripcion",          limit: 65535
    t.integer  "frecuencia_cant",      limit: 4
    t.integer  "frecuencia_tipo_id",   limit: 4
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "state_id",             limit: 4
    t.datetime "prox_envio"
    t.boolean  "finalizada",           limit: 1
  end

  add_index "notificaciones", ["frecuencia_tipo_id"], name: "index_notificaciones_on_frecuencia_tipo_id", using: :btree
  add_index "notificaciones", ["notificacion_tipo_id"], name: "index_notificaciones_on_notificacion_tipo_id", using: :btree
  add_index "notificaciones", ["state_id"], name: "index_notificaciones_on_state_id", using: :btree

  create_table "pedidos", force: :cascade do |t|
    t.datetime "fecha"
    t.string   "descripcion", limit: 255
    t.integer  "person_id",   limit: 4
    t.boolean  "completado",  limit: 1
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "state_id",    limit: 4
  end

  add_index "pedidos", ["person_id"], name: "index_pedidos_on_person_id", using: :btree
  add_index "pedidos", ["state_id"], name: "index_pedidos_on_state_id", using: :btree

  create_table "people", force: :cascade do |t|
    t.string   "nombre",           limit: 255
    t.string   "apellido",         limit: 255
    t.integer  "zone_id",          limit: 4
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "state_id",         limit: 4
    t.string   "dni",              limit: 255
    t.date     "fecha_nacimiento"
    t.string   "telefono",         limit: 255
    t.text     "descripcion",      limit: 65535
    t.string   "pantalon",         limit: 255
    t.string   "remera",           limit: 255
    t.string   "zapatillas",       limit: 255
    t.integer  "estado_id",        limit: 4
    t.integer  "institucion_id",   limit: 4
  end

  add_index "people", ["estado_id"], name: "index_people_on_estado_id", using: :btree
  add_index "people", ["institucion_id"], name: "index_people_on_institucion_id", using: :btree
  add_index "people", ["state_id"], name: "index_people_on_state_id", using: :btree
  add_index "people", ["zone_id"], name: "index_people_on_zone_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "nombre",                     limit: 255
    t.boolean  "puede_crear_persona",        limit: 1
    t.boolean  "puede_editar_persona",       limit: 1
    t.boolean  "puede_borrar_persona",       limit: 1
    t.boolean  "puede_ver_telefono_persona", limit: 1
    t.boolean  "puede_ver_web",              limit: 1
    t.boolean  "puede_crear_visita",         limit: 1
    t.boolean  "puede_editar_visita",        limit: 1
    t.boolean  "puede_borrar_visita",        limit: 1
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "code",                       limit: 4
  end

  create_table "states", force: :cascade do |t|
    t.string   "nombre",     limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255,   default: "",      null: false
    t.string   "encrypted_password",     limit: 255,   default: "",      null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,     default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
    t.string   "provider",               limit: 255,   default: "email", null: false
    t.string   "uid",                    limit: 255,   default: ""
    t.string   "name",                   limit: 255
    t.string   "nickname",               limit: 255
    t.string   "image",                  limit: 255
    t.text     "tokens",                 limit: 65535
    t.integer  "rol_id",                 limit: 4
    t.string   "apellido",               limit: 255
    t.integer  "area_id",                limit: 4
    t.integer  "state_id",               limit: 4
    t.string   "dia",                    limit: 255
    t.date     "fecha_nacimiento"
    t.string   "telefono",               limit: 255
    t.integer  "version",                limit: 4
  end

  add_index "users", ["area_id"], name: "index_users_on_area_id", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["rol_id"], name: "index_users_on_rol_id", using: :btree
  add_index "users", ["state_id"], name: "index_users_on_state_id", using: :btree
  add_index "users", ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree

  create_table "visits", force: :cascade do |t|
    t.text     "descripcion", limit: 65535
    t.datetime "fecha"
    t.integer  "person_id",   limit: 4
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
    t.decimal  "latitud",                   precision: 20, scale: 17
    t.decimal  "longitud",                  precision: 20, scale: 17
    t.integer  "state_id",    limit: 4
    t.string   "direccion",   limit: 255
  end

  add_index "visits", ["person_id"], name: "index_visits_on_person_id", using: :btree
  add_index "visits", ["state_id"], name: "index_visits_on_state_id", using: :btree

  create_table "zones", force: :cascade do |t|
    t.string   "nombre",     limit: 255
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.integer  "area_id",    limit: 4
    t.decimal  "latitud",                precision: 20, scale: 17
    t.decimal  "longitud",               precision: 20, scale: 17
    t.integer  "state_id",   limit: 4
  end

  add_index "zones", ["area_id"], name: "index_zones_on_area_id", using: :btree
  add_index "zones", ["state_id"], name: "index_zones_on_state_id", using: :btree

  add_foreign_key "areas", "states"
  add_foreign_key "auditorias", "users"
  add_foreign_key "departamentos", "states"
  add_foreign_key "estados", "states"
  add_foreign_key "eventos", "people"
  add_foreign_key "eventos", "users"
  add_foreign_key "instituciones", "institucion_tipos"
  add_foreign_key "instituciones", "states"
  add_foreign_key "notificaciones", "frecuencia_tipos"
  add_foreign_key "notificaciones", "notificacion_tipos"
  add_foreign_key "notificaciones", "states"
  add_foreign_key "pedidos", "people"
  add_foreign_key "pedidos", "states"
  add_foreign_key "people", "estados"
  add_foreign_key "people", "states"
  add_foreign_key "people", "zones"
  add_foreign_key "users", "areas"
  add_foreign_key "users", "states"
  add_foreign_key "visits", "people"
  add_foreign_key "visits", "states"
  add_foreign_key "zones", "areas"
  add_foreign_key "zones", "states"
end
