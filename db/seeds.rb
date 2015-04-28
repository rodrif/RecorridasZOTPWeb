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

personas << Person.create!(nombre: "Facundo", apellido: "Rodriguez", zone: zonas[0])

10.times do |i|
  personas << Person.create!(nombre: "Persona#{i}", apellido: "Apellido#{i}", zone: zonas[i])  
end


visits = Visit.create!([ { descripcion: 'Descripcion1', person: personas[0], fecha: Time.now,
 latitud: '-34.6425867', longitud: '-58.5659176' } ])

1.upto(10) do |i|
  visits << Visit.create!(descripcion: 'Descripcion1', person: personas[i], fecha: Time.now.ago(2.days),
  	latitud: Faker::Address.latitude, longitud: Faker::Address.longitude)

  visits << Visit.create!(descripcion: 'Descripcion2', person: personas[i], fecha: Time.now,
  	latitud: Faker::Address.latitude, longitud: Faker::Address.longitude)
end


tipoAlertas = AlertType.create!([ { nombre: 'Novedad' }, { nombre: 'Recordatorio' } ])


Alert.create!([ { mensaje: 'mensaje alerta1', fecha: '2015-01-01 20:03:11', alert_type: tipoAlertas[0],
	zone: zonas[0]}, { mensaje: 'mensaje alerta2', fecha: '2015-03-12 20:03:11', alert_type: tipoAlertas[1],
	zone: zonas[1]} ])
