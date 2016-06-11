require 'test_helper'

class AlertTypesControllerTest < ActionController::TestCase
  setup do
    @alert_type = alert_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:alert_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create alert_type" do
    assert_difference('AlertType.count') do
      post :create, alert_type: { nombre: @alert_type.nombre }
    end

    assert_redirected_to alert_type_path(assigns(:alert_type))
  end

  test "should show alert_type" do
    get :show, id: @alert_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @alert_type
    assert_response :success
  end

  test "should update alert_type" do
    patch :update, id: @alert_type, alert_type: { nombre: @alert_type.nombre }
    assert_redirected_to alert_type_path(assigns(:alert_type))
  end

  test "should destroy alert_type" do
    assert_difference('AlertType.count', -1) do
      delete :destroy, id: @alert_type
    end

    assert_redirected_to alert_types_path
  end
end
