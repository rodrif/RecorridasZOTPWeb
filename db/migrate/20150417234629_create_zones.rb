class CreateZones < ActiveRecord::Migration
  def change
    create_table :zones do |t|
      t.string :nombre

      t.timestamps null: false
    end
  end
end
