class AddDatosToUsers < ActiveRecord::Migration
  def change
    add_column :users, :dia, :string
    add_column :users, :fecha_nacimiento, :date
    add_column :users, :telefono, :string
  end
end
