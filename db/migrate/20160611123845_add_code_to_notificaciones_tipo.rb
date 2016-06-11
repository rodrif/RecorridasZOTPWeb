class AddCodeToNotificacionesTipo < ActiveRecord::Migration
  def change
    add_column :notificacion_tipos, :code, :integer
  end
end
