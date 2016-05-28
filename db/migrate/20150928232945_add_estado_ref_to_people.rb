class AddEstadoRefToPeople < ActiveRecord::Migration
  def change
    add_reference :people, :state, index: true, foreign_key: true
  end
end
