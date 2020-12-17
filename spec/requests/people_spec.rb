require 'rails_helper'
require 'support/shared_examples_requests'

RSpec.describe "Personas", type: :request do

  let!(:area) { create(:area) }
  let!(:zona) { create(:zone, area: area) }
  let!(:estado) { create(:estado) }
  let!(:institucion) { create(:colegio) }
  let!(:departamento) { create(:departamento) }
  let(:visita) { build(:visit) }
  let!(:persona) { create(:person, zone: zona, estado: estado, institucion: institucion, departamento_ids: [departamento.id], visits: [visita]) }
  let(:voluntario) { create(:user_voluntario)}

  describe 'PUT /people/:id' do
    context 'con user voluntario' do
      before do
        login_as voluntario
        put "/people/#{persona.id}", params: { person: {nombre: "Nuevo nombre"} }
      end

      include_examples "access denied"
    end
  end

  describe 'DELETE /people/:id' do
    context 'con user voluntario' do
      before do
        login_as voluntario
        delete"/people/#{persona.id}"
      end

      include_examples "access denied"
    end
  end

  describe 'GET /people/update_zonas' do
    context 'con user admin' do
      let!(:admin) { create(:user_admin)}
      before do
        login_as admin
        get "/people/update_zonas", params: { format: :js}
      end

      include_examples "get ok"
    end
  end

end