require 'rails_helper'

RSpec.feature "Borrar persona" do

  before do
    @admin = create(:user_admin)
    @referente = create(:user_referente)
    @coordinador = create(:user_coordinador)
    @voluntario = create(:user_voluntario)
    Person.update_all(state_id: 3)
    Visit.update_all(state_id: 3)
  end

  let!(:area) { create(:area) }
  let!(:zona) { create(:zone, area: area) }
  let!(:estado) { create(:estado) }
  let!(:institucion) { create(:colegio) }
  let!(:departamento) { create(:departamento) }
  let(:visita) { build(:visit) }
  let!(:persona) { create(:person, zone: zona, estado: estado, institucion: institucion, departamento_ids: [departamento.id], visits: [visita]) }


  context "elimina persona y sus visitas asociadas" do
    scenario "si usuario es administrador" do
      login_as @admin

      visit people_path
      find(:xpath, "//tr[contains(., '#{persona.nombre}')]/td/a[@title='Borrar']").click

      expect(page).to have_content("Persona borrada correctamente")
      expect(page).not_to have_xpath("//tr[contains(., '#{persona.nombre}')]")
      visit visits_path
      expect(page).not_to have_xpath("//tr[contains(., '#{persona.nombre}')]")
    end

    scenario "si usuario es coordinador" do
      login_as @coordinador

      visit people_path
      find(:xpath, "//tr[contains(., '#{persona.nombre}')]/td/a[@title='Borrar']").click

      expect(page).to have_content("Persona borrada correctamente")
      expect(page).not_to have_xpath("//tr[contains(., '#{persona.nombre}')]")
      visit visits_path
      expect(page).not_to have_xpath("//tr[contains(., '#{persona.nombre}')]")
    end

    scenario "si usuario es referente" do
      login_as @referente

      visit people_path
      find(:xpath, "//tr[contains(., '#{persona.nombre}')]/td/a[@title='Borrar']").click

      expect(page).to have_content("Persona borrada correctamente")
      expect(page).not_to have_xpath("//tr[contains(., '#{persona.nombre}')]")
      visit visits_path
      expect(page).not_to have_xpath("//tr[contains(., '#{persona.nombre}')]")
    end
  end

  context "no puede eliminar" do
    scenario "si usuario es voluntario" do
      login_as @voluntario

      visit people_path

      expect(page).not_to have_xpath("//tr[contains(., '#{persona.nombre}')]/td/a[@title='Borrar']")
    end
  end
end