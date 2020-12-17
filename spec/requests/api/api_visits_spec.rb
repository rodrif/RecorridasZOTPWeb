require 'rails_helper'
require 'support/shared_examples_api_requests'

RSpec.describe "Api Visits", type: :request do

  let(:admin) { create(:user_admin)}
  let(:invitado) { create(:user_invitado)}
  let!(:persona) { create(:person) }
  let(:visita_existente) { create(:visit, person: persona)}
  let(:visita) { build(:visit)}

  describe 'POST /api/visits/download' do

    context 'cuando no se provee token' do
      before { post "/api/visits/download", params: {} }

      include_examples "response no token"
    end

    context 'cuando el user es administrador' do
      before do
        auth_headers = admin.create_new_auth_token
        post "/api/visits/download", params: {}, headers: auth_headers
      end

      include_examples "response ok"
    end

    context 'cuando el user es invitado' do
      before do
        auth_headers = invitado.create_new_auth_token
        post "/api/visits/download", params: {}, headers: auth_headers
      end

      include_examples "response access denied"
    end
  end

  describe 'POST /api/visits/upload' do

    context 'cuando no se provee token' do
      before { post "/api/visits/upload", params: {} }

      include_examples "response no token"
    end

    context 'cuando el user es invitado' do
      before do
        auth_headers = invitado.create_new_auth_token
        post "/api/visits/upload", params: {}, headers: auth_headers
      end

      include_examples "response access denied"
    end

    context 'cuando se crea una nueva visita' do
      before do
        auth_headers = admin.create_new_auth_token
        data = [ { web_person_id: persona.id,
                   fecha: visita.fecha.to_datetime.strftime('%Q').to_i,
                   descripcion: visita.descripcion,
                   latitud: visita.latitud,
                   longitud: visita.longitud
                 }
        ].to_json
        post "/api/visits/upload", params: {datos: data}, headers: auth_headers
      end

      it "crea satisfactoriamente" do
        expect(response.status).to eq 200
      end
    end

    context 'cuando se actualiza una visita existente' do
      before do
        auth_headers = admin.create_new_auth_token
        data = [ { web_id: visita_existente.id,
                   web_person_id: persona.id,
                   fecha: visita.fecha.to_datetime.strftime('%Q').to_i,
                   descripcion: visita.descripcion,
                   latitud: visita.latitud,
                   longitud: visita.longitud
                 }
        ].to_json
        post "/api/visits/upload", params: {datos: data}, headers: auth_headers
      end

      it "actualiza datos satisfactoriamente" do
        expect(response.status).to eq 200
      end
    end

    context 'cuando se borra una visita existente' do
      before do
        auth_headers = admin.create_new_auth_token
        data = [ { web_id: visita_existente.id, estado: 3}].to_json
        post "/api/visits/upload", params: {datos: data}, headers: auth_headers
      end

      it "borra satisfactoriamente" do
        expect(response.status).to eq 200
        expect(Visit.find(visita_existente.id).state_id).to eq 3
      end
    end
  end

  describe 'POST /api/2.0/visitas' do

    context 'cuando el user es administrador' do
      before do
        auth_headers = admin.create_new_auth_token
        post "/api/2.0/visitas",headers: auth_headers
      end

      include_examples "response ok"
    end
  end

end