class AreaDataAccessTest < ActionController::TestCase

	setup do
		@user = users(:admin)
		sign_in @user
	end

	test "version ok test" do
		data = { version: 100000 }.to_json

	    respuesta = AreaDataAccess.download data

	    assert_not_nil respuesta, 'respuesta null'
		assert_nil respuesta['errores'], 'version correcto, no tiene que agregar errores'
	end

	test "version vieja test" do
		data = { version: 0 }.to_json

	    respuesta = AreaDataAccess.download data

	    assert_not_nil respuesta, 'respuesta null'
		assert_not_nil respuesta['errores'], 'falta retornar los errores'
		assert_not_nil respuesta['errores']['version'], 'falta agregar error de version'
	end
end
