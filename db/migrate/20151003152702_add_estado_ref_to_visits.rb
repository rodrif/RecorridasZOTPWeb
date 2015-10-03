class AddEstadoRefToVisits < ActiveRecord::Migration
  def change
    add_reference :visits, :state, index: true, foreign_key: true
  end
end
