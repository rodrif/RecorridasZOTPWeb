class AddLatitudLongitudToEventos < ActiveRecord::Migration[6.0]
  def change
    add_column :eventos, :latitud, :decimal
    add_column :eventos, :longitud, :decimal
  end
end
