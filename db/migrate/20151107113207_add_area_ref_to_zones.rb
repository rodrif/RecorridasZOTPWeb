class AddAreaRefToZones < ActiveRecord::Migration
  def change
    add_reference :zones, :area, index: true, foreign_key: true
  end
end
