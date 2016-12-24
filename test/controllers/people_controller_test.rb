require 'test_helper'

class PeopleControllerTest < ActionController::TestCase
  setup do
    @person = people(:one)
    @user = users(:admin)
    sign_in @user
  end

  # FIXME mover a api people test
  # test "guardar personas mobile post" do
  #   assert_difference('Person.activas.count', 2) do
  #     post :mobGuardarPersonasPost, datos: '[{"android_id":1,"nombre":"Facundo1"},{"android_id":2,"nombre":"Persona2"}]'
  #   end
  # end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:people)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create person" do
    assert_difference('Person.count') do
      post :create, person: {
        apellido: @person.apellido,
        nombre: @person.nombre,
        zone_id: @person.zone_id,
        visits_attributes: [{"latitud"=>"-34.6425867", "longitud"=>"-58.5659176"}]
      }
    end

    assert_redirected_to people_path
  end

  test "should get edit" do
    get :edit, id: @person
    assert_response :success
  end

  test "should update person" do
    patch :update, id: @person, person: { apellido: @person.apellido, nombre: @person.nombre, zone_id: @person.zone_id }
    assert_redirected_to people_path
  end

  test "should destroy person" do
    assert_difference('Person.activas.count', -1) do
      delete :destroy, id: @person
    end

    assert_redirected_to people_path
  end
end
