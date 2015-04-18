class BorrarRefLocation < ActiveRecord::Migration
  def change
  	add_column :visits, :latitud, :decimal
  	add_column :visits, :longitud, :decimal
  	remove_reference :visits, :location, index: true
  end
end
