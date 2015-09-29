class PersonDataAccess

	def self.listPersonaMapa	
	  Person.readonly.find_by_sql("SELECT p.id AS persona_id, p.nombre, p.apellido, v.latitud, v.longitud, v.fecha
	  	 FROM people p INNER JOIN visits v ON p.id = v.person_id 
	  	 WHERE v.fecha = (SELECT MAX (v2.fecha) FROM visits v2 WHERE v2.person_id = p.id)")
	end

	def self.guardarPersonasFromJson personasJson, fecha = nil
		respuesta = Hash.new
		respuesta['datos'] = Hash.new
		respuesta['fecha'] = DateTime.now.utc.strftime('%Y-%m-%d %H:%M:%S')
		personas = ActiveSupport::JSON.decode(personasJson)

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

	def self.getPersonasDesde datosJson = nil, fecha = nil
		respuesta = Hash.new
		respuesta['datos'] = Hash.new
		respuesta['fecha'] = DateTime.now.utc.strftime('%Y-%m-%d %H:%M:%S')

		if fecha.nil?
			respuesta['datos'] = Person.readonly.find_by_sql("SELECT p.id AS web_id, p.nombre, p.apellido, p.state_id AS estado, p.updated_at
			 	FROM people p")
		else
			respuesta['datos'] = Person.readonly.find_by_sql ["SELECT p.id AS web_id, p.nombre, p.apellido, p.state_id AS estado, p.updated_at
				FROM people p WHERE p.updated_at >= ?", fecha]
		end

		respuesta
	end

end