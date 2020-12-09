class RemoveMeetingsTable < ActiveRecord::Migration[6.0]
  def change
    drop_table :meetings
  end
end
