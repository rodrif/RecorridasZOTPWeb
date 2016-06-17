class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :nombre
      t.string :apellido
      t.references :zone, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
