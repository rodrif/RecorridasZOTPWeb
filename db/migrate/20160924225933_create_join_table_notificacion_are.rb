class CreateJoinTableNotificacionAre < ActiveRecord::Migration
  def change
    create_join_table :notificaciones, :areas do |t|
      # t.index [:notificacion_id, :area_id]
      # t.index [:area_id, :notificacion_id]
    end
  end
end
