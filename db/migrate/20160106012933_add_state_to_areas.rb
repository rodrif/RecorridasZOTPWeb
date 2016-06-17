class AddStateToAreas < ActiveRecord::Migration
  def change
    add_reference :areas, :state, index: true, foreign_key: true
  end
end
