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

	    assert_equal 6, personas["datos"].size, "cantidad de personas no coincide"

		  states_1 = 0
		  states_3 = 0
			personas.first[1].to_a.each do |persona|
				states_1 +=1 if persona.state_id == 1
				states_3 +=1 if persona.state_id == 3
			end
	    assert_equal 5, states_1, "test state_id 1 hay 5 personas"
			assert_equal 1, states_3, "test state_id 3 hay 1 persona"

	    assert (Person.find_by nombre: "GuardarPersonasFromJsonUno"), "No se guardo la persona en la bd"
			assert (Person.find_by nombre: "GuardarPersonasFromJsonDos"), "No se guardo la persona en la bd"
	end

end
