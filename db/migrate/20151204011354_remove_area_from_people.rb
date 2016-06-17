class RemoveAreaFromPeople < ActiveRecord::Migration
  def change
    remove_reference :people, :area, index: true, foreign_key: true
  end
end
