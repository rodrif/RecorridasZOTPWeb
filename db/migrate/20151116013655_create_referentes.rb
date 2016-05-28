class CreateReferentes < ActiveRecord::Migration
  def change
    create_table :referentes do |t|
      t.string :nombre
      t.string :apellido
      t.integer :telefono
      t.references :area, index: true, foreign_key: true
      t.string :dia

      t.timestamps null: false
    end
  end
end
