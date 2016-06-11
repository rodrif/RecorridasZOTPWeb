class DropLocationsTable < ActiveRecord::Migration
  def up
  	drop_table :locations
  end
end
