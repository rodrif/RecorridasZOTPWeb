require 'rails_helper'
require 'support/shared_examples_requests'

RSpec.describe "Visitas", type: :request do

  let!(:persona) { create(:person) }
  let!(:visita) { create(:visit, person: persona)}

  let(:voluntario) { create(:user_voluntario)}

  describe 'DELETE /visits/:id' do
    context 'con user voluntario' do
      before do
        login_as voluntario
        delete"/visits/#{visita.id}"
      end

      include_examples "access denied"
    end
  end

end