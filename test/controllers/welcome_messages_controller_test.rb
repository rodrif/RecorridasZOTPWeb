require 'test_helper'
require 'helpers/test_module'

class WelcomeMessagesControllerTest < ActionController::TestCase
  include TestModule

  setup do
    @welcome_message = welcome_messages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:welcome_messages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create welcome_message" do
    assert_difference('WelcomeMessage.count') do
      post :create, welcome_message: { fecha_desde: @welcome_message.fecha_desde, fecha_hasta: @welcome_message.fecha_hasta, mensaje: @welcome_message.mensaje, person_id: @welcome_message.person_id }
    end

    assert_redirected_to welcome_message_path(assigns(:welcome_message))
  end

  test "should show welcome_message" do
    get :show, id: @welcome_message
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @welcome_message
    assert_response :success
  end

  test "should update welcome_message" do
    patch :update, id: @welcome_message, welcome_message: { fecha_desde: @welcome_message.fecha_desde, fecha_hasta: @welcome_message.fecha_hasta, mensaje: @welcome_message.mensaje, person_id: @welcome_message.person_id }
    assert_redirected_to welcome_message_path(assigns(:welcome_message))
  end

  test "should destroy welcome_message" do
    assert_difference('WelcomeMessage.count', -1) do
      delete :destroy, id: @welcome_message
    end

    assert_redirected_to welcome_messages_path
  end

  test "mobGetMensajeBienvenida" do
    get :mobGetMensajeBienvenida, :format => "json"

    @mensajeMasActivo = welcome_messages(:mensajeMasActivo)

    assert_response :success

    assert jsonComp('mensaje', @mensajeMasActivo.mensaje, 'mensaje')
    assert jsonComp('id', @mensajeMasActivo.id, 'id')
  end
end
