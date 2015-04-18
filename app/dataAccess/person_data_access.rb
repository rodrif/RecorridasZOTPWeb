class PersonDataAccess

	def self.listPersonaMapa	  
	
	  Person.readonly.find_by_sql("SELECT p.nombre, p.apellido, v.latitud, v.longitud, v.fecha
	  	 FROM people p INNER JOIN visits v ON p.id = v.person_id 
	  	 WHERE v.fecha = (SELECT MAX (v2.fecha) FROM visits v2 WHERE v2.person_id = p.id)")	  

	end
end