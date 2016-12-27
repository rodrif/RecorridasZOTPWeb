require 'test_helper'

class RanchadasControllerTest < ActionController::TestCase
  setup do
    @ranchada = ranchadas(:one)
    @user = users(:admin)
    sign_in @user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ranchadas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ranchada" do
    assert_difference('Ranchada.activas.count') do
      post :create, ranchada: { area_id: @ranchada.area_id, descripcion: @ranchada.descripcion, latitud: @ranchada.latitud, longitud: @ranchada.longitud, nombre: @ranchada.nombre, zone_id: @ranchada.zone_id }
    end

    assert_redirected_to ranchadas_path
  end

  test "should get edit" do
    get :edit, id: @ranchada
    assert_response :success
  end

  test "should update ranchada" do
    patch :update, id: @ranchada, ranchada: { area_id: @ranchada.area_id, descripcion: @ranchada.descripcion, latitud: @ranchada.latitud, longitud: @ranchada.longitud, nombre: @ranchada.nombre, zone_id: @ranchada.zone_id }
    assert_redirected_to ranchadas_path
  end

  test "should destroy ranchada" do
    assert_difference('Ranchada.activas.count', -1) do
      delete :destroy, id: @ranchada
    end

    assert_redirected_to ranchadas_path
  end
end
