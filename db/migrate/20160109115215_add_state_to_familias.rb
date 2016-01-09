class AddStateToFamilias < ActiveRecord::Migration
  def change
    add_reference :familias, :state, index: true, foreign_key: true
  end
end
