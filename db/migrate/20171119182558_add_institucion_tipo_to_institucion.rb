class AddInstitucionTipoToInstitucion < ActiveRecord::Migration
  def change
    add_reference :instituciones, :institucion_tipo, index: true, foreign_key: true
  end
end
