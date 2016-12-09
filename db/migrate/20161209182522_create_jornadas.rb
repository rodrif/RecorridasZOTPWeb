class CreateJornadas < ActiveRecord::Migration
  def change
    create_table :jornadas do |t|
      t.string :nombre

      t.timestamps null: false
    end

    Jornada.create nombre: 'Lunes'
    Jornada.create nombre: 'Martes'
    Jornada.create nombre: 'Miércoles'
    Jornada.create nombre: 'Jueves'
    Jornada.create nombre: 'Viernes'
    Jornada.create nombre: 'Sábado'
    Jornada.create nombre: 'Domingo'
  end
end
