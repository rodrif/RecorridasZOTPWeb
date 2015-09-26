class PersonDataAccessTest < ActiveSupport::TestCase
	
	test "guardarPersonasFromJson test" do    
	    respuesta = PersonDataAccess.guardarPersonasFromJson '[{"web_id": 1, "android_id":11, "nombre":"GuardarPersonasFromJson1"},{"android_id":2, "nombre":"GuardarPersonasFromJson2"},{"web_id": 3,"android_id":5, "nombre":"personaABorrar", "estado":3}]'
	
	    assert_not_nil respuesta, "respuesta null"

		assert respuesta["datos"]["11"] > 0, "respuesta incorrecta de servidor"
		assert respuesta["datos"]["2"] > 0, "respuesta incorrecta de servidor"

	    assert (Person.find_by nombre: "GuardarPersonasFromJson1"), "No se guardo la persona en la bd"
		assert (Person.find_by nombre: "GuardarPersonasFromJson2"), "No se guardo la persona en la bd"
		assert !Person.exists?(3)
	end

	test "getPersonasDesde" do    
	    personas = PersonDataAccess.getPersonasDesde

	    #TODO mejorar test
	    assert_equal 5, personas["datos"].count, "cantidad de personas no coincide"

	    # assert (Person.find_by nombre: "GuardarPersonasFromJson1"), "No se guardo la persona en la bd"
		# assert (Person.find_by nombre: "GuardarPersonasFromJson2"), "No se guardo la persona en la bd"
	end

end
