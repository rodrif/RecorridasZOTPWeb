require 'rails_helper'
require 'support/shared_examples_requests'

RSpec.describe "People", type: :request do

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

end