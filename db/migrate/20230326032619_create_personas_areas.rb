class CreatePersonasAreas < ActiveRecord::Migration[6.0]
  def change
    create_table :personas_areas do |t|
      t.string :descripcion
      t.integer :user_created_id
      t.integer :user_updated_id
      t.string :estado, limit: 10
      t.references :persona, null: false, foreign_key: true
      t.references :area, null: false, foreign_key: true

      t.timestamps
    end
  end
end
