class AddStateToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :state, index: true, foreign_key: true
  end
end
