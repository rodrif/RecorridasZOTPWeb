class AddTelFamiliaAreaDescToPeople < ActiveRecord::Migration
  def change
    add_column :people, :telefono, :integer
    add_reference :people, :familia, index: true, foreign_key: true
    add_reference :people, :area, index: true, foreign_key: true
    add_column :people, :descripcion, :text
  end
end
