require 'test_helper'

class ZonesControllerTest < ActionController::TestCase
  setup do
    @zone = zones(:one)
    @user = users(:admin)
    sign_in @user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:zones)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create zone" do
    assert_difference('Zone.activas.count') do
      post :create, zone: { nombre: 'nueva zona' }
    end

    assert_redirected_to zones_path
  end

  test "should get edit" do
    get :edit, id: @zone
    assert_response :success
  end

  test "should update zone" do
    patch :update, id: @zone, zone: { nombre: @zone.nombre }
    assert_redirected_to zones_path
  end

  test "should destroy zone" do
    @nuevaZona = Zone.create!({nombre: 'nueva zona', area: areas(:zona_oeste), state: states(:actualizado)})
    assert_difference('Zone.activas.count', -1) do
      delete :destroy, id: @nuevaZona
    end

    assert_redirected_to zones_path
  end
end
