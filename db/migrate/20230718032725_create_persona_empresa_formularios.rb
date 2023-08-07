class CreatePersonaEmpresaFormularios < ActiveRecord::Migration[6.0]
  def change
    create_table :persona_empresa_formularios do |t|
      t.string :descripcion
      t.integer :user_created_id
      t.integer :user_updated_id
      t.string :estado, limit: 10
      t.references :personas_area, null: false, foreign_key: true
      t.references :opcion_ca, null: false, foreign_key: true

      t.timestamps
    end
  end
end
