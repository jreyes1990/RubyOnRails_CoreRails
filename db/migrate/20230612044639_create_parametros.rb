class CreateParametros < ActiveRecord::Migration[6.0]
  def change
    create_table :parametros do |t|
      t.integer :area_id
      t.string :nombre_area
      t.integer :empresa_id
      t.string :nombre_empresa
      t.string :ruta_predeterminada
      t.string :view_default
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
