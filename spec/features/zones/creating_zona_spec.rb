require 'rails_helper'

RSpec.feature "Crear zona" do

  before do
    @admin = create(:user_admin)
    @referente = create(:user_referente)
    @coordinador = create(:user_coordinador)
    @voluntario = create(:user_voluntario)
    @invitado = create(:user_invitado)
    @area = create(:area)
  end

  let(:zona) {build(:zone)}

  context "crea satisfoctariamente" do
    scenario "si usuario es administrador" do
      login_as @admin
      visit "/"

      click_link "Configuración"
      click_link "Zonas"
      click_link "Nueva zona"

      fill_in "Nombre", with: zona.nombre
      select @area.nombre, from: "Sede"
      fill_in "Latitud", with: zona.latitud
      fill_in "Longitud", with: zona.longitud
      click_button "Aceptar"

      expect(page).to have_content("Zona creada correctamente")
      expect(current_path).to eq(zones_path)
      expect(page).to have_content(zona.nombre)
      expect(page).to have_content(zona.latitud)
      expect(page).to have_content(zona.latitud)
      expect(page).to have_content(@area.nombre)
    end

    scenario "si usuario es referente" do
      login_as @referente
      visit "/"

      click_link "Configuración"
      click_link "Zonas"
      click_link "Nueva zona"

      fill_in "Nombre", with: zona.nombre
      select @area.nombre, from: "Sede"
      fill_in "Latitud", with: zona.latitud
      fill_in "Longitud", with: zona.longitud
      click_button "Aceptar"

      expect(page).to have_content("Zona creada correctamente")
      expect(current_path).to eq(zones_path)
      expect(page).to have_content(zona.nombre)
      expect(page).to have_content(zona.latitud)
      expect(page).to have_content(zona.latitud)
      expect(page).to have_content(@area.nombre)
    end

    scenario "si usuario es coordinador" do
      login_as @coordinador
      visit "/"

      click_link "Configuración"
      click_link "Zonas"
      click_link "Nueva zona"

      fill_in "Nombre", with: zona.nombre
      select @area.nombre, from: "Sede"
      fill_in "Latitud", with: zona.latitud
      fill_in "Longitud", with: zona.longitud
      click_button "Aceptar"

      expect(page).to have_content("Zona creada correctamente")
      expect(current_path).to eq(zones_path)
      expect(page).to have_content(zona.nombre)
      expect(page).to have_content(zona.latitud)
      expect(page).to have_content(zona.latitud)
      expect(page).to have_content(@area.nombre)
    end


  end

end