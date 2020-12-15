require 'rails_helper'

RSpec.shared_examples "edit area" do
  scenario "edita sede satisfactoriamente" do
    login_as user

    visit areas_path

    find(:xpath, "//tr[contains(., '#{area_existente.nombre}')]/td/a[@title='#{I18n.t("common.ver_editar")}']").click

    fill_in "Nombre", with: area.nombre
    click_button "Aceptar"

    expect(page).to have_content("Sede actualizada correctamente")
    expect(current_path).to eq(areas_path)
    expect(page).to have_content(area.nombre)
  end
end

RSpec.feature "Editar sede" do
  let!(:area_existente) {create(:area)}
  let(:area) {build(:area)}

  context "siendo administrador" do
    let(:user) { create(:user_admin)}

    include_examples "edit area"
  end

  context "siendo coordinador" do
    let(:user) { create(:user_coordinador)}

    include_examples "edit area"
  end

  context "siendo referente" do
    let(:user) { create(:user_referente)}

    include_examples "edit area"
  end

  context "cuando el nombre incluye caracteres no alfabéticos" do
    let(:user) { create(:user_admin)}
    scenario "falla al editar" do
      login_as user

      visit "/"

      click_link "Sedes", match: :first
      find(:xpath, "//tr[contains(., '#{area_existente.nombre}')]/td/a[@title='#{I18n.t("common.ver_editar")}']").click

      fill_in "Nombre", with: "ABCDE123456"
      click_button "Aceptar"

      expect(page).to have_content("Nombre solo admite letras")
    end
  end
end