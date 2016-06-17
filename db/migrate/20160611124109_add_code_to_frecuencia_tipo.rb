class AddCodeToFrecuenciaTipo < ActiveRecord::Migration
  def change
    add_column :frecuencia_tipos, :code, :integer
  end
end
