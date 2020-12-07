require 'rails_helper'

RSpec.feature "Listar zonas" do

  before do
    @admin = create(:user_admin)
    @referente = create(:user_referente)
    @coordinador = create(:user_coordinador)
    @voluntario = create(:user_voluntario)
    @invitado = create(:user_invitado)
  end

  let!(:area) { create(:area) }
  let!(:zona) { create(:zone, area_id: area.id) }

  context "puede listar satisfactoriamente" do
    scenario "si usuario es administrador" do
      login_as @admin
      visit "/"

      click_link "Configuración"
      click_link "Zonas"

      expect(page).to have_content(zona.nombre)
      expect(page).to have_content(zona.latitud)
      expect(page).to have_content(zona.latitud)
      expect(page).to have_content(area.nombre)
    end

    scenario "si usuario es referente" do
      login_as @referente
      visit "/"

      click_link "Configuración"
      click_link "Zonas"

      expect(page).to have_content(zona.nombre)
      expect(page).to have_content(zona.latitud)
      expect(page).to have_content(zona.latitud)
      expect(page).to have_content(area.nombre)
    end

    scenario "si usuario es coordinador" do
      login_as @coordinador
      visit "/"

      click_link "Configuración"
      click_link "Zonas"

      expect(page).to have_content(zona.nombre)
      expect(page).to have_content(zona.latitud)
      expect(page).to have_content(zona.latitud)
      expect(page).to have_content(area.nombre)
    end
  end

  context "no puede listar" do
    scenario "si usuario es voluntario" do
      login_as @voluntario
      visit "/"

      click_link "Configuración"

      expect(page).not_to have_link("Zonas")
    end
  end
end