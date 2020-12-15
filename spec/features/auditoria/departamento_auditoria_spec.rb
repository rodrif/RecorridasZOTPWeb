require 'rails_helper'
require 'support/wait_for_ajax'

RSpec.feature "Auditoria de Areas" do
  let!(:departamento) { build(:departamento)}

  context "siendo administrador" do
    let(:admin) { create(:user_admin)}
    before do
      login_as admin
      visit new_departamento_path
      fill_in "Nombre", with: departamento.nombre
      click_button "Aceptar"
    end

    scenario "al crear una nueva area se ve esa accion en la lista de auditoria" do
      visit "/"

      click_link "Auditoría", match: :first

      expect(page).to have_xpath("//tr[contains(., '#{admin.email}')]")
      expect(page).to have_xpath("//tr[contains(., '#{admin.email}')]/td", :text => Auditoria::ALTA)
      expect(page).to have_xpath("//tr[contains(., '#{admin.email}')]/td", :text => Auditoria::DEPARTAMENTO)
    end
  end

end