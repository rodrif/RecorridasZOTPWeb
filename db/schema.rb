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

ActiveRecord::Schema.define(version: 2020_12_18_172249) do

  create_table "areas", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "state_id"
    t.index ["state_id"], name: "index_areas_on_state_id"
  end

  create_table "areas_notificaciones", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "notificacion_id", null: false
    t.integer "area_id", null: false
  end

  create_table "auditorias", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "fecha"
    t.string "email"
    t.string "accion"
    t.string "entidad"
    t.integer "entity_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "descripcion"
    t.bigint "user_id"
    t.index ["user_id"], name: "index_auditorias_on_user_id"
  end

  create_table "delayed_jobs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "departamentos", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "nombre"
    t.bigint "state_id"
    t.index ["state_id"], name: "index_departamentos_on_state_id"
  end

  create_table "departamentos_people", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "departamento_id", null: false
    t.integer "person_id", null: false
  end

  create_table "estados", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "nombre"
    t.bigint "state_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["state_id"], name: "index_estados_on_state_id"
  end

  create_table "eventos", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "titulo"
    t.string "descripcion"
    t.datetime "fecha_desde"
    t.datetime "fecha_hasta"
    t.string "ubicacion"
    t.bigint "person_id"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "latitud", precision: 10
    t.decimal "longitud", precision: 10
    t.index ["person_id"], name: "index_eventos_on_person_id"
    t.index ["user_id"], name: "index_eventos_on_user_id"
  end

  create_table "events", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title"
    t.datetime "start"
    t.datetime "end"
    t.string "color"
    t.string "description"
    t.string "location"
    t.bigint "person_id"
    t.bigint "user_id"
    t.index ["person_id"], name: "index_events_on_person_id"
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "frecuencia_tipos", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "code"
  end

  create_table "institucion_tipos", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "instituciones", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "nombre"
    t.text "descripcion"
    t.string "direccion"
    t.string "contacto"
    t.string "telefono"
    t.string "codigo_postal"
    t.decimal "latitud", precision: 20, scale: 17
    t.decimal "longitud", precision: 20, scale: 17
    t.bigint "state_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "institucion_tipo_id"
    t.index ["institucion_tipo_id"], name: "index_instituciones_on_institucion_tipo_id"
    t.index ["state_id"], name: "index_instituciones_on_state_id"
  end

  create_table "jornadas", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "jornadas_users", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "jornada_id", null: false
  end

  create_table "notificacion_roles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "notificacion_id"
    t.integer "rol_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["notificacion_id"], name: "index_notificacion_roles_on_notificacion_id"
    t.index ["rol_id"], name: "index_notificacion_roles_on_rol_id"
  end

  create_table "notificaciones", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "titulo"
    t.string "subtitulo"
    t.datetime "fecha_desde"
    t.datetime "fecha_hasta"
    t.text "descripcion"
    t.integer "frecuencia_cant"
    t.bigint "frecuencia_tipo_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "state_id"
    t.datetime "prox_envio"
    t.boolean "finalizada"
    t.bigint "evento_id"
    t.index ["evento_id"], name: "index_notificaciones_on_evento_id"
    t.index ["frecuencia_tipo_id"], name: "index_notificaciones_on_frecuencia_tipo_id"
    t.index ["state_id"], name: "index_notificaciones_on_state_id"
  end

  create_table "pedidos", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "fecha"
    t.string "descripcion"
    t.bigint "person_id"
    t.boolean "completado"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "state_id"
    t.index ["person_id"], name: "index_pedidos_on_person_id"
    t.index ["state_id"], name: "index_pedidos_on_state_id"
  end

  create_table "people", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "nombre"
    t.string "apellido"
    t.bigint "zone_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "state_id"
    t.string "dni"
    t.date "fecha_nacimiento"
    t.string "telefono"
    t.text "descripcion"
    t.string "pantalon"
    t.string "remera"
    t.string "zapatillas"
    t.bigint "estado_id"
    t.bigint "institucion_id"
    t.index ["estado_id"], name: "index_people_on_estado_id"
    t.index ["institucion_id"], name: "index_people_on_institucion_id"
    t.index ["state_id"], name: "index_people_on_state_id"
    t.index ["zone_id"], name: "index_people_on_zone_id"
  end

  create_table "roles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "nombre"
    t.boolean "puede_crear_persona"
    t.boolean "puede_editar_persona"
    t.boolean "puede_borrar_persona"
    t.boolean "puede_ver_telefono_persona"
    t.boolean "puede_ver_web"
    t.boolean "puede_crear_visita"
    t.boolean "puede_editar_visita"
    t.boolean "puede_borrar_visita"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "code"
  end

  create_table "states", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider", default: "email", null: false
    t.string "uid", default: ""
    t.string "name"
    t.string "nickname"
    t.string "image"
    t.text "tokens"
    t.bigint "rol_id"
    t.string "apellido"
    t.bigint "area_id"
    t.bigint "state_id"
    t.string "dia"
    t.date "fecha_nacimiento"
    t.string "telefono"
    t.integer "version"
    t.index ["area_id"], name: "index_users_on_area_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["rol_id"], name: "index_users_on_rol_id"
    t.index ["state_id"], name: "index_users_on_state_id"
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  create_table "visits", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.text "descripcion"
    t.datetime "fecha"
    t.bigint "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "latitud", precision: 20, scale: 17
    t.decimal "longitud", precision: 20, scale: 17
    t.bigint "state_id"
    t.string "direccion"
    t.index ["person_id"], name: "index_visits_on_person_id"
    t.index ["state_id"], name: "index_visits_on_state_id"
  end

  create_table "zones", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "area_id"
    t.decimal "latitud", precision: 20, scale: 17
    t.decimal "longitud", precision: 20, scale: 17
    t.bigint "state_id"
    t.index ["area_id"], name: "index_zones_on_area_id"
    t.index ["state_id"], name: "index_zones_on_state_id"
  end

  add_foreign_key "areas", "states"
  add_foreign_key "auditorias", "users"
  add_foreign_key "departamentos", "states"
  add_foreign_key "estados", "states"
  add_foreign_key "eventos", "people"
  add_foreign_key "eventos", "users"
  add_foreign_key "events", "people"
  add_foreign_key "events", "users"
  add_foreign_key "instituciones", "institucion_tipos"
  add_foreign_key "instituciones", "states"
  add_foreign_key "notificaciones", "eventos"
  add_foreign_key "notificaciones", "frecuencia_tipos"
  add_foreign_key "notificaciones", "states"
  add_foreign_key "pedidos", "people"
  add_foreign_key "pedidos", "states"
  add_foreign_key "people", "estados"
  add_foreign_key "people", "instituciones"
  add_foreign_key "people", "states"
  add_foreign_key "people", "zones"
  add_foreign_key "users", "areas"
  add_foreign_key "users", "roles"
  add_foreign_key "users", "states"
  add_foreign_key "visits", "people"
  add_foreign_key "visits", "states"
  add_foreign_key "zones", "areas"
  add_foreign_key "zones", "states"
end
