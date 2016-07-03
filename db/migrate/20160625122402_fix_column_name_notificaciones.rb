class FixColumnNameNotificaciones < ActiveRecord::Migration
  def change
		rename_column :notificaciones, :proxEnvio, :prox_envio
  end
end
