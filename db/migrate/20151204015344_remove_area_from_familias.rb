class RemoveAreaFromFamilias < ActiveRecord::Migration
  def change
    remove_reference :familias, :area, index: true, foreign_key: true
  end
end
