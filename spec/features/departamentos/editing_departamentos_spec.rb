require 'rails_helper'

RSpec.feature "Editar area" do

  def fill_in_departamento_edit_form
    visit "/"

    click_link "Áreas", match: :first
    find(:xpath, "//tr[contains(., '#{departamento_existente.nombre}')]/td/a[@title='#{I18n.t("common.ver_editar")}']").click

    fill_in "Nombre", with: departamento.nombre
    click_button "Aceptar"
  end

  let(:user) { create(:user_admin) }
  let!(:departamento_existente) { create(:departamento) }

  context "cuando se carga el nombre " do
    let(:departamento) {build(:departamento)}
    scenario "se edita el area satisfactoriamente" do
      login_as user

      fill_in_departamento_edit_form

      expect(page).to have_content("Área actualizada correctamente")
      expect(current_path).to eq(departamentos_path)
    end
  end

  context "cuando el nombre se deja vacío" do
    let(:departamento) {build(:departamento, nombre: "")}
    scenario "falla con mensaje de error" do
      login_as user

      fill_in_departamento_edit_form

      expect(page).to have_content("Nombre no puede estar en blanco")
    end
  end
end