require 'test_helper'

class ReferentesControllerTest < ActionController::TestCase
  setup do
    @referente = referentes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:referentes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create referente" do
    assert_difference('Referente.count') do
      post :create, referente: { apellido: @referente.apellido, area_id: @referente.area_id, dia: @referente.dia, nombre: @referente.nombre, telefono: @referente.telefono }
    end

    assert_redirected_to referente_path(assigns(:referente))
  end

  test "should show referente" do
    get :show, id: @referente
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @referente
    assert_response :success
  end

  test "should update referente" do
    patch :update, id: @referente, referente: { apellido: @referente.apellido, area_id: @referente.area_id, dia: @referente.dia, nombre: @referente.nombre, telefono: @referente.telefono }
    assert_redirected_to referente_path(assigns(:referente))
  end

  test "should destroy referente" do
    assert_difference('Referente.count', -1) do
      delete :destroy, id: @referente
    end

    assert_redirected_to referentes_path
  end
end
