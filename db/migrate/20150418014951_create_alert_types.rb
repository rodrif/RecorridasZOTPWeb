class CreateAlertTypes < ActiveRecord::Migration
  def change
    create_table :alert_types do |t|
      t.string :nombre

      t.timestamps null: false
    end
  end
end
