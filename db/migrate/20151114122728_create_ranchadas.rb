class CreateRanchadas < ActiveRecord::Migration
  def change
    create_table :ranchadas do |t|
      t.string :nombre
      t.references :area, index: true, foreign_key: true
      t.references :zone, index: true, foreign_key: true
      t.text :descripcion
      t.decimal :latitud
      t.decimal :longitud

      t.timestamps null: false
    end
  end
end
