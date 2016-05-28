class AddRanchadaToPeople < ActiveRecord::Migration
  def change
    add_reference :people, :ranchada, index: true, foreign_key: true
  end
end
