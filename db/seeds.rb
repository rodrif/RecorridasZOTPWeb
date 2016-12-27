# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

estados = State.create!([ { nombre: 'Actualizado', id: 1 }, { nombre: 'Borrado', id: 3 } ])

areas = Area.create!([ { nombre: 'Zona Oeste', state_id: 1 } ])

zonas = Zone.create!([
	{ nombre: 'Haedo', latitud: '-34.644699880461665', longitud: '-58.59469532948424', area: areas[0], state_id: 1 },
	{ nombre: 'Liniers', latitud: '-34.639050702761295', longitud: '-58.52465748801478', area: areas[0], state_id: 1 },
	{ nombre: 'Ramos', latitud: '-34.641027959809676', longitud: '-58.565813303139294', area: areas[0], state_id: 1 },
	{ nombre: 'San Justo', latitud: '-34.68575077451089', longitud: '-58.55993389966898', area: areas[0], state_id: 1 }
])

notificaciones_tipo = NotificacionTipo.create!([
    { id: 1, nombre: 'Programada', code: 1 },
    { id: 2, nombre: 'Urgente', code: 2 },
    { id: 3, nombre: 'Cumpleaños', code: 3 },
    { id: 4, nombre: 'Calendario', code: 4 }
])

frecuencias_tipo = FrecuenciaTipo.create!([{ nombre: 'Única', code: 1 }, { nombre: 'Día/s', code: 2 }, { nombre: 'Semana/s', code: 3 }, { nombre: 'Mes/es', code: 4 }])

roles = Rol.create([
  { id: 1, nombre: "administrador",
    puede_crear_persona: 1,
    puede_editar_persona: 1,
    puede_borrar_persona: 1,
    puede_ver_telefono_persona: 1,
    puede_ver_web: 1,
    puede_crear_visita: 1,
    puede_editar_visita: 1,
    puede_borrar_visita: 1,
    code: 1
  },
  { id: 2, nombre: "referente",
    puede_crear_persona: 1,
    puede_editar_persona: 1,
    puede_borrar_persona: 0,
    puede_ver_telefono_persona: 1,
    puede_ver_web: 1,
    puede_crear_visita: 1,
    puede_editar_visita: 1,
    puede_borrar_visita: 1,
    code: 2
  },
  { id: 3, nombre: "coordinador",
    puede_crear_persona: 1,
    puede_editar_persona: 1,
    puede_borrar_persona: 1,
    puede_ver_telefono_persona: 1,
    puede_ver_web: 0,
    puede_crear_visita: 1,
    puede_editar_visita: 1,
    puede_borrar_visita: 1,
    code: 3
  },
  { id: 4, nombre: "voluntario",
    puede_crear_persona: 1,
    puede_editar_persona: 0,
    puede_borrar_persona: 0,
    puede_ver_telefono_persona: 0,
    puede_ver_web: 0,
    puede_crear_visita: 1,
    puede_editar_visita: 1,
    puede_borrar_visita: 0,
    code: 4
  },
  { id: 5, nombre: "invitado",
    puede_crear_persona: 0,
    puede_editar_persona: 0,
    puede_borrar_persona: 0,
    puede_ver_telefono_persona: 0,
    puede_ver_web: 0,
    puede_crear_visita: 0,
    puede_editar_visita: 0,
    puede_borrar_visita: 0,
    code: 5
}])

User.create!([
  {
    name: 'admin',
    apellido: 'admin apellido',
    password: '123456789',
    encrypted_password: '$2a$10$Gpq4hV3d88XGgr6HfP9HIuiHNL8BWR51Ov5XB2zeCOie6sjMQUDRK',
    email: 'admin@gmail.com',
    uid: 'admin@gmail.com',
    provider: 'email',
    confirmation_token: 'aTkfHp14is8DkKXYcfM1',
    confirmed_at: '2016-02-27 01:19:05.754497',
    confirmation_sent_at: '2016-02-27 01:17:58.521644',
    sign_in_count: 0,
    rol_id: 1,
    area: areas[0],
    state_id: 1
  },
 {
    name: 'Facundo',
    apellido: 'Rodriguez',
    password: '123456789',
    encrypted_password: '$2a$10$Gpq4hV3d88XGgr6HfP9HIuiHNL8BWR51Ov5XB2zeCOie6sjMQUDRK',
    email: 'rodrif89@gmail.com',
    uid: 'rodrif89@gmail.com',
    provider: 'email',
    confirmation_token: 'aTkfHp14is8DkKXYcfM1',
    confirmed_at: '2016-02-27 01:19:05.754497',
    confirmation_sent_at: '2016-02-27 01:17:58.521644',
    sign_in_count: 0,
    rol_id: 1,
    area: areas[0],
    state_id: 1
  },
  {
    name: 'referente',
    apellido: 'referente apellido',
    password: '123456789',
    encrypted_password: '$2a$10$Gpq4hV3d88XGgr6HfP9HIuiHNL8BWR51Ov5XB2zeCOie6sjMQUDRK',
    email: 'referente@gmail.com',
    uid: 'referente@gmail.com',
    provider: 'email',
    confirmation_token: 'aTkfHp14is8DkKXYcfM1',
    confirmed_at: '2016-02-27 01:19:05.754497',
    confirmation_sent_at: '2016-02-27 01:17:58.521644',
    sign_in_count: 0,
    rol_id: 2,
    area: areas[0],
    state_id: 1
  },
  {
    name: 'coordinador',
    apellido: 'coordinador apellido',
    password: '123456789',
    encrypted_password: '$2a$10$Gpq4hV3d88XGgr6HfP9HIuiHNL8BWR51Ov5XB2zeCOie6sjMQUDRK',
    email: 'coordinador@gmail.com',
    uid: 'coordinador@gmail.com',
    provider: 'email',
    confirmation_token: 'aTkfHp14is8DkKXYcfM1',
    confirmed_at: '2016-02-27 01:19:05.754497',
    confirmation_sent_at: '2016-02-27 01:17:58.521644',
    sign_in_count: 0,
    rol_id: 3,
    area: areas[0],
    state_id: 1
  },
  {
    name: 'voluntario',
    apellido: 'voluntario apellido',
    password: '123456789',
    encrypted_password: '$2a$10$Gpq4hV3d88XGgr6HfP9HIuiHNL8BWR51Ov5XB2zeCOie6sjMQUDRK',
    email: 'voluntario@gmail.com',
    uid: 'voluntario@gmail.com',
    provider: 'email',
    confirmation_token: 'aTkfHp14is8DkKXYcfM1',
    confirmed_at: '2016-02-27 01:19:05.754497',
    confirmation_sent_at: '2016-02-27 01:17:58.521644',
    sign_in_count: 0,
    rol_id: 4,
    area: areas[0],
    state_id: 1
  },
  {
    name: 'invitado',
    apellido: 'invitado apellido',
    password: '123456789',
    encrypted_password: '$2a$10$Gpq4hV3d88XGgr6HfP9HIuiHNL8BWR51Ov5XB2zeCOie6sjMQUDRK',
    email: 'invitado@gmail.com',
    uid: 'invitado@gmail.com',
    provider: 'email',
    confirmation_token: 'aTkfHp14is8DkKXYcfM1',
    confirmed_at: '2016-02-27 01:19:05.754497',
    confirmation_sent_at: '2016-02-27 01:17:58.521644',
    sign_in_count: 0,
    rol_id: 5,
    area: areas[0],
    state_id: 1
  }
])

notificaciones = Notificacion.create!([{ titulo: 'Carga de camión', subtitulo: 'En carranza',
    fecha_desde: 3.days.from_now, fecha_hasta: 30.days.from_now, frecuencia_cant: 4,
    roles: [Rol.first], notificacion_tipo: notificaciones_tipo[0],
    frecuencia_tipo: frecuencias_tipo[1], state_id: 1, areas: [areas[0]] }
])

ranchadas = Ranchada.create!([
    { nombre: 'Estacion liniers', descripcion: "cerca de la estacion", latitud: '-34.644699880461665', longitud: '-58.59469532948424', zone: zonas[1], state_id: 1 },
    { nombre: 'Ranchada Rodriguez', latitud: '-34.639050652761295', longitud: '-58.52463748801478', zone: zonas[0], state_id: 1 },
    { nombre: 'Ranchada Aquino', latitud: '-34.639050652761282', longitud: '-58.52463748801278', zone: zonas[0], state_id: 1 }
])

familias = Familia.create!([
    { nombre: 'Rodriguez', descripcion: 'descripcion familia rodriguez', zone: zonas[0], ranchada: ranchadas[1], state_id: 1 },
    { nombre: 'Aquino', zone: zonas[0], ranchada: ranchadas[1], state_id: 1 }
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

ubicaciones = [
	{ latitud: -34.6414209, longitud: -58.6119373}, { latitud: -34.6774225, longitud: -58.550007},
	{ latitud: -34.7100242, longitud: -58.4922147}, { latitud: -34.6487055, longitud: -58.6145449},
	{ latitud: -34.6302634, longitud: -58.6216342}, { latitud: -34.6855008, longitud: -58.5514068},
]

visits = Visit.create!([ { descripcion: 'Descripcion1', person: personas[0], fecha: Time.now.ago(4.days),
 latitud: '-34.6425867', longitud: '-58.5659176', state_id: 1 } ])

2.upto(12) do |i|
  visits << Visit.create!(descripcion: 'Descripcion1', person: personas[i], fecha: Time.now.ago(3.days),
		latitud: ubicaciones[i%6][:latitud], longitud: ubicaciones[i%6][:longitud], state_id: 1)

  visits << Visit.create!(descripcion: 'Descripcion2', person: personas[i], fecha: Time.now.ago(2.days),
		latitud: ubicaciones[i%5][:latitud], longitud: ubicaciones[i%5][:longitud], state_id: 1)
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
