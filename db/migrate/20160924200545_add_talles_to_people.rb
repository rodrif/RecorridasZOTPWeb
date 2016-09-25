class AddTallesToPeople < ActiveRecord::Migration
  def change
    add_column :people, :pantalon, :string
    add_column :people, :remera, :string
    add_column :people, :zapatillas, :string
  end
end
