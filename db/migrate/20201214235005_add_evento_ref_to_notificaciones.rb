class AddEventoRefToNotificaciones < ActiveRecord::Migration[6.0]
  def change
    add_reference :notificaciones, :evento, foreign_key: true
  end
end
