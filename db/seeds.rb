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

InstitucionTipo.create!([
  { id: 1, nombre: 'Merendero' },
  { id: 2, nombre: 'Colegio' },
  { id: 3, nombre: 'Universidad' }
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
Person.create([
                  {
                      id: 1,
                      nombre: 'Abril Acusta',
                      zone_id: 2,
                      state_id: 1,
                      dni: 11111111,
                      fecha_nacimiento: '2020-11-22',
                      descripcion: 'Una descripcion'
                  },
                  {
                      id: 2,
                      nombre: 'Nicolas Rosso',
                      zone_id: 2,
                      state_id: 1,
                      dni: 11111111,
                      fecha_nacimiento: '2020-11-22',
                      descripcion: 'Una descripcion'
                  },
                  {
                      id: 3,
                      nombre: 'Nicolas Decinvente',
                      zone_id: 2,
                      state_id: 1,
                      dni: 11111111,
                      fecha_nacimiento: '2020-11-22',
                      descripcion: 'Una descripcion'
                  },
                  {
                      id: 4,
                      nombre: 'Andrés Bottardo',
                      zone_id: 2,
                      state_id: 1,
                      dni: 11111111,
                      fecha_nacimiento: '2020-11-22',
                      descripcion: 'Una descripcion'
                  },
                  {
                      id: 5,
                      nombre: 'Santiago Pez',
                      zone_id: 2,
                      state_id: 1,
                      dni: 11111111,
                      fecha_nacimiento: '2020-11-22',
                      descripcion: 'Una descripcion'
                  },
                  {
                      id: 6,
                      nombre: 'Leandro Gallo',
                      zone_id: 2,
                      state_id: 1,
                      dni: 11111111,
                      fecha_nacimiento: '2020-11-22',
                      descripcion: 'Una descripcion'
                  },
                  {
                      id: 7,
                      nombre: 'Mario Bros',
                      zone_id: 2,
                      state_id: 1,
                      dni: 11111111,
                      fecha_nacimiento: '2020-11-22',
                      descripcion: 'Una descripcion'
                  },
                  {
                      id: 8,
                      nombre: 'Luciano Rapanui',
                      zone_id: 2,
                      state_id: 1,
                      dni: 11111111,
                      fecha_nacimiento: '2020-11-22',
                      descripcion: 'Una descripcion'
                  },
                  {
                      id: 9,
                      nombre: 'Colorado Pedrazo',
                      zone_id: 2,
                      state_id: 1,
                      dni: 11111111,
                      fecha_nacimiento: '2020-11-22',
                      descripcion: 'Una descripcion'
                  },
                  {
                      id: 10,
                      nombre: 'Belen Tonduza',
                      zone_id: 2,
                      state_id: 1,
                      dni: 11111111,
                      fecha_nacimiento: '2020-11-22',
                      descripcion: 'Una descripcion'
                  },
                  {
                      id: 11,
                      nombre: 'Magali Sallai',
                      zone_id: 2,
                      state_id: 1,
                      dni: 11111111,
                      fecha_nacimiento: '2020-11-22',
                      descripcion: 'Una descripcion'
                  },
                  {
                      id: 12,
                      nombre: 'Camila Russeno',
                      zone_id: 2,
                      state_id: 1,
                      dni: 11111111,
                      fecha_nacimiento: '2020-11-22',
                      descripcion: 'Una descripcion'
                  },
                  {
                      id: 13,
                      nombre: 'Azul Gudeci',
                      zone_id: 2,
                      state_id: 1,
                      dni: 11111111,
                      fecha_nacimiento: '2020-11-22',
                      descripcion: 'Una descripcion'
                  },
                  {
                      id: 14,
                      nombre: 'Emilio Tichois',
                      zone_id: 2,
                      state_id: 1,
                      dni: 11111111,
                      fecha_nacimiento: '2020-11-22',
                      descripcion: 'Una descripcion'
                  },
                  {
                      id: 15,
                      nombre: 'Tomas Dabliuy',
                      zone_id: 2,
                      state_id: 1,
                      dni: 11111111,
                      fecha_nacimiento: '2020-11-22',
                      descripcion: 'Una descripcion'
                  },
                  {
                      id: 16,
                      nombre: 'Jose Castillo',
                      zone_id: 2,
                      state_id: 1,
                      dni: 11111111,
                      fecha_nacimiento: '2020-11-22',
                      descripcion: 'Una descripcion'
                  },
                  {
                      id: 17,
                      nombre: 'JuanMa Tomesito',
                      zone_id: 2,
                      state_id: 1,
                      dni: 11111111,
                      fecha_nacimiento: '2020-11-22',
                      descripcion: 'Una descripcion'
                  },
                  {
                      id: 18,
                      nombre: 'Cesar Gaona',
                      zone_id: 2,
                      state_id: 1,
                      dni: 11111111,
                      fecha_nacimiento: '2020-11-22',
                      descripcion: 'Una descripcion'
                  },
                  {
                      id: 19,
                      nombre: 'Tati Corredero',
                      zone_id: 2,
                      state_id: 1,
                      dni: 11111111,
                      fecha_nacimiento: '2020-11-22',
                      descripcion: 'Una descripcion'
                  },
                  {
                      id: 20,
                      nombre: 'JuanMa Barzano',
                      zone_id: 2,
                      state_id: 1,
                      dni: 11111111,
                      fecha_nacimiento: '2020-11-22',
                      descripcion: 'Una descripcion'
                  },
                  {
                      id: 21,
                      nombre: 'Carlo Ancelotti',
                      zone_id: 2,
                      state_id: 1,
                      dni: 11111111,
                      fecha_nacimiento: '2020-11-22',
                      descripcion: 'Una descripcion'
                  },
                  {
                      id: 22,
                      nombre: 'Carlos Xavier',
                      zone_id: 2,
                      state_id: 1,
                      dni: 11111111,
                      fecha_nacimiento: '2020-11-22',
                      descripcion: 'Una descripcion'
                  },
                  {
                      id: 23,
                      nombre: 'Mike Wazowski',
                      zone_id: 2,
                      state_id: 1,
                      dni: 11111111,
                      fecha_nacimiento: '2020-11-22',
                      descripcion: 'Una descripcion'
                  },
                  {
                      id: 24,
                      nombre: 'Ned Stark',
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
                 },
                 {
                     id: 2,
                     descripcion: 'Persona vista por primera vez',
                     fecha: '2020-11-22 03:00:00',
                     person_id: 2,
                     latitud: -34.55943852477665,
                     longitud: -58.464892385113956,
                     state_id: 1,
                     direccion: '6916, Coronel Ramón Lorenzo Falcón, Liniers, Autonomous City of Buenos Aires, Comuna 9, C1408DSI, Argentina'
                 },
                 {
                     id: 3,
                     descripcion: 'Persona vista por primera vez',
                     fecha: '2020-11-22 03:00:00',
                     person_id: 3,
                     latitud: -34.55859030228831,
                     longitud: -58.458197591412784,
                     state_id: 1,
                     direccion: '6916, Coronel Ramón Lorenzo Falcón, Liniers, Autonomous City of Buenos Aires, Comuna 9, C1408DSI, Argentina'
                 },
                 {
                     id: 4,
                     descripcion: 'Persona vista por primera vez',
                     fecha: '2020-11-22 03:00:00',
                     person_id: 4,
                     latitud: -34.55659030228831,
                     longitud: -58.458197591412784,
                     state_id: 1,
                     direccion: '6916, Coronel Ramón Lorenzo Falcón, Liniers, Autonomous City of Buenos Aires, Comuna 9, C1408DSI, Argentina'
                 },
                 {
                     id: 5,
                     descripcion: 'Persona vista por primera vez',
                     fecha: '2020-11-22 03:00:00',
                     person_id: 5,
                     latitud: -34.55659030128831,
                     longitud: -58.458197591412784,
                     state_id: 1,
                     direccion: '6916, Coronel Ramón Lorenzo Falcón, Liniers, Autonomous City of Buenos Aires, Comuna 9, C1408DSI, Argentina'
                 },
                 {
                     id: 6,
                     descripcion: 'Persona vista por primera vez',
                     fecha: '2020-11-22 03:00:00',
                     person_id: 6,
                     latitud: -34.55659030128831,
                     longitud: -58.458197591212784,
                     state_id: 1,
                     direccion: '6916, Coronel Ramón Lorenzo Falcón, Liniers, Autonomous City of Buenos Aires, Comuna 9, C1408DSI, Argentina'
                 },
                 {
                     id: 7,
                     descripcion: 'Persona vista por primera vez',
                     fecha: '2020-11-22 03:00:00',
                     person_id: 7,
                     latitud: -34.55659030228831,
                     longitud: -58.458197591212784,
                     state_id: 1,
                     direccion: '6916, Coronel Ramón Lorenzo Falcón, Liniers, Autonomous City of Buenos Aires, Comuna 9, C1408DSI, Argentina'
                 },
                 {
                     id: 8,
                     descripcion: 'Persona vista por primera vez',
                     fecha: '2020-11-22 03:00:00',
                     person_id: 8,
                     latitud: -34.55659030128831,
                     longitud: -58.458197591212784,
                     state_id: 1,
                     direccion: '6916, Coronel Ramón Lorenzo Falcón, Liniers, Autonomous City of Buenos Aires, Comuna 9, C1408DSI, Argentina'
                 },
                 {
                     id: 9,
                     descripcion: 'Persona vista por primera vez',
                     fecha: '2020-11-22 03:00:00',
                     person_id: 9,
                     latitud: -34.55659031128831,
                     longitud: -58.458197591212784,
                     state_id: 1,
                     direccion: '6916, Coronel Ramón Lorenzo Falcón, Liniers, Autonomous City of Buenos Aires, Comuna 9, C1408DSI, Argentina'
                 },
                 {
                     id: 10,
                     descripcion: 'Persona vista por primera vez',
                     fecha: '2020-11-22 03:00:00',
                     person_id: 10,
                     latitud: -34.55659011128831,
                     longitud: -58.458197591212784,
                     state_id: 1,
                     direccion: '6916, Coronel Ramón Lorenzo Falcón, Liniers, Autonomous City of Buenos Aires, Comuna 9, C1408DSI, Argentina'
                 },
                 {
                     id: 11,
                     descripcion: 'Persona vista por primera vez',
                     fecha: '2020-11-22 03:00:00',
                     person_id: 11,
                     latitud: -34.55659011128931,
                     longitud: -58.458197591212784,
                     state_id: 1,
                     direccion: '6916, Coronel Ramón Lorenzo Falcón, Liniers, Autonomous City of Buenos Aires, Comuna 9, C1408DSI, Argentina'
                 },
                 {
                     id: 12,
                     descripcion: 'Persona vista por primera vez',
                     fecha: '2020-11-22 03:00:00',
                     person_id: 12,
                     latitud: -34.55659011128831,
                     longitud: -58.458197501212784,
                     state_id: 1,
                     direccion: '6916, Coronel Ramón Lorenzo Falcón, Liniers, Autonomous City of Buenos Aires, Comuna 9, C1408DSI, Argentina'
                 },
                 {
                     id: 13,
                     descripcion: 'Persona vista por primera vez',
                     fecha: '2020-11-22 03:00:00',
                     person_id: 13,
                     latitud: -34.55659011128831,
                     longitud: -58.458197491212784,
                     state_id: 1,
                     direccion: '6916, Coronel Ramón Lorenzo Falcón, Liniers, Autonomous City of Buenos Aires, Comuna 9, C1408DSI, Argentina'
                 },
                 {
                     id: 14,
                     descripcion: 'Persona vista por primera vez',
                     fecha: '2020-11-22 03:00:00',
                     person_id: 14,
                     latitud: -34.55659011128831,
                     longitud: -58.458197691212784,
                     state_id: 1,
                     direccion: '6916, Coronel Ramón Lorenzo Falcón, Liniers, Autonomous City of Buenos Aires, Comuna 9, C1408DSI, Argentina'
                 },
                 {
                     id: 15,
                     descripcion: 'Persona vista por primera vez',
                     fecha: '2020-11-22 03:00:00',
                     person_id: 15,
                     latitud: -34.55659011128838,
                     longitud: -58.458197591212784,
                     state_id: 1,
                     direccion: '6916, Coronel Ramón Lorenzo Falcón, Liniers, Autonomous City of Buenos Aires, Comuna 9, C1408DSI, Argentina'
                 },
                 {
                     id: 16,
                     descripcion: 'Persona vista por primera vez',
                     fecha: '2020-11-22 03:00:00',
                     person_id: 16,
                     latitud: -34.55659011118831,
                     longitud: -58.458196591212784,
                     state_id: 1,
                     direccion: '6916, Coronel Ramón Lorenzo Falcón, Liniers, Autonomous City of Buenos Aires, Comuna 9, C1408DSI, Argentina'
                 },
                 {
                     id: 17,
                     descripcion: 'Persona vista por primera vez',
                     fecha: '2020-11-22 03:00:00',
                     person_id: 17,
                     latitud: -34.55659021128831,
                     longitud: -58.458196591212784,
                     state_id: 1,
                     direccion: '6916, Coronel Ramón Lorenzo Falcón, Liniers, Autonomous City of Buenos Aires, Comuna 9, C1408DSI, Argentina'
                 },
                 {
                     id: 18,
                     descripcion: 'Persona vista por primera vez',
                     fecha: '2020-11-22 03:00:00',
                     person_id: 18,
                     latitud: -34.55659021128831,
                     longitud: -58.458197691212784,
                     state_id: 1,
                     direccion: '6916, Coronel Ramón Lorenzo Falcón, Liniers, Autonomous City of Buenos Aires, Comuna 9, C1408DSI, Argentina'
                 },
                 {
                     id: 19,
                     descripcion: 'Persona vista por primera vez',
                     fecha: '2020-11-22 03:00:00',
                     person_id: 19,
                     latitud: -34.55659011228831,
                     longitud: -58.458197501212784,
                     state_id: 1,
                     direccion: '6916, Coronel Ramón Lorenzo Falcón, Liniers, Autonomous City of Buenos Aires, Comuna 9, C1408DSI, Argentina'
                 },
                 {
                     id: 20,
                     descripcion: 'Persona vista por primera vez',
                     fecha: '2020-11-22 03:00:00',
                     person_id: 20,
                     latitud: -34.55659061128831,
                     longitud: -58.458198591212784,
                     state_id: 1,
                     direccion: '6916, Coronel Ramón Lorenzo Falcón, Liniers, Autonomous City of Buenos Aires, Comuna 9, C1408DSI, Argentina'
                 },
                 {
                     id: 21,
                     descripcion: 'Persona vista por primera vez',
                     fecha: '2020-11-22 03:00:00',
                     person_id: 21,
                     latitud: -34.55659011138831,
                     longitud: -58.458197591212785,
                     state_id: 1,
                     direccion: '6916, Coronel Ramón Lorenzo Falcón, Liniers, Autonomous City of Buenos Aires, Comuna 9, C1408DSI, Argentina'
                 },
                 {
                     id: 22,
                     descripcion: 'Persona vista por primera vez',
                     fecha: '2020-11-22 03:00:00',
                     person_id: 22,
                     latitud: -34.55659030228831,
                     longitud: -58.458197591412784,
                     state_id: 1,
                     direccion: '6916, Coronel Ramón Lorenzo Falcón, Liniers, Autonomous City of Buenos Aires, Comuna 9, C1408DSI, Argentina'
                 },
                 {
                     id: 23,
                     descripcion: 'Persona vista por primera vez',
                     fecha: '2020-11-22 03:00:00',
                     person_id: 23,
                     latitud: -34.55659030228831,
                     longitud: -58.458197591412784,
                     state_id: 1,
                     direccion: '6916, Coronel Ramón Lorenzo Falcón, Liniers, Autonomous City of Buenos Aires, Comuna 9, C1408DSI, Argentina'
                 },
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