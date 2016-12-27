require 'test_helper'

class AreasControllerTest < ActionController::TestCase
  setup do
    @area = areas(:zona_oeste)
    @user = users(:admin)
    sign_in @user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:areas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create area" do
    assert_difference('Area.activas.count') do
      post :create, area: { nombre: 'Nueva area' }
    end
    assert_redirected_to areas_path
  end

  test "should get edit" do
    get :edit, id: @area
    assert_response :success
  end

  test "should update area" do
    patch :update, id: @area, area: { nombre: @area.nombre }
    assert_redirected_to areas_path
  end

  test "should destroy area" do
    @areaABorrar = Area.create!({ nombre: 'Area a borrar', state: states(:actualizado) })
    assert_difference('Area.activas.count', -1) do
      delete :destroy, id: @areaABorrar
    end

    assert_redirected_to areas_path
  end
end
