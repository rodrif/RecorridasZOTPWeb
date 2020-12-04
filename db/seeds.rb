# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

estados = State.create!([ { nombre: 'Actualizado', id: 1 }, { nombre: 'Borrado', id: 3 } ])

areas = Area.create!([ { nombre: 'Oeste', state_id: 1 }, { nombre: 'Capital', state_id: 1 } ])

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
  },
  {
    name: 'Juan',
    apellido: 'Perez',
    password: '123456789',
    encrypted_password: '$2a$10$Gpq4hV3d88XGgr6HfP9HIuiHNL8BWR51Ov5XB2zeCOie6sjMQUDRK',
    email: 'juanperez@gmail.com',
    uid: 'juanperez@gmail.com',
    provider: 'email',
    confirmation_token: 'aTkfHp14is8DkKXYcfM1',
    confirmed_at: '2016-02-27 01:19:05.754497',
    confirmation_sent_at: '2016-02-27 01:17:58.521644',
    sign_in_count: 0,
    rol_id: 1,
    area: areas[0],
    state_id: 1
  }
])

Jornada.create([
  { id: 1, nombre: 'Lunes'},
  { id: 2, nombre: 'Martes'},
  { id: 3, nombre: 'Miercoles'},
  { id: 4, nombre: 'Jueves'},
  { id: 5, nombre: 'Viernes'},
  { id: 6, nombre: 'Sabado'},
  { id: 7, nombre: 'Domingo'}
])

Departamento.create([
  { id: 1, nombre: 'Adicciones', state_id: 1},
  { id: 2, nombre: 'Animales', state_id: 1},
  { id: 3, nombre: 'Asesoramiento Jurídico', state_id: 1},
  { id: 4, nombre: 'Asistencia Social', state_id: 1},
  { id: 5, nombre: 'Documentación', state_id: 1},
  { id: 6, nombre: 'Inclusión Escolar', state_id: 1},
  { id: 7, nombre: 'Inclusión Laboral', state_id: 1},
  { id: 8, nombre: 'Jubilaciones', state_id: 1},
  { id: 9, nombre: 'Materno Infantil', state_id: 1},
  { id: 10, nombre: 'Psicología', state_id: 1},
  { id: 11, nombre: 'Salud', state_id: 1},
  { id: 12, nombre: 'Visitas', state_id: 1}
])

Person.create([
  {
    id: 1,
    nombre: 'persona a',
    zone_id: 2,
    state_id: 1,
    dni: 11111111,
    fecha_nacimiento: '2020-11-22',
    descripcion: 'Una descripcion'
  },
  {
    id: 2,
    nombre: 'persona b',
    zone_id: 2,
    state_id: 1,
    dni: 11111111,
    fecha_nacimiento: '2020-11-22',
    descripcion: 'Una descripcion'
  },
  {
    id: 3,
    nombre: 'persona c',
    zone_id: 2,
    state_id: 1,
    dni: 11111111,
    fecha_nacimiento: '2020-11-22',
    descripcion: 'Una descripcion'
  },
  {
    id: 4,
    nombre: 'persona d',
    zone_id: 2,
    state_id: 1,
    dni: 11111111,
    fecha_nacimiento: '2020-11-22',
    descripcion: 'Una descripcion'
  },
  {
    id: 5,
    nombre: 'persona e',
    zone_id: 2,
    state_id: 1,
    dni: 11111111,
    fecha_nacimiento: '2020-11-22',
    descripcion: 'Una descripcion'
  },
  {
    id: 6,
    nombre: 'persona f',
    zone_id: 2,
    state_id: 1,
    dni: 11111111,
    fecha_nacimiento: '2020-11-22',
    descripcion: 'Una descripcion'
  },
  {
    id: 7,
    nombre: 'persona g',
    zone_id: 2,
    state_id: 1,
    dni: 11111111,
    fecha_nacimiento: '2020-11-22',
    descripcion: 'Una descripcion'
  },
  {
    id: 8,
    nombre: 'persona h',
    zone_id: 2,
    state_id: 1,
    dni: 11111111,
    fecha_nacimiento: '2020-11-22',
    descripcion: 'Una descripcion'
  },
  {
    id: 9,
    nombre: 'persona i',
    zone_id: 2,
    state_id: 1,
    dni: 11111111,
    fecha_nacimiento: '2020-11-22',
    descripcion: 'Una descripcion'
  },
  {
    id: 10,
    nombre: 'persona j',
    zone_id: 2,
    state_id: 1,
    dni: 11111111,
    fecha_nacimiento: '2020-11-22',
    descripcion: 'Una descripcion'
  },
  {
    id: 11,
    nombre: 'persona k',
    zone_id: 2,
    state_id: 1,
    dni: 11111111,
    fecha_nacimiento: '2020-11-22',
    descripcion: 'Una descripcion'
  },
  {
    id: 12,
    nombre: 'persona l',
    zone_id: 2,
    state_id: 1,
    dni: 11111111,
    fecha_nacimiento: '2020-11-22',
    descripcion: 'Una descripcion'
  },
  {
    id: 13,
    nombre: 'persona m',
    zone_id: 2,
    state_id: 1,
    dni: 11111111,
    fecha_nacimiento: '2020-11-22',
    descripcion: 'Una descripcion'
  },
  {
    id: 14,
    nombre: 'persona n',
    zone_id: 2,
    state_id: 1,
    dni: 11111111,
    fecha_nacimiento: '2020-11-22',
    descripcion: 'Una descripcion'
  },
  {
    id: 15,
    nombre: 'persona o',
    zone_id: 2,
    state_id: 1,
    dni: 11111111,
    fecha_nacimiento: '2020-11-22',
    descripcion: 'Una descripcion'
  },
  {
    id: 16,
    nombre: 'persona p',
    zone_id: 2,
    state_id: 1,
    dni: 11111111,
    fecha_nacimiento: '2020-11-22',
    descripcion: 'Una descripcion'
  },
  {
    id: 17,
    nombre: 'persona q',
    zone_id: 2,
    state_id: 1,
    dni: 11111111,
    fecha_nacimiento: '2020-11-22',
    descripcion: 'Una descripcion'
  },
  {
    id: 18,
    nombre: 'persona r',
    zone_id: 2,
    state_id: 1,
    dni: 11111111,
    fecha_nacimiento: '2020-11-22',
    descripcion: 'Una descripcion'
  },
  {
    id: 19,
    nombre: 'persona s',
    zone_id: 2,
    state_id: 1,
    dni: 11111111,
    fecha_nacimiento: '2020-11-22',
    descripcion: 'Una descripcion'
  },
  {
    id: 20,
    nombre: 'persona t',
    zone_id: 2,
    state_id: 1,
    dni: 11111111,
    fecha_nacimiento: '2020-11-22',
    descripcion: 'Una descripcion'
  },
  {
    id: 21,
    nombre: 'persona u',
    zone_id: 2,
    state_id: 1,
    dni: 11111111,
    fecha_nacimiento: '2020-11-22',
    descripcion: 'Una descripcion'
  },
  {
    id: 22,
    nombre: 'persona v',
    zone_id: 2,
    state_id: 1,
    dni: 11111111,
    fecha_nacimiento: '2020-11-22',
    descripcion: 'Una descripcion'
  },
  {
    id: 23,
    nombre: 'persona w',
    zone_id: 2,
    state_id: 1,
    dni: 11111111,
    fecha_nacimiento: '2020-11-22',
    descripcion: 'Una descripcion'
  },
  {
    id: 24,
    nombre: 'persona x',
    zone_id: 2,
    state_id: 1,
    dni: 11111111,
    fecha_nacimiento: '2020-11-22',
    descripcion: 'Una descripcion'
  },
  {
    id: 25,
    nombre: 'persona y',
    zone_id: 2,
    state_id: 1,
    dni: 11111111,
    fecha_nacimiento: '2020-11-22',
    descripcion: 'Una descripcion'
  },
  {
    id: 26,
    nombre: 'persona z',
    zone_id: 2,
    state_id: 1,
    dni: 11111111,
    fecha_nacimiento: '2020-11-22',
    descripcion: 'Una descripcion'
  },
  {
    id: 27,
    nombre: 'persona aa',
    zone_id: 2,
    state_id: 1,
    dni: 11111111,
    fecha_nacimiento: '2020-11-22',
    descripcion: 'Una descripcion'
  }
])

Visit.create([
  {
    id: 1,
    descripcion: 'Persona vista por primera vez',
    fecha: '2020-11-22 03:00:00',
    person_id: 1,
    latitud: -34.64018822007153000,
    longitud: -58.52389718458151000,
    state_id: 1,
    direccion: '6916, Coronel Ramón Lorenzo Falcón, Liniers, Autonomous City of Buenos Aires, Comuna 9, C1408DSI, Argentina'
  }
])

Pedido.create([
  {
    id: 1,
    fecha: '2020-11-22 03:00:00',
    descripcion: 'Frazada',
    person_id: 1,
    completado: 0,
    state_id: 1
  }
])


Institucion.create([
  {
    id: 1,
    nombre: 'Institucion 1',
    descripcion: 'Una descripcion',
    direccion: 'Direccion manual',
    contacto: 'Juan',
    telefono: 111111111,
    codigo_postal: 1111,
    latitud: -34.59171496828844000,
    longitud: -58.41477054009286000,
    state_id: 1
  }
])