require 'rails_helper'

RSpec.feature "Crear area" do

  def fill_in_departamento_create_form
    visit "/"

    click_link "Áreas", match: :first
    click_link "Nueva área"

    fill_in "Nombre", with: departamento.nombre
    click_button "Aceptar"
  end

  let(:user) { create(:user_admin) }

  context "cuando se carga el nombre " do
    let(:departamento) {build(:departamento)}
    scenario "se crea el area satisfactoriamente" do
      login_as user

      fill_in_departamento_create_form

      expect(page).to have_content("Área creada correctamente")
      expect(current_path).to eq(departamentos_path)
    end
  end

  context "cuando el nombre se deja vacío" do
    let(:departamento) {build(:departamento, nombre: "")}
    scenario "falla con mensaje de error" do
      login_as user

      fill_in_departamento_create_form

      expect(page).to have_content("Nombre no puede estar en blanco")
    end
  end
end