class PersonDataAccessTest < ActionController::TestCase

	setup do
		@user = users(:admin)
		sign_in @user
	end

	test "upload and download test" do
		liniers = zones(:liniers)
		data = [
			{ web_id: 1, android_id: 11, nombre: 'GuardarPersonasFromJsonUno', web_zone_id: liniers.id },
			{ android_id: 2, nombre: 'GuardarPersonasFromJsonDos', web_zone_id: liniers.id },
			{ web_id: 3, android_id: 5, nombre: 'personaABorrar', estado: 3, web_zone_id: liniers.id }
		].to_json

	    respuesta = PersonDataAccess.upload @user, data

	    assert_not_nil respuesta, "respuesta null"

		assert respuesta["datos"]["11"] > 0, "respuesta incorrecta de servidor"
		assert respuesta["datos"]["2"] > 0, "respuesta incorrecta de servidor"

	    assert (Person.find_by nombre: "GuardarPersonasFromJsonUno"), "No se guardo la persona en la bd"
		assert (Person.find_by nombre: "GuardarPersonasFromJsonDos"), "No se guardo la persona en la bd"
		assert_equal 3, Person.find(3).state_id, "fallo borrado logico"

		# download
		personas = PersonDataAccess.download

	    #TODO mejorar test
	    assert_equal 6, personas["datos"].size, "cantidad de personas no coincide"

	    assert_equal personas.first[1].to_a[0].state_id, 1, "test state_id persona 0"
	    assert_equal personas.first[1].to_a[1].state_id, 1, "test state_id persona 1"
	    assert_equal personas.first[1].to_a[2].state_id, 1, "test state_id persona 2"
	    assert_equal personas.first[1].to_a[3].state_id, 1, "test state_id persona 3"
	    assert_equal personas.first[1].to_a[4].state_id, 1, "test state_id persona 4"
	    assert_equal personas.first[1].to_a[5].state_id, 3, "test state_id persona 5"

	    assert (Person.find_by nombre: "GuardarPersonasFromJsonUno"), "No se guardo la persona en la bd"
		assert (Person.find_by nombre: "GuardarPersonasFromJsonDos"), "No se guardo la persona en la bd"
	end

end
