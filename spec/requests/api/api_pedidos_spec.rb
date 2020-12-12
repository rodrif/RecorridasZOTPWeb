require 'rails_helper'
require 'support/shared_examples_api_requests'

RSpec.describe "Api Pedidos", type: :request do

  let(:admin) { create(:user_admin)}
  let(:invitado) { create(:user_invitado)}
  let!(:persona) { create(:person) }
  let(:pedido_existente) { create(:pedido, person: persona)}
  let(:pedido) { build(:pedido)}

  describe 'POST /api/pedidos/download' do

    context 'cuando no se provee token' do
      before { post "/api/pedidos/download", params: {} }

      include_examples "response no token"
    end

    context 'cuando el user es administrador' do
      before do
        auth_headers = admin.create_new_auth_token
        post "/api/pedidos/download", params: {}, headers: auth_headers
      end

      include_examples "response ok"
    end

    context 'cuando el user es invitado' do
      before do
        auth_headers = invitado.create_new_auth_token
        post "/api/pedidos/download", params: {}, headers: auth_headers
      end

      include_examples "response access denied"
    end
  end

  describe 'POST /api/pedidos/upload' do

    context 'cuando no se provee token' do
      before { post "/api/pedidos/upload", params: {} }

      include_examples "response no token"
    end

    context 'cuando el user es invitado' do
      before do
        auth_headers = invitado.create_new_auth_token
        post "/api/pedidos/upload", params: {}, headers: auth_headers
      end

      include_examples "response access denied"
    end

    context 'cuando se crea un nuevo pedido' do
      before do
        auth_headers = admin.create_new_auth_token
        data = [ { web_person_id: persona.id,
                   fecha: pedido.fecha.to_datetime.strftime('%Q').to_i,
                   descripcion: pedido.descripcion,
                   completado: pedido.completado
                 }
        ].to_json
        post "/api/pedidos/upload", params: {datos: data}, headers: auth_headers
      end

      it "crea satisfactoriamente" do
        expect(response.status).to eq 200
      end
    end

    context 'cuando se actualiza un pedido existente' do
      before do
        auth_headers = admin.create_new_auth_token
        data = [ { web_id: pedido_existente.id,
                   web_person_id: persona.id,
                   fecha: pedido.fecha.to_datetime.strftime('%Q').to_i,
                   descripcion: pedido.descripcion,
                   completado: 1
                 }
        ].to_json
        post "/api/pedidos/upload", params: {datos: data}, headers: auth_headers
      end

      it "actualiza datos satisfactoriamente" do
        expect(response.status).to eq 200
        expect(Pedido.find(pedido_existente.id).completado).to be true
      end
    end

    context 'cuando se borra un pedido existente' do
      before do
        auth_headers = admin.create_new_auth_token
        data = [ { web_id: pedido_existente.id, estado: 3}].to_json
        post "/api/pedidos/upload", params: {datos: data}, headers: auth_headers
      end

      it "borra satisfactoriamente" do
        expect(response.status).to eq 200
        expect(Pedido.find(pedido_existente.id).state_id).to eq 3
      end
    end
  end

end