class RemoveAreaFromRanchadas < ActiveRecord::Migration
  def change
    remove_reference :ranchadas, :area, index: true, foreign_key: true
  end
end
