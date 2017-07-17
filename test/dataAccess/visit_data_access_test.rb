class VisitDataAccessTest < ActionController::TestCase

	setup do
		@user = users(:admin)
		sign_in @user
	end

	test "upload and download test" do
        persona = Person.first
		data = [
			{
                web_person_id: persona.id,
                android_id: 11,
                fecha: 1500335385,
                descripcion: "testDireccion",
                latitud: -34.6425867,
                longitud: -58.5659176
            }
		].to_json

	    respuesta = VisitDataAccess.upload @user, data

	    assert_not_nil respuesta, "respuesta null"
        visita = Visit.find_by descripcion: "testDireccion"
	    assert_not_nil visita, "No se guardo la visita en la bd"
        assert_not_nil visita.direccion, "No se guardo la direccion en la bd"
	end

end
