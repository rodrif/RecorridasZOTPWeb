class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :latitud
      t.string :longitud
      t.datetime :fecha
      t.references :person, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
