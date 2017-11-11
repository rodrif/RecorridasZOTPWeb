class CreateInstituciones < ActiveRecord::Migration
  def change
    create_table :instituciones do |t|
      t.string :nombre
      t.text :descripcion
      t.string :direccion
      t.string :localidad
      t.string :provincia
      t.string :codigo_postal
      t.decimal :latitud, precision: 20, scale: 17
      t.decimal :longitud, precision: 20, scale: 17
      t.references :state, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
