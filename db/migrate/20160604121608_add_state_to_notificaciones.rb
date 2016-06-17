class AddStateToNotificaciones < ActiveRecord::Migration
  def change
    add_reference :notificaciones, :state, index: true, foreign_key: true
  end
end
