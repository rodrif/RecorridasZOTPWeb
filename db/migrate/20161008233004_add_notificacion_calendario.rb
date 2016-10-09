class AddNotificacionCalendario < ActiveRecord::Migration
  def change
  	NotificacionTipo.create!([{ id: 4, nombre: 'Calendario', code: 4 }])
  end
end
