class RemoveAlerts < ActiveRecord::Migration[6.0]
  def change
    drop_table :alerts
    drop_table :alert_types
  end
end
