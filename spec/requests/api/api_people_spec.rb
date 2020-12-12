require 'rails_helper'
require 'support/shared_examples_api_requests'

RSpec.describe "Api People", type: :request do

  let(:admin) { create(:user_admin)}
  let(:invitado) { create(:user_invitado)}
  let(:persona) { build(:person) }
  let(:persona_existente) { create(:person) }

  describe 'POST /api/people/download' do

    context 'cuando no se provee token' do
      before { post "/api/people/download", params: {} }

      include_examples "response no token"
    end

    context 'cuando el user es administrador' do
      before do
        auth_headers = admin.create_new_auth_token
        post "/api/people/download", params: {}, headers: auth_headers
      end

      include_examples "response ok"
    end

    context 'cuando el user es invitado' do
      before do
        auth_headers = invitado.create_new_auth_token
        post "/api/people/download", params: {}, headers: auth_headers
      end

      include_examples "response access denied"
    end
  end

  describe 'POST /api/people/upload' do

    context 'cuando no se provee token' do
      before { post "/api/people/upload", params: {} }

      include_examples "response no token"
    end

    context 'cuando el user es invitado' do
      before do
        auth_headers = invitado.create_new_auth_token
        post "/api/people/upload", params: {}, headers: auth_headers
      end

      include_examples "response access denied"
    end

    context 'cuando se crea una nueva persona' do
      before do
        auth_headers = admin.create_new_auth_token
        data = [ { nombre: persona.nombre,
                   apellido: persona.apellido,
                   dni: persona.dni,
                   fecha_nacimiento: persona.fecha_nacimiento,
                   telefono: persona.telefono,
                   descripcion: persona.descripcion,
                   pantalon: persona.pantalon,
                   remera: persona.remera,
                   zapatillas: persona.zapatillas,
                   web_zone_id: persona.zone.id
                 }
        ].to_json
        post "/api/people/upload", params: {datos: data}, headers: auth_headers
      end

      it "crea satisfactoriamente" do
        expect(response.status).to eq 200
        expect(Person.find_by_nombre(persona.nombre)).not_to be_nil
      end
    end

    context 'cuando se actualiza una persona existente' do
      before do
        auth_headers = admin.create_new_auth_token
        data = [ { web_id: persona_existente.id,
                   nombre: persona.nombre,
                   apellido: persona.apellido,
                   dni: persona.dni,
                   fecha_nacimiento: persona.fecha_nacimiento,
                   telefono: persona.telefono,
                   descripcion: persona.descripcion,
                   pantalon: persona.pantalon,
                   remera: persona.remera,
                   zapatillas: persona.zapatillas,
                   web_zone_id: persona.zone.id
                 }
        ].to_json
        post "/api/people/upload", params: {datos: data}, headers: auth_headers
      end

      it "actualiza datos satisfactoriamente" do
        expect(response.status).to eq 200
        expect(Person.find(persona_existente.id).nombre).not_to eq persona_existente.nombre
        expect(Person.find(persona_existente.id).nombre).to eq persona.nombre
      end
    end

    context 'cuando se borra una persona existente' do
      before do
        auth_headers = admin.create_new_auth_token
        data = [ { web_id: persona_existente.id, estado: 3}].to_json
        post "/api/people/upload", params: {datos: data}, headers: auth_headers
      end

      it "borra satisfactoriamente" do
        expect(response.status).to eq 200
        expect(Person.find(persona_existente.id).state_id).to eq 3
      end
    end
  end

end