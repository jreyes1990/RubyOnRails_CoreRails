class CreateCredencialesUsuarios < ActiveRecord::Migration[6.0]
  def change
    create_table :credenciales_usuarios do |t|
      t.integer :empresa_id
      t.string :nombre_empresa
      t.integer :area_id
      t.string :nombre_area
      t.integer :persona_id
      t.string :nombre_usuario
      t.integer :user_id
      t.string :correo_electronico
      t.string :password_temporal
      t.string :actualizo_password
      t.string :enviar_correo
      t.string :enviar_telegram
      t.string :estado_envio_correo
      t.string :estado_envio_telegram
      t.integer :user_created_id
      t.integer :user_updated_id
      t.string :estado, limit: 10

      t.timestamps
    end
  end
end
