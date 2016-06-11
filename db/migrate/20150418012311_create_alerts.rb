class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|
      t.string :mensaje
      t.datetime :fecha
      t.references :zone, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
