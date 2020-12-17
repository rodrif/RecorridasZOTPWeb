require 'rails_helper'
require 'support/shared_examples_requests'

RSpec.describe "Informes", type: :request do

  let(:voluntario) { create(:user_voluntario)}

  describe 'GET /informes' do
    context 'con user voluntario' do
      before do
        login_as voluntario
        get "/informes"
      end

      include_examples "access denied"
    end
  end

end