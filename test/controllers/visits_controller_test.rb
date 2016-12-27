require 'test_helper'

class VisitsControllerTest < ActionController::TestCase
  setup do
    @visit = visits(:one)
    @user = users(:admin)
    sign_in @user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:visits)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create visit" do
    assert_difference('Visit.count') do
      post :create, visit: { descripcion: @visit.descripcion, fecha: @visit.fecha, person_id: @visit.person_id }
    end

    assert_redirected_to visits_path(:person_id => @visit.person_id)
  end

  test "should get edit" do
    get :edit, id: @visit
    assert_response :success
  end

  test "should update visit" do
    patch :update, id: @visit, visit: { descripcion: @visit.descripcion, fecha: @visit.fecha, person_id: @visit.person_id }
    assert_redirected_to visits_path(:person_id => @visit.person_id)
  end

  test "should destroy visit" do
    assert_difference('Visit.activas.count', -1) do
      delete :destroy, id: @visit
    end

    assert_redirected_to visits_path
  end
end
