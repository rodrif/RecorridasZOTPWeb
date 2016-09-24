class AddDireccionToVisit < ActiveRecord::Migration
  def change
    add_column :visits, :direccion, :string
  end
end
