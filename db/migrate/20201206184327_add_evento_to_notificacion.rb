class AddEventoToNotificacion < ActiveRecord::Migration
  def change
    add_reference :notificaciones, :evento, index: true, foreign_key: true
  end
end
