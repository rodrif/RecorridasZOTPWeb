class RemoveReferentes < ActiveRecord::Migration
  def change
    drop_table :referentes
  end
end
