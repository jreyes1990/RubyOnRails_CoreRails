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

ActiveRecord::Schema.define(version: 2023_03_06_000442) do

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
    t.string "colores", limit: 15
    t.string "codigo_hex", limit: 15
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

  create_table "empresas", force: :cascade do |t|
    t.integer "codigo_empresa"
    t.string "nombre", limit: 200
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
    t.bigint "menu_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["menu_id"], name: "index_opciones_on_menu_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "nombre", limit: 200
    t.string "descripcion"
    t.string "codigo_hex"
    t.integer "user_created_id"
    t.integer "user_updated_id"
    t.string "estado", limit: 10
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "areas", "empresas"
  add_foreign_key "menu_roles", "opciones"
  add_foreign_key "menu_roles", "roles"
  add_foreign_key "opciones", "menus"

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
      ((empresas.codigo_empresa || ': '::text) || (empresas.nombre)::text) AS codigo_nombre_empresa
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
      opciones.menu_id,
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
end
