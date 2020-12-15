require 'rails_helper'

RSpec.shared_examples "remove institucion" do
  scenario "elimina institucion satisfactoriamente" do
    login_as user
    visit "/"
    click_link "Instituciones", match: :first

    find(:xpath, "//tr[contains(., '#{institucion.nombre}')]/td/a[@title='Borrar']").click

    expect(page).to have_content("Institución borrada correctamente")
    expect(current_path).to eq(instituciones_path)
    expect(page).not_to have_content(institucion.nombre)
  end
end

RSpec.feature "Borrar institución" do
  let!(:institucion) {create(:institucion)}

  context "siendo administrador" do
    let(:user) { create(:user_admin)}

    include_examples "remove institucion"
  end

  context "siendo coordinador" do
    let(:user) { create(:user_coordinador)}

    include_examples "remove institucion"
  end

  context "siendo referente" do
    let(:user) { create(:user_referente)}

    scenario "no puede eliminar" do
      login_as user

      visit instituciones_path

      expect(page).not_to have_link("Borrar")
    end
  end
end