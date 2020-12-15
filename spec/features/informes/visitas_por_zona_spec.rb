require 'rails_helper'

RSpec.feature "Visitas por zona" do

  context "cuando un usuario carga una visita a una persona" do
    let!(:persona) { create(:person) }
    let(:visita) { build(:visit )}
    let(:admin) { create(:user_admin)}
    before do
      login_as admin
      visit new_visit_path
      within('#new_visit') do
        select persona.nombre, from: "Persona"
        fill_in "Fecha", with: visita.fecha
        fill_in "Comentario", with: visita.descripcion
        fill_in "Latitud", with: visita.latitud
        fill_in "Longitud", with: visita.longitud
        click_button "Aceptar"
      end
    end

    scenario "luego la zona aparece en el listado con una visita cargada" do
      visit informes_visitas_path

      expect(page).to have_xpath("//tr[contains(., '#{persona.zone.nombre}')]")
      expect(page).to have_xpath("//tr[contains(., '#{persona.zone.nombre}')]/td", :text => persona.zone.area.nombre)
    end
  end

end