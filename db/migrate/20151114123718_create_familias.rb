class CreateFamilias < ActiveRecord::Migration
  def change
    create_table :familias do |t|
      t.string :nombre
      t.references :area, index: true, foreign_key: true
      t.references :zone, index: true, foreign_key: true
      t.references :ranchada, index: true, foreign_key: true
      t.text :descripcion

      t.timestamps null: false
    end
  end
end
