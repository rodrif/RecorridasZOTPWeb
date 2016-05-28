class AddStateToReferentes < ActiveRecord::Migration
  def change
    add_reference :referentes, :state, index: true, foreign_key: true
  end
end
