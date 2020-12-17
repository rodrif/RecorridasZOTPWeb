require 'rails_helper'
require 'support/shared_examples_requests'

RSpec.describe "Mapa", type: :request do

  let!(:area) { create(:area) }
  let!(:zona) { create(:zone, area: area) }
  let!(:estado) { create(:estado) }
  let!(:institucion) { create(:colegio) }
  let!(:departamento) { create(:departamento) }
  let(:visita) { build(:visit) }
  let!(:persona) { create(:person, zone: zona, estado: estado, institucion: institucion, departamento_ids: [departamento.id], visits: [visita]) }

  describe 'GET /mapa/mostrar' do
    context 'con user admin' do
      let!(:admin) { create(:user_admin)}
      before do
        login_as admin
        get "/mapa/mostrar"
      end

      include_examples "get ok"
    end
  end

  describe 'GET /mapa/mobMapaPersonas' do
    context 'con user admin' do
      let!(:admin) { create(:user_admin)}
      before do
        login_as admin
        get "/mapa/mobMapaPersonas"
      end

      include_examples "get ok"
    end
  end

end