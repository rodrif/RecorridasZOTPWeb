require 'rails_helper'

RSpec.feature "Borrar zona" do

  before do
    @admin = create(:user_admin)
    @referente = create(:user_referente)
    @coordinador = create(:user_coordinador)
    @voluntario = create(:user_voluntario)
    @invitado = create(:user_invitado)
  end

  let!(:area) { create(:area) }
  let!(:zona) { create(:zone, area_id: area.id) }

  context "elimina satisfactoriamente" do
    scenario "si usuario es administrador" do
      login_as @admin
      visit "/"

      click_link "Configuración"
      click_link "Zonas"
      find("td", :text => zona.nombre).find(:xpath, '../td[5]/a', :class => "glyphicon-remove").click

      expect(page).to have_content("Zona borrada correctamente")
      expect(current_path).to eq(zones_path)
      expect(page).not_to have_content(zona.nombre)
    end

    scenario "si usuario es referente" do
      login_as @referente
      visit "/"

      click_link "Configuración"
      click_link "Zonas"
      find("td", :text => zona.nombre).find(:xpath, '../td[5]/a', :class => "glyphicon-remove").click

      expect(page).to have_content("Zona borrada correctamente")
      expect(current_path).to eq(zones_path)
      expect(page).not_to have_content(zona.nombre)
    end

    scenario "si usuario es coodinador" do
      login_as @coordinador
      visit "/"

      click_link "Configuración"
      click_link "Zonas"
      find("td", :text => zona.nombre).find(:xpath, '../td[5]/a', :class => "glyphicon-remove").click

      expect(page).to have_content("Zona borrada correctamente")
      expect(current_path).to eq(zones_path)
      expect(page).not_to have_content(zona.nombre)
    end
  end
end