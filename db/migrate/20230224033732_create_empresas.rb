class CreateEmpresas < ActiveRecord::Migration[6.0]
  def change
    create_table :empresas do |t|
      t.integer :codigo_empresa
      t.string :nombre, limit: 200
      t.string :codigo_hex
      t.string :descripcion
      t.integer :user_created_id
      t.integer :user_updated_id
      t.string :estado, limit: 10

      t.timestamps
    end
  end
end
