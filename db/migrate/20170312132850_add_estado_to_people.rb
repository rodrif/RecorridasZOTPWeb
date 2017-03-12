class AddEstadoToPeople < ActiveRecord::Migration
  def change
    add_reference :people, :estado, index: true, foreign_key: true
  end
end
