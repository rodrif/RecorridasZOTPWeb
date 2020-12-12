require 'rails_helper'
require 'support/shared_examples_api_requests'

RSpec.describe "Api Zones", type: :request do

  let(:admin) { create(:user_admin)}
  let(:invitado) { create(:user_invitado)}
  let(:area) { create(:area) }
  let(:zona) { build(:zone)}
  let(:zona_existente) { create(:zone, area: area)}

  describe 'POST /api/zones/download' do

    context 'cuando no se provee token' do
      before { post "/api/zones/download", params: {} }

      include_examples "response no token"
    end

    context 'cuando el user es administrador' do
      before do
        auth_headers = admin.create_new_auth_token
        post "/api/zones/download", params: {}, headers: auth_headers
      end

      include_examples "response ok"
    end

    context 'cuando el user es invitado' do
      before do
        auth_headers = invitado.create_new_auth_token
        post "/api/zones/download", params: {}, headers: auth_headers
      end

      include_examples "response access denied"
    end
  end

  describe 'POST /api/zones/upload' do

    context 'cuando no se provee token' do
      before { post "/api/zones/upload", params: {} }

      include_examples "response no token"
    end

    context 'cuando el user es invitado' do
      before do
        auth_headers = invitado.create_new_auth_token
        post "/api/zones/upload", params: {}, headers: auth_headers
      end

      include_examples "response access denied"
    end

    context 'cuando se crea una zona nueva' do
      before do
        auth_headers = admin.create_new_auth_token
        data = [ { nombre: zona.nombre, latitud: zona.latitud, longitud: zona.longitud, area_id: area.id}].to_json
        post "/api/zones/upload", params: {datos: data}, headers: auth_headers
      end

      it "crea satisfactoriamente" do
        expect(response.status).to eq 200
        expect(Zone.find_by_nombre(zona.nombre)).not_to be_nil
      end
    end

    context 'cuando se actualiza una zona existente' do
      before do
        auth_headers = admin.create_new_auth_token
        data = [ { web_id: zona_existente.id, nombre: zona.nombre, latitud: zona.latitud, longitud: zona.longitud, area_id: area.id}].to_json
        post "/api/zones/upload", params: {datos: data}, headers: auth_headers
      end

      it "actualiza datos satisfactoriamente" do
        expect(response.status).to eq 200
        expect(Zone.find(zona_existente.id).nombre).not_to eq zona_existente.nombre
        expect(Zone.find(zona_existente.id).nombre).to eq zona.nombre
      end
    end

    context 'cuando se borra una zona existente' do
      before do
        auth_headers = admin.create_new_auth_token
        data = [ { web_id: zona_existente.id, estado: 3}].to_json
        post "/api/zones/upload", params: {datos: data}, headers: auth_headers
      end

      it "borra satisfactoriamente" do
        expect(response.status).to eq 200
        expect(Zone.find(zona_existente.id).state_id).to eq 3
      end
    end
  end


end