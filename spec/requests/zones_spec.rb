require 'rails_helper'
require 'support/shared_examples_requests'

RSpec.describe "Zonas", type: :request do

  let!(:zone) { create(:zone)}

  let(:voluntario) { create(:user_voluntario)}

  describe 'POST /zones' do
    context 'con user voluntario' do
      before do
        login_as voluntario
        post "/zones", params: { zone: {nombre: zone.nombre} }
      end

      include_examples "access denied"
    end
  end

  describe 'PUT /zones/:ud' do
    context 'con user voluntario' do
      before do
        login_as voluntario
        put "/zones/#{zone.id}", params: { zone: {nombre: zone.nombre} }
      end

      include_examples "access denied"
    end
  end

  describe 'DELETE /zones/:id' do
    context 'con user voluntario' do
      before do
        login_as voluntario
        delete"/zones/#{zone.id}"
      end

      include_examples "access denied"
    end
  end

end