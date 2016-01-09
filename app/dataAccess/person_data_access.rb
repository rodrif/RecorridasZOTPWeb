class PersonDataAccess

	def self.listPersonaMapa
	  Person.readonly.find_by_sql("SELECT p.id AS persona_id, p.nombre, p.apellido, v.latitud, v.longitud, v.fecha
	  	 FROM people p INNER JOIN visits v ON p.id = v.person_id 
	  	 WHERE v.fecha = (SELECT MAX (v2.fecha) FROM visits v2 WHERE v2.person_id = p.id)")
	end

	def self.download datosJson = nil, fecha = nil
		respuesta = Hash.new
		respuesta['datos'] = Hash.new
		respuesta['fecha'] = DateTime.now.utc.strftime('%Y-%m-%d %H:%M:%S.%L')

    query = 'id AS web_id, zone_id AS web_zone_id, ranchada_id AS web_ranchada_id, familia_id AS web_familia_id, nombre, apellido, dni, fecha_nacimiento, telefono, descripcion, state_id AS estado, updated_at'
    if fecha.nil?
      respuesta['datos'] = Person.select(query)
    else
      respuesta['datos'] = Person.where('updated_at > ?', fecha).select(query)
    end

		respuesta
	end

  def self.upload json, fecha = nil
    respuesta = Hash.new
    respuesta['datos'] = Hash.new
    respuesta['fecha'] = DateTime.now.utc.strftime('%Y-%m-%d %H:%M:%S.%L')
    personas = ActiveSupport::JSON.decode(json)

    personas.each do |p|
      if (p['web_id'].nil? || p['web_id'] <= 0)
        person = Person.new
      else
        person = Person.find(p['web_id']);
      end

      if !p['estado'].nil? && p['estado'] == 3
        PersonDataAccess.borrar_logico person
      else
        person.state_id = 1
      end

      person.zone_id = p['zone_id']
      person.ranchada_id = p['ranchada_id'] ? p['ranchada_id'] : nil
      person.familia_id = p['familia_id'] ? p['familia_id'] : nil
      person.nombre = p['nombre']
      person.apellido = p['apellido'] ? p['apellido'] : nil
      person.dni = p['dni'] ? p['dni'] : nil
      person.fecha_nacimiento = p['fecha_nacimiento'] ? p['fecha_nacimiento'] : nil
      person.telefono = p['telefono'] ? p['telefono'] : nil
      person.descripcion = p['descripcion'] ? p['descripcion'] : nil

      if (person.save)
        respuesta['datos'][p['android_id'].to_s] = person.id
      else
        respuesta['datos'][p['android_id'].to_s] = -1
      end
    end

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

  def self.borrar_logico person
    person.state_id = 3
    person.zone_id = nil
    person.ranchada_id = nil
    person.familia_id = nil
    person.visits.each do |v|
      v.state_id = 3
    end
    person.save(validate: false)
  end

end