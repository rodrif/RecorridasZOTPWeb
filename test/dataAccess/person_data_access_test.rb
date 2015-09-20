class PersonDataAccessTest < ActiveSupport::TestCase
	
	test "guardarPersonasFromJson test" do    
	    respuesta = PersonDataAccess.guardarPersonasFromJson '[{"web_id": 1, "android_id":11, "nombre":"GuardarPersonasFromJson1"},{"android_id":2, "nombre":"GuardarPersonasFromJson2"}]'
	
	    assert_not_nil respuesta, "respuesta null"

		assert respuesta["11"] > 0, "respuesta incorrecta de servidor"
		assert respuesta["2"] > 0, "respuesta incorrecta de servidor"

	    assert (Person.find_by nombre: "GuardarPersonasFromJson1"), "No se guardo la persona en la bd"
		assert (Person.find_by nombre: "GuardarPersonasFromJson2"), "No se guardo la persona en la bd"
	end

	test "getPersonasDesde" do    
	    personas = PersonDataAccess.getPersonasDesde

	    #TODO mejorar test
	    assert_equal 4, personas.count, "cantidad de personas no coincide"

	    # assert (Person.find_by nombre: "GuardarPersonasFromJson1"), "No se guardo la persona en la bd"
		# assert (Person.find_by nombre: "GuardarPersonasFromJson2"), "No se guardo la persona en la bd"
	end

end
