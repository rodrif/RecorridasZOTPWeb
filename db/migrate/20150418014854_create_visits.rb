class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.text :descripcion
      t.datetime :fecha
      t.references :person, index: true, foreign_key: true
      t.references :location, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
