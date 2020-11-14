require 'rails_helper'

RSpec.feature "Crear sede" do

  before do
    @admin = create(:user_admin)
    @referente = create(:user_referente)
    @coordinador = create(:user_coordinador)
    @voluntario = create(:user_voluntario)
    @invitado = create(:user_invitado)
  end

  let(:area) {build(:area)}

  context "crea satisfoctariamente" do
    scenario "si usuario es administrador" do
      login_as @admin
      visit "/"

      click_link "Configuración"
      click_link "Sedes"
      click_link "Nueva sede"

      fill_in "Nombre", with: area.nombre
      click_button "Aceptar"

      expect(page).to have_content("Sede creada correctamente")
      expect(current_path).to eq(areas_path)
      expect(page).to have_content(area.nombre)
    end

    scenario "si usuario es referente" do
      login_as @referente
      visit "/"

      click_link "Configuración"
      click_link "Sedes"
      click_link "Nueva sede"

      fill_in "Nombre", with: area.nombre
      click_button "Aceptar"

      expect(page).to have_content("Sede creada correctamente")
      expect(current_path).to eq(areas_path)
      expect(page).to have_content(area.nombre)
    end

    scenario "si usuario es coordinador" do
      login_as @coordinador
      visit "/"

      click_link "Configuración"
      click_link "Sedes"
      click_link "Nueva sede"

      fill_in "Nombre", with: area.nombre
      click_button "Aceptar"

      expect(page).to have_content("Sede creada correctamente")
      expect(current_path).to eq(areas_path)
      expect(page).to have_content(area.nombre)
    end

  end

end