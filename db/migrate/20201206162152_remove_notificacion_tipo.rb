class RemoveNotificacionTipo < ActiveRecord::Migration
  def change
    remove_reference :notificaciones, :notificacion_tipo, index: true, foreign_key: true
    drop_table :notificacion_tipos
  end
end
