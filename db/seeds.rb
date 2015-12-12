# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

estados = State.create([ { nombre: 'Actualizado', id: 1 }, { nombre: 'Borrado', id: 3 } ])

areas = Area.create([ { id: Faker::Number.number(4), nombre: 'Zona Oeste' } ])

zonas = Zone.create([
	{ id: Faker::Number.number(4), nombre: 'Haedo', latitud: '-34.644699880461665', longitud: '-58.59469532948424', area: areas[0] },
	{ id: Faker::Number.number(4), nombre: 'Liniers', latitud: '-34.639050702761295', longitud: '-58.52465748801478', area: areas[0] },
	{ id: Faker::Number.number(4), nombre: 'Ramos', latitud: '-34.641027959809676', longitud: '-58.565813303139294', area: areas[0] },
	{ id: Faker::Number.number(4), nombre: 'San Justo', latitud: '-34.68575077451089', longitud: '-58.55993389966898', area: areas[0] }
])

ranchadas = Ranchada.create([
	{ id: Faker::Number.number(4), nombre: 'Estacion liniers', descripcion: "cerca de la estacion", latitud: '-34.644699880461665', longitud: '-58.59469532948424', zone: zonas[1] },
	{ id: Faker::Number.number(4), nombre: 'Familia Rodriguez', latitud: '-34.639050652761295', longitud: '-58.52463748801478', zone: zonas[0] },
	{ id: Faker::Number.number(4), nombre: 'Ranchada Aquino', latitud: '-34.639050652761282', longitud: '-58.52463748801278', zone: zonas[0] }
])

familias = Familia.create([
	{ id: Faker::Number.number(4), nombre: 'Rodriguez', zone: zonas[0], ranchada: ranchadas[1] },
	{ id: Faker::Number.number(4), nombre: 'Aquino', zone: zonas[0], ranchada: ranchadas[1] }
])

referentes = Referente.create([
	{ id: Faker::Number.number(4), nombre: 'Nadia', apellido: 'Guzman', telefono: '46546569', area: areas[0], dia: 'Lunes' }
])

personas = Array.new

personas << Person.create!(
	nombre: "Facundo", apellido: "Rodriguez",
	zone: zonas[0], ranchada: ranchadas[1], familia: familias[0], state_id: 1)

personas << Person.create!(
	nombre: "Gonzalo", apellido: "Rodriguez",
	zone: zonas[0], ranchada: ranchadas[1], familia: familias[0], state_id: 1)

personas << Person.create!(
	nombre: "Laura", apellido: "Aquino",
	zone: zonas[2], state_id: 1)

10.times do |i|
  personas << Person.create!(nombre: Faker::Name.first_name, apellido: Faker::Name.last_name.gsub(/[^a-zA-Z]/,''), zone: zonas[i%4], state_id: 1)  
  Rails.logger.debug "#{personas[i].to_yaml}"
end

visits = Visit.create!([ { descripcion: 'Descripcion1', person: personas[0], fecha: Time.now,
 latitud: '-34.6425867', longitud: '-58.5659176', state_id: 1 } ])

2.upto(12) do |i|
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
