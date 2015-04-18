# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


zonas = Zone.create([ { nombre: 'Liniers' }, { nombre: 'Ramos' } ])

10.times do |i|
  zonas << Zone.create!(nombre: "Zona#{i}")
end 

personas = Array.new

10.times do |i|
  personas << Person.create!(nombre: "Persona#{i}", apellido: "Apellido#{i}", zone: zonas[i])  
end


Visit.create!([ { descripcion: 'Descripcion1', person: personas[0], fecha: Time.now,
 latitud: '-34.6444825', longitud: '-58.5175375' } ])




