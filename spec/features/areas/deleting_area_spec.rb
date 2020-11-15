require 'rails_helper'

RSpec.feature "Borrar sede" do

  before do
    @admin = create(:user_admin)
    @referente = create(:user_referente)
    @coordinador = create(:user_coordinador)
    @voluntario = create(:user_voluntario)
    @invitado = create(:user_invitado)
    @area = create(:area)
  end

  context "elimina satisfactoriamente" do
    scenario "si usuario es administrador" do
      login_as @admin
      visit "/"

      click_link "Configuración"
      click_link "Sedes"
      find("td", :text => @area.nombre).find(:xpath, '../td[2]/a', :class => "glyphicon-remove").click

      expect(page).to have_content("Sede borrada correctamente")
      expect(current_path).to eq(areas_path)
      expect(page).not_to have_content(@area.nombre)
    end

    scenario "si usuario es referente" do
      login_as @referente
      visit "/"

      click_link "Configuración"
      click_link "Sedes"
      find("td", :text => @area.nombre).find(:xpath, '../td[2]/a', :class => "glyphicon-remove").click

      expect(page).to have_content("Sede borrada correctamente")
      expect(current_path).to eq(areas_path)
      expect(page).not_to have_content(@area.nombre)
    end

    scenario "si usuario es coordinador" do
      login_as @coordinador
      visit "/"

      click_link "Configuración"
      click_link "Sedes"
      find("td", :text => @area.nombre).find(:xpath, '../td[2]/a', :class => "glyphicon-remove").click

      expect(page).to have_content("Sede borrada correctamente")
      expect(current_path).to eq(areas_path)
      expect(page).not_to have_content(@area.nombre)
    end
  end

  context "con zonas asociadas" do
    let!(:zona) { create(:zone, area_id: @area.id) }

    scenario "es rechazado" do
      login_as @referente
      visit areas_path

      find("td", :text => @area.nombre).find(:xpath, '../td[2]/a', :class => "glyphicon-remove").click

      expect(page).to have_content("No se pudo borrar porque el registro esta siendo utilizado.")
      expect(current_path).to eq(areas_path)
      expect(page).to have_content(@area.nombre)
    end
  end


end