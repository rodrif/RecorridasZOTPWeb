class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :latitud
      t.string :longitud
 
      t.timestamps null: false
    end
  end
end
