require 'test_helper'
require 'helpers/test_module'

class AlertsControllerTest < ActionController::TestCase
  include TestModule

  setup do
    @alert = alerts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:alerts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create alert" do
    assert_difference('Alert.count') do
      post :create, alert: { fecha: @alert.fecha, mensaje: @alert.mensaje, zone_id: @alert.zone_id }
    end

    assert_redirected_to alert_path(assigns(:alert))
  end

  test "should show alert" do
    get :show, id: @alert
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @alert
    assert_response :success
  end

  test "should update alert" do
    patch :update, id: @alert, alert: { fecha: @alert.fecha, mensaje: @alert.mensaje, zone_id: @alert.zone_id }
    assert_redirected_to alert_path(assigns(:alert))
  end

  test "should destroy alert" do
    assert_difference('Alert.count', -1) do
      delete :destroy, id: @alert
    end

    assert_redirected_to alerts_path
  end

  test "mobListAlertasCompleta" do
    get :mobMostrarAlertas, {fecha: '2010-01-01', zona: 'Liniers', alertType: 'Novedad'}
    assert_response :success

    @alerta = alerts(:alertaCompleta)
   
    assert_equal @alerta.mensaje, jsonComp('idAlerta', @alerta.id, 'mensaje')
    assert_equal @alerta.zone.nombre, jsonComp('idAlerta', @alerta.id, 'nombreZona')
    assert_equal @alerta.alert_type.nombre, jsonComp('idAlerta', @alerta.id, 'nombreAlertaTipo')

    get :mobMostrarAlertas, {fecha: '2100-01-01', zona: 'Liniers', alertType: 'Novedad'}
    assert_response :success

    assert_equal 0, json.length
  end

  test "mobListAlertasSoloMensaje" do
    get :mobMostrarAlertas, {fecha: '2010-01-01'}
    assert_response :success

    @alerta = alerts(:alertaSoloMensaje)
   
    assert_equal @alerta.mensaje, jsonComp('idAlerta', @alerta.id, 'mensaje')
    assert_nil jsonComp('idAlerta', @alerta.id, 'nombreZona')
    assert_nil jsonComp('idAlerta', @alerta.id, 'nombreAlertaTipo')
  end

  test "mobListAlertasConZona" do
    get :mobMostrarAlertas, {fecha: '2010-01-01', zona: 'Liniers'}
    assert_response :success

    @alerta = alerts(:alertaConZona)
   
    assert_equal @alerta.mensaje, jsonComp('idAlerta', @alerta.id, 'mensaje')
    assert_equal @alerta.zone.nombre, jsonComp('idAlerta', @alerta.id, 'nombreZona')
    assert_nil jsonComp('idAlerta', @alerta.id, 'nombreAlertaTipo')
  end

  test "mobListAlertasConTipo" do
    get :mobMostrarAlertas, {fecha: '2010-01-01', alertType: 'Recordatorio'}
    assert_response :success

    @alerta = alerts(:alertaConTipo)
   
    assert_equal @alerta.mensaje, jsonComp('idAlerta', @alerta.id, 'mensaje')
    assert_nil jsonComp('idAlerta', @alerta.id, 'nombreZona')
    assert_equal @alerta.alert_type.nombre, jsonComp('idAlerta', @alerta.id, 'nombreAlertaTipo')
  end
end
