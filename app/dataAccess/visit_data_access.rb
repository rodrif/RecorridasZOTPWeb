class VisitDataAccess

	def self.download datosJson = nil, fecha = nil
		respuesta = Hash.new
		respuesta['datos'] = Hash.new
		respuesta['fecha'] = DateTime.now.utc.strftime('%Y-%m-%d %H:%M:%S.%L')

		query = 'id AS web_id, person_id AS web_person_id, fecha, descripcion, latitud, longitud, state_id AS estado, updated_at'
    if fecha.nil?
      respuesta['datos'] = Visit.select(query)
    else
      respuesta['datos'] = Visit.where('updated_at > ?', fecha).select(query)
    end

		respuesta['datos'].each_with_index do |v, index|
			fecha = v.fecha.to_datetime.strftime('%Q')
			v = v.attributes
			v['fecha'] = fecha
			respuesta['datos'][index] = v
		end

		respuesta
	end

	def self.upload json, fecha = nil
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
        VisitDataAccess.borrar_logico visit
        accion = Auditoria::BAJA
      else
        visit.state_id = 1
      end
      visit.person_id = v['web_person_id']
      visit.fecha = Time.at(v['fecha'] / 1000)
      visit.descripcion = v['descripcion'] ? v['descripcion'] : nil
      visit.latitud = v['latitud'] ? v['latitud'] : nil
      visit.longitud = v['longitud'] ? v['longitud'] : nil

      if (visit.save(validate: false))
        AuditoriaDataAccess.log current_user, accion, Auditoria::VISITA, visit
        respuesta['datos'][v['android_id'].to_s] = visit.id
      else
        respuesta['datos'][v['android_id'].to_s] = -1
      end
    end

    respuesta['fecha'] = DateTime.now.utc.strftime('%Y-%m-%d %H:%M:%S.%L')
    respuesta
  end

  def self.borrar_logico visita, user = nil
    visita.state_id = 3
    visita.person_id = nil
    visita.save(validate: false)
    if user
      AuditoriaDataAccess.log user, Auditoria::BAJA, Auditoria::VISITA, visit
    end
  end

end