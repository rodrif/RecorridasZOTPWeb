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

	def self.actualizarPersonasFromJson personasJson
		respuesta = Hash.new		
		personas = ActiveSupport::JSON.decode(personasJson)

	    personas.each do |p|
	    	person = Person.new
			if p['webId'] 
				person = Person.find(p['webId']);
				if person.nil?
					throw Exception "persona con Id que no existe en la BD"
				end
			end

      		person.nombre = p['nombre']
      		person.apellido = p['apellido']

			if person.save
				respuesta[p['android_id'].to_s] = person.id
			else
				respuesta[p['android_id'].to_s] = -1
			end 
	    end

	    respuesta
	end

	def self.listPersonasModificadasDesde fecha
		#TODO
	end

end