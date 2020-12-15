require 'rails_helper'

RSpec.feature "Fechas de cumpeeaños" do

  context "cuando existen personas activas en la base de datos" do
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

    scenario "luego esas personas y sus cumpleaños figuran en el informe" do
      visit "/"

      click_link "Informes", match: :first
      click_link "Fecha de cumpleaños"

      expect(page).to have_xpath("//tr[contains(., '#{persona.nombre}')]")
      expect(page).to have_xpath("//tr[contains(., '#{persona.nombre}')]/td", :text => persona.apellido)
    end
  end

end