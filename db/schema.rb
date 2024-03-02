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

ActiveRecord::Schema.define(version: 2024_03_01_155739) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

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

  create_table "areas", force: :cascade do |t|
    t.integer "codigo_area"
    t.string "nombre", limit: 200
    t.string "codigo_hex"
    t.string "descripcion"
    t.integer "user_created_id"
    t.integer "user_updated_id"
    t.string "estado", limit: 10
    t.bigint "empresa_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["empresa_id"], name: "index_areas_on_empresa_id"
  end

  create_table "atributos", force: :cascade do |t|
    t.string "nombre", limit: 200
    t.string "descripcion"
    t.integer "user_created_id"
    t.integer "user_updated_id"
    t.string "estado", limit: 10
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "codigo_colores", force: :cascade do |t|
    t.string "disenio", limit: 50
    t.string "nombre_color", limit: 100
    t.string "colores", limit: 25
    t.string "codigo_hex", limit: 25
    t.string "codigo_rgb", limit: 50
    t.string "codigo_hls", limit: 50
    t.integer "user_created_id"
    t.integer "user_updated_id"
    t.string "estado", limit: 10
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "componentes", force: :cascade do |t|
    t.string "nombre", limit: 200
    t.string "descripcion"
    t.integer "user_created_id"
    t.integer "user_updated_id"
    t.string "estado", limit: 10
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "credenciales_usuarios", force: :cascade do |t|
    t.integer "empresa_id"
    t.string "nombre_empresa"
    t.integer "area_id"
    t.string "nombre_area"
    t.integer "persona_id"
    t.string "nombre_usuario"
    t.integer "user_id"
    t.string "correo_electronico"
    t.string "password_temporal"
    t.string "actualizo_password"
    t.string "enviar_correo"
    t.string "enviar_telegram"
    t.string "estado_envio_correo"
    t.string "estado_envio_telegram"
    t.integer "user_created_id"
    t.integer "user_updated_id"
    t.string "estado", limit: 10
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "empresas", force: :cascade do |t|
    t.integer "codigo_empresa"
    t.string "nombre", limit: 200
    t.string "codigo_hex"
    t.string "descripcion"
    t.integer "user_created_id"
    t.integer "user_updated_id"
    t.string "estado", limit: 10
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "font_awesomes", force: :cascade do |t|
    t.string "icono", limit: 50
    t.string "prefijo_nombre", limit: 150
    t.string "termino"
    t.string "codigo_css", limit: 25
    t.string "tipo_icono", limit: 50
    t.integer "user_created_id"
    t.integer "user_updated_id"
    t.string "estado", limit: 10
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "menu_roles", force: :cascade do |t|
    t.integer "menu_id"
    t.string "descripcion"
    t.integer "user_created_id"
    t.integer "user_updated_id"
    t.string "estado", limit: 10
    t.bigint "opcion_id", null: false
    t.bigint "rol_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["opcion_id"], name: "index_menu_roles_on_opcion_id"
    t.index ["rol_id"], name: "index_menu_roles_on_rol_id"
  end

  create_table "menus", force: :cascade do |t|
    t.string "nombre", limit: 200
    t.string "descripcion"
    t.string "icono", limit: 50
    t.string "codigo_hex"
    t.integer "user_created_id"
    t.integer "user_updated_id"
    t.string "estado", limit: 10
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "old_passwords", force: :cascade do |t|
    t.string "encrypted_password", null: false
    t.string "password_archivable_type"
    t.bigint "password_archivable_id"
    t.datetime "created_at"
    t.index ["password_archivable_type", "password_archivable_id"], name: "idx_old_passwords"
  end

  create_table "opcion_cas", force: :cascade do |t|
    t.string "descripcion"
    t.integer "user_created_id"
    t.integer "user_updated_id"
    t.string "estado", limit: 10
    t.bigint "opcion_id", null: false
    t.bigint "componente_id", null: false
    t.bigint "atributo_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["atributo_id"], name: "index_opcion_cas_on_atributo_id"
    t.index ["componente_id"], name: "index_opcion_cas_on_componente_id"
    t.index ["opcion_id"], name: "index_opcion_cas_on_opcion_id"
  end

  create_table "opciones", force: :cascade do |t|
    t.string "nombre", limit: 200
    t.string "descripcion"
    t.string "icono", limit: 50
    t.string "path"
    t.string "controlador", limit: 300
    t.string "codigo_hex"
    t.integer "user_created_id"
    t.integer "user_updated_id"
    t.string "estado", limit: 10
    t.string "aplica_carga_masiva", limit: 10
    t.bigint "menu_id", null: false
    t.integer "posicion"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["menu_id"], name: "index_opciones_on_menu_id"
  end

  create_table "parametros", force: :cascade do |t|
    t.integer "area_id"
    t.string "nombre_area"
    t.integer "empresa_id"
    t.string "nombre_empresa"
    t.string "ruta_predeterminada"
    t.string "view_default"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_parametros_on_user_id"
  end

  create_table "persona_empresa_formularios", force: :cascade do |t|
    t.string "descripcion"
    t.integer "user_created_id"
    t.integer "user_updated_id"
    t.string "estado", limit: 10
    t.bigint "personas_area_id", null: false
    t.bigint "opcion_ca_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["opcion_ca_id"], name: "index_persona_empresa_formularios_on_opcion_ca_id"
    t.index ["personas_area_id"], name: "index_persona_empresa_formularios_on_personas_area_id"
  end

  create_table "personas", force: :cascade do |t|
    t.string "nombre", limit: 200
    t.string "apellido", limit: 200
    t.text "foto"
    t.integer "telefono"
    t.integer "chat_id_telegram"
    t.string "direccion"
    t.string "token", limit: 1000
    t.integer "user_created_id"
    t.integer "user_updated_id"
    t.string "estado", limit: 10
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_personas_on_user_id"
  end

  create_table "personas_areas", force: :cascade do |t|
    t.string "descripcion"
    t.integer "user_created_id"
    t.integer "user_updated_id"
    t.string "estado", limit: 10
    t.integer "rol_id"
    t.bigint "persona_id", null: false
    t.bigint "area_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["area_id"], name: "index_personas_areas_on_area_id"
    t.index ["persona_id"], name: "index_personas_areas_on_persona_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "nombre", limit: 200
    t.string "descripcion"
    t.string "codigo_hex"
    t.integer "user_created_id"
    t.integer "user_updated_id"
    t.string "estado", limit: 10
    t.string "slug"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["slug"], name: "index_roles_on_slug"
  end

  create_table "sessions", force: :cascade do |t|
    t.string "session_id", null: false
    t.text "data"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "user_created_id"
    t.integer "user_updated_id"
    t.string "estado"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.boolean "password_changed", default: false
    t.datetime "password_changed_at"
    t.string "encrypted_otp_secret"
    t.string "encrypted_otp_secret_iv"
    t.string "encrypted_otp_secret_salt"
    t.integer "consumed_timestep"
    t.boolean "otp_required_for_login"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "areas", "empresas"
  add_foreign_key "menu_roles", "opciones"
  add_foreign_key "menu_roles", "roles"
  add_foreign_key "opcion_cas", "atributos"
  add_foreign_key "opcion_cas", "componentes"
  add_foreign_key "opcion_cas", "opciones"
  add_foreign_key "opciones", "menus"
  add_foreign_key "parametros", "users"
  add_foreign_key "persona_empresa_formularios", "opcion_cas"
  add_foreign_key "persona_empresa_formularios", "personas_areas"
  add_foreign_key "personas", "users"
  add_foreign_key "personas_areas", "areas"
  add_foreign_key "personas_areas", "personas"

  create_view "areas_views", sql_definition: <<-SQL
      SELECT areas.id,
      areas.codigo_area,
      areas.nombre,
      areas.codigo_hex,
      areas.descripcion,
      areas.user_created_id,
      areas.user_updated_id,
      areas.estado,
      areas.empresa_id,
      areas.created_at,
      areas.updated_at,
      empresas.codigo_empresa,
      empresas.nombre AS nombre_empresa,
      ((empresas.codigo_empresa || ': '::text) || (empresas.nombre)::text) AS codigo_nombre_empresa,
      empresas.codigo_hex AS codigo_hex_empresa
     FROM (areas
       JOIN empresas ON ((areas.empresa_id = empresas.id)));
  SQL
  create_view "opciones_views", sql_definition: <<-SQL
      SELECT opciones.id,
      opciones.nombre,
      opciones.descripcion,
      opciones.icono,
      opciones.path,
      opciones.controlador,
      opciones.codigo_hex,
      opciones.user_created_id,
      opciones.user_updated_id,
      opciones.estado,
      opciones.aplica_carga_masiva,
      opciones.menu_id,
      opciones.posicion,
      opciones.created_at,
      opciones.updated_at,
      menus.nombre AS nombre_menu,
      menus.icono AS icono_menu,
      menus.codigo_hex AS codigo_hex_menu
     FROM (opciones
       JOIN menus ON ((opciones.menu_id = menus.id)));
  SQL
  create_view "menu_roles_views", sql_definition: <<-SQL
      SELECT menu_roles.id,
      menu_roles.menu_id,
      menu_roles.descripcion,
      menu_roles.user_created_id,
      menu_roles.user_updated_id,
      menu_roles.estado,
      menu_roles.opcion_id,
      menu_roles.rol_id,
      menu_roles.created_at,
      menu_roles.updated_at,
      opciones.nombre AS nombre_opcion,
      opciones.icono AS icono_opcion,
      opciones.path AS path_opcion,
      opciones.controlador AS controlador_opcion,
      opciones.codigo_hex AS codigo_hex_opcion,
      roles.nombre AS nombre_rol,
      roles.codigo_hex AS codigo_hex_rol,
      menus.id AS menu_codigo,
      menus.nombre AS nombre_menu,
      menus.icono AS icono_menu,
      menus.codigo_hex AS codigo_hex_menu
     FROM (((menu_roles
       JOIN opciones ON ((menu_roles.opcion_id = opciones.id)))
       JOIN roles ON ((menu_roles.rol_id = roles.id)))
       JOIN menus ON ((opciones.menu_id = menus.id)));
  SQL
  create_view "opcion_cas_views", sql_definition: <<-SQL
      SELECT opcion_cas.id,
      opcion_cas.descripcion,
      opcion_cas.user_created_id,
      opcion_cas.user_updated_id,
      opcion_cas.estado,
      opcion_cas.opcion_id,
      opcion_cas.componente_id,
      opcion_cas.atributo_id,
      opcion_cas.created_at,
      opcion_cas.updated_at,
      opciones.menu_id,
      menus.nombre AS nombre_menu,
      menus.icono AS icono_menu,
      menus.codigo_hex AS codigo_hex_menu,
      opciones.nombre AS nombre_opcion,
      opciones.icono AS icono_opcion,
      opciones.codigo_hex AS codigo_hex_opcion,
      opciones.path AS path_opcion,
      opciones.controlador AS controlador_opcion,
      componentes.nombre AS nombre_componente,
      atributos.nombre AS nombre_atributo
     FROM ((((opcion_cas
       JOIN opciones ON ((opcion_cas.opcion_id = opciones.id)))
       JOIN componentes ON ((opcion_cas.componente_id = componentes.id)))
       JOIN atributos ON ((opcion_cas.atributo_id = atributos.id)))
       JOIN menus ON ((opciones.menu_id = menus.id)));
  SQL
  create_view "personas_areas_views", sql_definition: <<-SQL
      SELECT personas_areas.id,
      personas_areas.descripcion,
      personas_areas.user_created_id,
      personas_areas.user_updated_id,
      personas_areas.estado,
      personas_areas.rol_id,
      personas_areas.persona_id,
      personas_areas.area_id,
      personas_areas.created_at,
      personas_areas.updated_at,
      (((personas.nombre)::text || ' '::text) || (personas.apellido)::text) AS nombre_usuario,
      personas.telefono AS telefono_usuario,
      personas.user_id,
      users.email AS email_usuario,
      areas.codigo_area,
      areas.nombre AS nombre_area,
      areas.codigo_hex AS codigo_hex_area,
      areas.empresa_id,
      empresas.codigo_empresa,
      empresas.nombre AS nombre_empresa,
      roles.nombre AS nombre_rol,
      roles.codigo_hex AS codigo_hex_rol
     FROM (((((personas_areas
       JOIN personas ON ((personas_areas.persona_id = personas.id)))
       JOIN users ON ((personas.user_id = users.id)))
       JOIN areas ON ((personas_areas.area_id = areas.id)))
       JOIN empresas ON ((areas.empresa_id = empresas.id)))
       LEFT JOIN roles ON ((personas_areas.rol_id = roles.id)));
  SQL
  create_view "persona_empresa_formularios_views", sql_definition: <<-SQL
      SELECT persona_empresa_formularios.id,
      persona_empresa_formularios.personas_area_id,
      persona_empresa_formularios.opcion_ca_id,
      persona_empresa_formularios.descripcion,
      persona_empresa_formularios.estado,
      personas_areas_views.empresa_id,
      personas_areas_views.codigo_empresa,
      personas_areas_views.nombre_empresa,
      personas_areas_views.area_id,
      personas_areas_views.codigo_area,
      personas_areas_views.codigo_hex_area,
      personas_areas_views.nombre_area,
      personas_areas_views.user_id,
      personas_areas_views.persona_id,
      personas_areas_views.nombre_usuario,
      personas_areas_views.email_usuario,
      personas_areas_views.rol_id,
      personas_areas_views.nombre_rol,
      personas_areas_views.codigo_hex_rol,
      opcion_cas_views.menu_id,
      opcion_cas_views.nombre_menu,
      opcion_cas_views.codigo_hex_menu,
      opcion_cas_views.path_opcion,
      opcion_cas_views.controlador_opcion,
      opcion_cas_views.opcion_id,
      opcion_cas_views.nombre_opcion,
      opcion_cas_views.codigo_hex_opcion,
      opcion_cas_views.componente_id,
      opcion_cas_views.nombre_componente,
      opcion_cas_views.atributo_id,
      opcion_cas_views.nombre_atributo
     FROM ((persona_empresa_formularios
       JOIN personas_areas_views ON ((persona_empresa_formularios.personas_area_id = personas_areas_views.id)))
       JOIN opcion_cas_views ON ((persona_empresa_formularios.opcion_ca_id = opcion_cas_views.id)));
  SQL
end
