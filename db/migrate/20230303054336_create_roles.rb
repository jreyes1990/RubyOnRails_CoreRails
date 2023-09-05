class CreateRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :roles do |t|
      t.string :nombre, limit: 200
      t.string :descripcion
      t.string :codigo_hex
      t.integer :user_created_id
      t.integer :user_updated_id
      t.string :estado, limit: 10
      t.string :slug
      t.index :slug

      t.timestamps
    end
  end
end
