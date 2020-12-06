class RemoveMeetingsTable < ActiveRecord::Migration
  def change
    drop_table :meetings
  end
end
