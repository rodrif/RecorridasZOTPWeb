class AddUbicacionToZone < ActiveRecord::Migration
  def change
    add_column :zones, :latitud, :float
    add_column :zones, :longitud, :float
  end
end
