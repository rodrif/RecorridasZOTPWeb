class CreateEventos < ActiveRecord::Migration[6.0]
  def change
    create_table :eventos do |t|
      t.string :titulo
      t.string :descripcion
      t.datetime :fecha_desde
      t.datetime :fecha_hasta
      t.string :ubicacion
      t.references :person, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
