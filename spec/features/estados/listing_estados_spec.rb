require 'rails_helper'

RSpec.feature "Ver estados" do

  before do
    @admin = create(:user_admin)
    @referente = create(:user_referente)
    @coordinador = create(:user_coordinador)
    @voluntario = create(:user_voluntario)
    @estado = create(:estado)
  end

  context "ve satisfactoriamenter" do
    scenario "si es administrador" do
      login_as @admin
      visit "/"

      click_link "Configuración"
      click_link "Estados"

      expect(page).to have_content(@estado.nombre)
    end
  end

  context "no puede verlos" do
    scenario "si es referente" do
      login_as @referente
      visit "/"

      click_link "Configuración"

      expect(page).not_to have_link("Estados")
    end

    scenario "si es coodinador" do
      login_as @coordinador
      visit "/"

      click_link "Configuración"

      expect(page).not_to have_link("Estados")
    end

    scenario "si es voluntario" do
      login_as @voluntario
      visit "/"

      click_link "Configuración"

      expect(page).not_to have_link("Estados")
    end
  end
end