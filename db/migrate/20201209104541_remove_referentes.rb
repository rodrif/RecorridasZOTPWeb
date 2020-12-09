class RemoveReferentes < ActiveRecord::Migration[6.0]
  def change
    drop_table :referentes
  end
end
