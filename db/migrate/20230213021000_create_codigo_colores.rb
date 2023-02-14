class CreateCodigoColores < ActiveRecord::Migration[6.0]
  def change
    create_table :codigo_colores do |t|
      t.string :disenio, limit: 50
      t.string :nombre_color, limit: 100
      t.string :colores, limit: 25
      t.string :codigo_hex, limit: 25
      t.string :codigo_rgb, limit: 50
      t.string :codigo_hls, limit: 50
      t.integer :user_created_id
      t.integer :user_updated_id
      t.string :estado, limit: 10

      t.timestamps
    end
  end
end
