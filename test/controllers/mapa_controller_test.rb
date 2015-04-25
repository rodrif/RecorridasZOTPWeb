require 'test_helper'

class MapaControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "should get index" do
    get :index
    assert_response :success
    assert_select '#googleMap', 1, "debe haber 1 mapa"
  end

 

end
