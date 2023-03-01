class CreateAtributos < ActiveRecord::Migration[6.0]
  def change
    create_table :atributos do |t|
      t.string :nombre, limit: 200
      t.string :descripcion
      t.integer :user_created_id
      t.integer :user_updated_id
      t.string :estado, limit: 10

      t.timestamps
    end
  end
end
