require 'rails_helper'

RSpec.feature "Voluntarios activos" do
  let!(:departamento) { build(:departamento)}

  context "cuando un usuario realiza una acción" do
    let(:admin) { create(:user_admin)}
    before do
      login_as admin
      visit new_departamento_path
      fill_in "Nombre", with: departamento.nombre
      click_button "Aceptar"
    end

    scenario "luego figura en la pantalla de voluntarios activos" do
      visit "/"

      click_link "Informes", match: :first
      click_link "Voluntarios activos"

      expect(page).to have_xpath("//tr[contains(., '#{admin.email}')]")
      expect(page).to have_xpath("//tr[contains(., '#{admin.email}')]/td", :text => admin.name)
      expect(page).to have_xpath("//tr[contains(., '#{admin.email}')]/td", :text => admin.apellido)
    end
  end

end