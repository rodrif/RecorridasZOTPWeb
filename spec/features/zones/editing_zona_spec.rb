require 'rails_helper'

RSpec.feature "Editar zona" do

  before do
    @admin = create(:user_admin)
    @referente = create(:user_referente)
    @coordinador = create(:user_coordinador)
    @voluntario = create(:user_voluntario)
    @invitado = create(:user_invitado)
    @area_nueva = create(:area)
  end

  let!(:area) { create(:area) }
  let!(:zona) { create(:zone, area_id: area.id) }
  let(:zona_editada) { build(:zone) }

  context "edita datos satisfactoriamente" do
    scenario "si usuario es administrador" do
      login_as @admin
      visit "/"

      click_link "Configuración"
      click_link "Zonas"
      find("td", :text => zona.nombre).find(:xpath, '../td[5]/a', :class => "glyphicon-edit").click

      fill_in "Nombre", with: zona_editada.nombre
      select @area_nueva.nombre, from: "Sede"
      fill_in "Latitud", with: zona_editada.latitud
      fill_in "Longitud", with: zona_editada.longitud
      click_button "Aceptar"

      expect(page).to have_content("Zona actualizada correctamente")
      expect(current_path).to eq(zones_path)
      expect(page).not_to have_content(zona.nombre)
      expect(page).not_to have_content(zona.longitud)
      expect(page).not_to have_content(zona.latitud)
      expect(page).not_to have_css("td", :text => area.nombre)

      expect(page).to have_content(zona_editada.nombre)
      expect(page).to have_content(zona_editada.longitud)
      expect(page).to have_content(zona_editada.latitud)
      expect(page).to have_css("td", :text => @area_nueva.nombre)
    end

  end
end