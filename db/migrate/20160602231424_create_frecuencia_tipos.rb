class CreateFrecuenciaTipos < ActiveRecord::Migration
  def change
    create_table :frecuencia_tipos do |t|
      t.string :nombre

      t.timestamps null: false
    end
  end
end
