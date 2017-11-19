class CreateInstitucionTipos < ActiveRecord::Migration
  def change
    create_table :institucion_tipos do |t|
      t.string :nombre

      t.timestamps null: false
    end
    InstitucionTipo.create :nombre => 'Merendero'
    InstitucionTipo.create :nombre => 'Colegio'
    InstitucionTipo.create :nombre => 'Universidad'
  end

end
