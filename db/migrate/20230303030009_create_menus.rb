class CreateMenus < ActiveRecord::Migration[6.0]
  def change
    create_table :menus do |t|
      t.string :nombre, limit: 200
      t.string :descripcion
      t.string :icono, limit: 50
      t.string :codigo_hex
      t.integer :user_created_id
      t.integer :user_updated_id
      t.string :estado, limit: 10

      t.timestamps
    end
  end
end
