class AddDniAndFechaNacimientoToPeople < ActiveRecord::Migration
  def change
    add_column :people, :dni, :integer
    add_column :people, :fecha_nacimiento, :date
  end
end
