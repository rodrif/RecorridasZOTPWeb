class CreateNotificacionRoles < ActiveRecord::Migration
  def change
    create_table :notificacion_roles do |t|
      t.references :notificacion, index: true, foreign_key: true
      t.references :rol, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
