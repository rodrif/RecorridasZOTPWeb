class AddFinalizadaAndProxEnvioToNotificacion < ActiveRecord::Migration
  def change
    add_column :notificaciones, :proxEnvio, :datetime
    add_column :notificaciones, :finalizada, :boolean
  end
end
