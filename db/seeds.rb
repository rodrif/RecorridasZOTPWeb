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


10.times do |i|
  Person.create!(nombre: "Persona#{i}", apellido: "Apellido#{i}", zone: zonas[i])  
end 
