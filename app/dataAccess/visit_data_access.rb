class VisitDataAccess

	def self.guardarVisitasFromJson visitasJson, fecha = nil
		respuesta = Hash.new
		respuesta['datos'] = Hash.new
		visitas = ActiveSupport::JSON.decode(visitasJson)
		#TODO

	    personas.each do |p|
	      if (p['web_id'].nil? || p['web_id'] <= 0)
	        person = Person.new
	      else
	      	person = Person.find(p['web_id']);
	      end 

	      if !p['estado'].nil? && p['estado'] == 3
	      	person.state_id = 3
	      end

      	  person.nombre = p['nombre']
          person.apellido = p['apellido']	      

	      if (person.save)
	      	respuesta['datos'][p['android_id'].to_s] = person.id
	      else
	      	respuesta['datos'][p['android_id'].to_s] = -1
	      end
	    end

	    respuesta
	end

	def self.getVisitasDesde datosJson = nil, fecha = nil
		respuesta = Hash.new
		respuesta['datos'] = Hash.new

		if fecha.nil?
			respuesta['datos'] = Visit.select("id AS web_id, fecha, descripcion, state_id AS estado,
				person_id AS web_persona_id, latitud, longitud, updated_at")
		else
			# respuesta['datos'] = Visit.readonly.find_by_sql ["SELECT v.id AS web_id, v.fecha, v.descripcion, v.state_id AS estado,
			# 	v.person_id AS web_persona_id, v.latitud, v.longitud, v.updated_at
			# 	FROM visits v WHERE v.updated_at >= ?", fecha]
			respuesta['datos'] = Visit.where('updated_at > ?', fecha).select("id AS web_id, fecha, descripcion, state_id AS estado,
				person_id AS web_persona_id, latitud, longitud, updated_at")
		end

		respuesta['datos'].each_with_index do |v, index|
			fecha = v.fecha.to_datetime.strftime('%Q')
			v = v.attributes
			v['fecha'] = fecha
			respuesta['datos'][index] = v
		end

		respuesta
	end

end