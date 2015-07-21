require 'test_helper'
require 'helpers/test_module'

class MapaControllerTest < ActionController::TestCase
  include TestModule

  test "should get index" do
    get :index
    assert_response :success
    assert_select '#googleMap', 1, "debe haber 1 mapa"
  end

  test "mobMapaPersonas" do
  	get :mobMapaPersonas, :format => "json"

  	@facundo = people(:facundo)

  	assert_response :success

    assert_equal @facundo.nombre, json.find { |p| p['persona_id'] == @facundo.id}['nombre']
    assert_equal @facundo.apellido, jsonComp('persona_id', @facundo.id, 'apellido')
  end
 

end
