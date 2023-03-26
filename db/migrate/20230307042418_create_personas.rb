class CreatePersonas < ActiveRecord::Migration[6.0]
  def change
    create_table :personas do |t|
      t.string :nombre, limit: 200
      t.string :apellido, limit: 200
      t.string :foto
      t.integer :telefono
      t.string :direccion
      t.string :token, limit: 1000
      t.integer :user_created_id
      t.integer :user_updated_id
      t.string :estado, limit: 10
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
