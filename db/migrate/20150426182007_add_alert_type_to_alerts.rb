class AddAlertTypeToAlerts < ActiveRecord::Migration
  def change
    add_reference :alerts, :alert_type, index: true, foreign_key: true
  end
end
