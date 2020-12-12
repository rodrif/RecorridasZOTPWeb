require 'rails_helper'
require 'support/shared_examples_api_requests'

RSpec.describe "Api Areas", type: :request do

  let(:admin) { create(:user_admin)}
  let(:invitado) { create(:user_invitado)}
  let(:area) { build(:area) }
  let(:area_existente) { create(:area) }

  describe 'POST /api/areas/download' do

    context 'cuando no se provee token' do
      before { post "/api/areas/download", params: {} }

      include_examples "response no token"
    end

    context 'cuando el user es administrador' do
      before do
        auth_headers = admin.create_new_auth_token
        post "/api/areas/download", params: {}, headers: auth_headers
      end

      include_examples "response ok"
    end

    context 'cuando el user es invitado' do
      before do
        auth_headers = invitado.create_new_auth_token
        post "/api/areas/download", params: {}, headers: auth_headers
      end

      include_examples "response access denied"
    end

    context 'cuando la versión es antigua' do
      before do
        auth_headers = admin.create_new_auth_token
        post "/api/areas/download", params: {version: Area::VERSION - 1}, headers: auth_headers
      end

      it "devuelve error por versión deprecada" do
        expect(response.status).to eq 200
        json = JSON.parse(response.body)
        expect(json["errores"]["version"]).to include("Por favor actualice la versión de la aplicación")
      end
    end
  end

  describe 'POST /api/areas/upload' do

    context 'cuando no se provee token' do
      before { post "/api/areas/upload", params: {} }

      include_examples "response no token"
    end

    context 'cuando el user es invitado' do
      before do
        auth_headers = invitado.create_new_auth_token
        post "/api/areas/upload", params: {}, headers: auth_headers
      end

      include_examples "response access denied"
    end

    context 'cuando se crea una nueva sede' do
      before do
        auth_headers = admin.create_new_auth_token
        data = [ { nombre: area.nombre}].to_json
        post "/api/areas/upload", params: {datos: data}, headers: auth_headers
      end

      it "crea satisfactoriamente" do
        expect(response.status).to eq 200
        expect(Area.find_by_nombre(area.nombre)).not_to be_nil
      end
    end

    context 'cuando se actualiza una sede existente' do
      before do
        auth_headers = admin.create_new_auth_token
        data = [ { web_id: area_existente.id, nombre: area.nombre}].to_json
        post "/api/areas/upload", params: {datos: data}, headers: auth_headers
      end

      it "actualiza datos satisfactoriamente" do
        expect(response.status).to eq 200
        expect(Area.find(area_existente.id).nombre).not_to eq area_existente.nombre
        expect(Area.find(area_existente.id).nombre).to eq area.nombre
      end
    end

    context 'cuando se borra una sede existente' do
      before do
        auth_headers = admin.create_new_auth_token
        data = [ { web_id: area_existente.id, estado: 3}].to_json
        post "/api/areas/upload", params: {datos: data}, headers: auth_headers
      end

      it "borra satisfactoriamente" do
        expect(response.status).to eq 200
        expect(Area.find(area_existente.id).state_id).to eq 3
      end
    end
  end

end