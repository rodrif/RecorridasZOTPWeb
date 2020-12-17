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
        delete "/visits/#{visita.id}"
      end

      include_examples "access denied"
    end
  end

  describe 'GET /visits/getDireccion' do
    context 'con user admin' do
      let!(:admin) {create(:user_admin)}
      let(:visita) {build(:visit)}
      before do
        login_as admin
        get "/visits/getDireccion", params: {lat: visita.latitud, lng: visita.longitud}
      end

      include_examples "get ok"
    end
  end

  describe 'GET /visits/getCoordenadas' do
    context 'con user admin' do
      let!(:admin) {create(:user_admin)}
      let!(:persona) { create(:person) }
      let!(:visita) { create(:visit, person: persona)}
      before do
        login_as admin
        get "/visits/getCoordenadas", params: {direccion: visita.direccion}
      end

      include_examples "get ok"
    end
  end

end