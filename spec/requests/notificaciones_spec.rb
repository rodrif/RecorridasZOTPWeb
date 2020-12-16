require 'rails_helper'
require 'support/shared_examples_requests'

RSpec.describe "Notificaciones", type: :request do

  let(:voluntario) { create(:user_voluntario)}

  describe 'GE /notificaciones' do
    context 'con user voluntario' do
      before do
        login_as voluntario
        get "/notificaciones"
      end

      include_examples "access denied"
    end
  end

end