require 'rails_helper'

RSpec.feature "Listar personas" do

  before do
    @admin = create(:user_admin)
    @referente = create(:user_referente)
    @coordinador = create(:user_coordinador)
    @voluntario = create(:user_voluntario)
  end

  let!(:area) { create(:area) }
  let!(:zona) { create(:zone, area_id: area.id) }
  let!(:estado) { create(:estado) }
  let!(:institucion) { create(:colegio) }
  let!(:departamento) { create(:departamento) }
  let(:visita) { build(:visit)}
  let!(:persona) { create(:person, zone: zona, estado: estado, institucion: institucion, departamento_ids: [departamento.id], visits: [visita]) }

  context "puede listar satisfactoriamente" do
    scenario "si usuario es administrador" do
      login_as @admin
      visit "/"

      click_link "Personas"

      expect(page).to have_content(persona.nombre)
      expect(page).to have_content(persona.visits.first.direccion)
      expect(page).to have_content(persona.zone.area.nombre)
      expect(page).to have_content(persona.zone.nombre)
      expect(page).to have_content(persona.institucion.nombre)
      expect(page).to have_content(persona.estado.nombre)
      expect(page).to have_content(departamento.nombre)
    end
  end
end