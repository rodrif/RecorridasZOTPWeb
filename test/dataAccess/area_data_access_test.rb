class AreaDataAccessTest < ActionController::TestCase

	setup do
		@user = users(:admin)
		sign_in @user
	end

	test "version ok test" do
		data = [].to_json
		version = "100000"

	    respuesta = AreaDataAccess.download @user, data, nil, version

	    assert_not_nil respuesta, 'respuesta null'
		assert_nil respuesta['errores'], 'version correcto, no tiene que agregar errores'
	end

	test "version vieja test" do
		data = [].to_json
		version = "0"

		respuesta = nil

		assert_difference('ActionMailer::Base.deliveries.count', 1) do
			respuesta = AreaDataAccess.download @user, data, nil, version
		end

	    assert_not_nil respuesta, 'respuesta null'
		assert_not_nil respuesta['errores'], 'falta retornar los errores'
		assert_not_nil respuesta['errores']['version'], 'falta agregar error de version'
	end

	test "sin version test" do
		data = [].to_json

		respuesta = AreaDataAccess.download @user, data

	    assert_not_nil respuesta, 'respuesta null'
		assert_nil respuesta['errores'], 'sin version, no tiene que agregar errores'
	end
end
