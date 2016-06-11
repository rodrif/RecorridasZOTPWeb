class CreateNotificaciones < ActiveRecord::Migration
  def change
    create_table :notificaciones do |t|
      t.string :titulo
      t.string :subtitulo
      t.datetime :fecha_desde
      t.datetime :fecha_hasta
      t.references :notificacion_tipo, index: true, foreign_key: true
      t.text :descripcion
      t.integer :frecuencia_cant
      t.references :frecuencia_tipo, index: true, foreign_key: true
      t.references :rol, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
