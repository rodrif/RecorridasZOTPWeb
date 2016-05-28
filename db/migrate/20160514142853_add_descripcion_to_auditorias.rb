class AddDescripcionToAuditorias < ActiveRecord::Migration
  def change
    add_column :auditorias, :descripcion, :text
  end
end
