class PersonDataAccess

  def self.listPersonaMapa
    Person.readonly.find_by_sql("SELECT p.id AS persona_id, p.nombre, p.apellido, v.latitud, v.longitud, v.fecha
      FROM people p INNER JOIN visits v ON p.id = v.person_id
      LEFT JOIN estados ON estados.id = p.estado_id
      WHERE (p.estado_id is null OR estados.nombre != 'Inactivo') AND p.state_id != 3 AND v.fecha = (SELECT MAX(v2.fecha) FROM visits v2 WHERE v2.person_id = p.id)")
	end

	def self.download datosJson = nil, fecha = nil
		respuesta = Hash.new
		respuesta['datos'] = Hash.new
		respuesta['fecha'] = DateTime.now.utc.strftime('%Y-%m-%d %H:%M:%S.%L')

    query = 'id AS web_id, zone_id AS web_zone_id, ranchada_id AS web_ranchada_id, familia_id AS web_familia_id, nombre, apellido, dni, fecha_nacimiento, telefono, descripcion, pantalon, remera, zapatillas, state_id, updated_at'
    if fecha.nil?
      respuesta['datos'] = Person.select(query)
    else
      respuesta['datos'] = Person.where('updated_at > ?', fecha).select(query)
    end

		respuesta
  end

  def self.get limit, offset
    select = 'people.id as person_id, people.nombre as person_name, coalesce(people.apellido, "") as person_apellido, zones.nombre as zone_nombre'
    Person.joins(:zone).limit(limit).offset(offset).select(select)
  end

  def self.upload user, json, fecha = nil
    respuesta = Hash.new
    respuesta['datos'] = Hash.new
    personas = ActiveSupport::JSON.decode(json)

    personas.each do |p|
      if (p['web_id'].nil? || p['web_id'] <= 0)
        person = Person.new
        accion = Auditoria::ALTA
      else
        person = Person.find(p['web_id']);
        accion = Auditoria::MODIFICACION
      end
      if !p['estado'].nil? && p['estado'] == 3
        PersonDataAccess.borrar_logico person, user
        accion = Auditoria::BAJA
      else
        person.state_id = 1
      end
      person.zone_id = p['web_zone_id']
      person.ranchada_id = p['web_ranchada_id'] ? p['web_ranchada_id'] : nil
      person.familia_id = p['web_familia_id'] ? p['web_familia_id'] : nil
      person.nombre = p['nombre']
      person.apellido = p['apellido'] ? p['apellido'] : nil
      person.dni = p['dni'] ? p['dni'] : nil
      person.fecha_nacimiento = p['fecha_nacimiento'] ? p['fecha_nacimiento'] : nil
      person.telefono = p['telefono'] ? p['telefono'] : nil
      person.descripcion = p['descripcion'] ? p['descripcion'] : nil
      person.pantalon = p['pantalon'] ? p['pantalon'] : nil
      person.remera = p['remera'] ? p['remera'] : nil
      person.zapatillas = p['zapatillas'] ? p['zapatillas'] : nil

      if (accion == Auditoria::BAJA || person.save)
        if accion != Auditoria::BAJA
          AuditoriaDataAccess.log user, accion, Auditoria::PERSONA, person
        end
        respuesta['datos'][p['android_id'].to_s] = person.id
      else
        respuesta['datos'][p['android_id'].to_s] = -1
      end
    end

    respuesta['fecha'] = DateTime.now.utc.strftime('%Y-%m-%d %H:%M:%S.%L')
    respuesta
  end

	def self.getUbicacionUltVisita(idPersona)
		Visit.select(:latitud, :longitud).activas.where(person_id: idPersona).first
	end

	def self.actualizar_dependencias_ranchada ranchada
      personas = Person.where(:ranchada_id => ranchada.id)
      Person.transaction do
        personas.each do |p|
          p.zone_id = ranchada.zone_id
          p.save!
        end
      end
  end

  def self.actualizar_dependencias_familia familia
    personas = Person.where(:familia_id => familia.id)
    Person.transaction do
      personas.each do |p|
        p.zone_id = familia.zone_id
        p.ranchada_id = familia.ranchada_id
        p.save
      end
    end
  end

  def self.borrar_logico person, user
    person.state_id = 3
    person.visits.each do |v|
      VisitDataAccess.borrar_logico v, user
    end
    person.pedidos.each do |p|
      PedidoDataAccess.borrar_logico p, user
    end
    if user
      AuditoriaDataAccess.log user, Auditoria::BAJA, Auditoria::PERSONA, person
    end
    person.zone_id = nil
    person.ranchada_id = nil
    person.familia_id = nil
    person.save(validate: false)
  end

end
