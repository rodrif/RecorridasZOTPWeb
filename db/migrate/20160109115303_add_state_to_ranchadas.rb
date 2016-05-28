class AddStateToRanchadas < ActiveRecord::Migration
  def change
    add_reference :ranchadas, :state, index: true, foreign_key: true
  end
end
