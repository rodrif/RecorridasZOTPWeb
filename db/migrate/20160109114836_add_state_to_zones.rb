class AddStateToZones < ActiveRecord::Migration
  def change
    add_reference :zones, :state, index: true, foreign_key: true
  end
end
