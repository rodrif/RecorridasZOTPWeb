require 'rails_helper'

describe AreasController, type: :controller do
  login_admin

  before(:each) do
    request['Accept'] = 'application/json'
  end

  describe "GET /areas" do
    context "when having multiple areas" do
      before do
        create(:state, :activo)
        create_list(:area, 5)
      end

      it "returns all of them" do
        request.headers['Accept'] = 'application/json'
        get :index

        #binding.pry
        expect(response).to have_http_status(:success)
      end
    end
  end
end
