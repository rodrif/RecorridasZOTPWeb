class CreateNotificacionTipos < ActiveRecord::Migration
  def change
    create_table :notificacion_tipos do |t|
      t.string :nombre

      t.timestamps null: false
    end
  end
end
