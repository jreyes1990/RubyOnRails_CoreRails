json.extract! opcion, :id, :nombre, :descripcion, :icono, :path, :controlador, :codigo_hex, :user_created_id, :user_updated_id, :estado, :menu_id, :created_at, :updated_at
json.url opcion_url(opcion, format: :json)
