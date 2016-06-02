class RemoveRolIdFromNotificacionres < ActiveRecord::Migration
  def change
    remove_column :notificaciones, :rol_id, :integer
  end
end
