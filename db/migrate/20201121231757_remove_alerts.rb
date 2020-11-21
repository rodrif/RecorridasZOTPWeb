class RemoveAlerts < ActiveRecord::Migration
  def change
    drop_table :alerts
    drop_table :alert_types
  end
end
