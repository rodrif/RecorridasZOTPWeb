# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

estados = State.create([ { nombre: 'Actualizado', id: 1 }, { nombre: 'Borrado', id: 3 } ])

areas = Area.create([ { nombre: 'Zona Oeste' } ])

zonas = Zone.create([
	{ nombre: 'Haedo', latitud: '-34.644699880461665', longitud: '-58.59469532948424', area: areas[0] },
	{ nombre: 'Liniers', latitud: '-34.639050702761295', longitud: '-58.52465748801478', area: areas[0] },
	{ nombre: 'Ramos', latitud: '-34.641027959809676', longitud: '-58.565813303139294', area: areas[0] },
	{ nombre: 'San Justo', latitud: '-34.68575077451089', longitud: '-58.55993389966898', area: areas[0] }
])

ranchadas = Ranchada.create([
	{ nombre: 'Estacion liners', descripcion: "cerca de la estacion", latitud: '-34.644699880461665', longitud: '-58.59469532948424', area: areas[0], zone: zonas[1] },
	{ nombre: 'Famila Rodriguez', latitud: '-34.639050652761295', longitud: '-58.52463748801478', area: areas[0], zone: zonas[0] },
])

familias = Familia.create([
	{ nombre: 'Rodriguez', area: areas[0], zone: zonas[0] }
])

referentes = Referente.create([
	{ nombre: 'Nadia', apellido: 'Guzman', telefono: '46546569', area: areas[0], dia: 'Lunes' }
])

personas = Array.new

personas << Person.create!(nombre: "Facundo", apellido: "Rodriguez", zone: zonas[0], state_id: 1)

10.times do |i|
  personas << Person.create!(nombre: "Persona#{i}", apellido: "Apellido#{i}", zone: zonas[i%4], state_id: 1)  
end


visits = Visit.create!([ { descripcion: 'Descripcion1', person: personas[0], fecha: Time.now,
 latitud: '-34.6425867', longitud: '-58.5659176', state_id: 1 } ])

1.upto(10) do |i|
  visits << Visit.create!(descripcion: 'Descripcion1', person: personas[i], fecha: Time.now.ago(2.days),
  	latitud: Faker::Address.latitude, longitud: Faker::Address.longitude, state_id: 1)

  visits << Visit.create!(descripcion: 'Descripcion2', person: personas[i], fecha: Time.now,
  	latitud: Faker::Address.latitude, longitud: Faker::Address.longitude, state_id: 1)
end


tipoAlertas = AlertType.create!([ { nombre: 'Novedad' }, { nombre: 'Recordatorio' } ])


Alert.create!([ { mensaje: 'mensaje alerta1', fecha: '2015-01-01 20:03:11', alert_type: tipoAlertas[0],
	zone: zonas[0]}, { mensaje: 'mensaje alerta2', fecha: '2015-03-12 20:03:11', alert_type: tipoAlertas[1],
	zone: zonas[1]} ])

WelcomeMessage.create!([ { 
	mensaje: 'mensaje 1',
	fecha_desde: '2015-01-01 20:03:11',
	fecha_hasta: '2016-01-01 20:03:11'
	},
	{ 
	mensaje: 'mensaje 2',
	fecha_desde: '2015-02-01 20:03:11',
	fecha_hasta: '2018-01-01 20:03:11'
	},
	{ 
	mensaje: 'mensaje 3',
	fecha_desde: '2020-02-01 20:03:11',
	fecha_hasta: '2022-01-01 20:03:11'
	} ])
