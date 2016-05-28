require 'test_helper'

class RanchadasControllerTest < ActionController::TestCase
  setup do
    @ranchada = ranchadas(:one)
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
    assert_difference('Ranchada.count') do
      post :create, ranchada: { area_id: @ranchada.area_id, descripcion: @ranchada.descripcion, latitud: @ranchada.latitud, longitud: @ranchada.longitud, nombre: @ranchada.nombre, zone_id: @ranchada.zone_id }
    end

    assert_redirected_to ranchada_path(assigns(:ranchada))
  end

  test "should show ranchada" do
    get :show, id: @ranchada
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ranchada
    assert_response :success
  end

  test "should update ranchada" do
    patch :update, id: @ranchada, ranchada: { area_id: @ranchada.area_id, descripcion: @ranchada.descripcion, latitud: @ranchada.latitud, longitud: @ranchada.longitud, nombre: @ranchada.nombre, zone_id: @ranchada.zone_id }
    assert_redirected_to ranchada_path(assigns(:ranchada))
  end

  test "should destroy ranchada" do
    assert_difference('Ranchada.count', -1) do
      delete :destroy, id: @ranchada
    end

    assert_redirected_to ranchadas_path
  end
end
