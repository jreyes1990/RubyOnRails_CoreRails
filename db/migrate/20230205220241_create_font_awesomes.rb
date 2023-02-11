class CreateFontAwesomes < ActiveRecord::Migration[6.0]
  def change
    create_table :font_awesomes do |t|
      t.string :icono, limit: 50
      t.string :prefijo_nombre, limit: 150
      t.string :termino
      t.string :codigo_css, limit: 25
      t.string :tipo_icono, limit: 50
      t.integer :user_created_id
      t.integer :user_updated_id
      t.string :estado, limit: 10

      t.timestamps
    end
  end
end
