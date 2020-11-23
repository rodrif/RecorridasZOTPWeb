class VisitDataAccess

	def self.download datosJson = nil, fecha = nil

		query = 'id AS web_id, person_id AS web_person_id, fecha, descripcion, latitud, longitud, state_id AS estado, updated_at'
    if fecha.nil?
      sqlResult = Visit.select(query)
    else
      sqlResult = Visit.where('updated_at > ?', fecha).select(query)
    end

    resultado = Hash.new
    resultado['datos'] = []
    resultado['fecha'] = DateTime.now.utc.strftime('%Y-%m-%d %H:%M:%S.%L')

		sqlResult.each_with_index do |v, index|
			fecha = v.fecha.to_datetime.strftime('%Q')
			v = v.attributes
			v['fecha'] = fecha
			resultado['datos'][index] = v
		end

		resultado
  end

  def self.get
    select = 'people.id as person_id, people.nombre as person_name, coalesce(people.apellido, "") as person_apellido, zones.nombre as zone_nombre, DATE_FORMAT(visits.fecha, "%d/%m/%Y") as visit_fecha'
    Visit.joins(person: :zone).select(select)
  end

	def self.upload user, json, fecha = nil
		respuesta = Hash.new
		respuesta['datos'] = Hash.new
    visitas = ActiveSupport::JSON.decode(json)

    visitas.each do |v|
      if (v['web_id'].nil? || v['web_id'] <= 0)
        visit = Visit.new
        accion = Auditoria::ALTA
      else
        visit = Visit.find(v['web_id']);
        accion = Auditoria::MODIFICACION
      end
      if !v['estado'].nil? && v['estado'] == 3
        VisitDataAccess.borrar_logico visit, user
        accion = Auditoria::BAJA
      else
        visit.state_id = 1
      end
      visit.person_id = v['web_person_id']
      visit.fecha = Time.at(v['fecha'] / 1000)
      visit.descripcion = v['descripcion'] ? v['descripcion'] : nil
      visit.latitud = v['latitud'] ? v['latitud'] : nil
      visit.longitud = v['longitud'] ? v['longitud'] : nil
      visit.direccion = v['direccion'] && !v['direccion'].blank? ? v['direccion'] : nil
      if visit.direccion.nil?
        visit.reverse_geocode
      end

      if (visit.save(validate: false))
        if accion != Auditoria::BAJA
          AuditoriaDataAccess.log user, accion, Auditoria::VISITA, visit
        end
        respuesta['datos'][v['android_id'].to_s] = visit.id
      else
        respuesta['datos'][v['android_id'].to_s] = -1
      end
    end

    respuesta['fecha'] = DateTime.now.utc.strftime('%Y-%m-%d %H:%M:%S.%L')
    respuesta
  end

  def self.borrar_logico visita, user
    visita.state_id = 3
    if user && !visita.person_id.nil? && visita.person.state_id != 3
      AuditoriaDataAccess.log user, Auditoria::BAJA, Auditoria::VISITA, visita
    end
    visita.person_id = nil
    visita.save(validate: false)
  end

end
