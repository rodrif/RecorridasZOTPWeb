require 'rails_helper'

RSpec.feature "Ver sedes" do

  before do
    @admin = create(:user_admin)
    @admin.confirm
    @non_admin = create(:user)
    @non_admin.confirm
    @departamento = create(:departamento)
  end

  context "siendo administrador" do
    scenario "ve satisfactoriamente" do
      login_as @admin
      visit "/"

      click_link "Configuración"
      click_link "Áreas"

      expect(page).to have_content(@departamento.nombre)
    end
  end

  context "sin ser administrador" do
    scenario "no puede ver" do
      login_as @non_admin
      visit "/"

      click_link "Configuración"

      expect(page).not_to have_link("Áreas")
    end
  end
end