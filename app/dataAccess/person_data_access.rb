class PersonDataAccess

	def self.listPersonaMapa	
	  Person.readonly.find_by_sql("SELECT p.id AS persona_id, p.nombre, p.apellido, v.latitud, v.longitud, v.fecha
	  	 FROM people p INNER JOIN visits v ON p.id = v.person_id 
	  	 WHERE v.fecha = (SELECT MAX (v2.fecha) FROM visits v2 WHERE v2.person_id = p.id)")
	end

	def self.guardarPersonasFromJson personasJson
		respuesta = Hash.new		
		personas = ActiveSupport::JSON.decode(personasJson)

	    personas.each do |p|
	      person = Person.new

	      person.nombre = p['nombre']
	      person.apellido = p['apellido']

	      if (person.save)
	      	respuesta[p['android_id'].to_s] = person.id
	      else
	      	respuesta[p['android_id'].to_s] = -1
	      end
	    end

	    respuesta
	end

	def self.getPersonasDesde fecha
		if fecha
			Person.readonly.find_by_sql("SELECT p.id AS web_id, p.nombre, p.apellido
				FROM people p") #TODO agregar fecha
		else
			Person.readonly.find_by_sql("SELECT p.id AS web_id, p.nombre, p.apellido
			 	FROM people p")
		end

	end

end