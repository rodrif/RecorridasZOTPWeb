require 'rails_helper'

RSpec.shared_examples "create area" do
  scenario "crea sede satisfactoriamente" do
    login_as user

    visit "/"

    click_link "Sedes", match: :first
    click_link "Nueva sede"

    fill_in "Nombre", with: area.nombre
    click_button "Aceptar"

    expect(page).to have_content("Sede creada correctamente")
    expect(current_path).to eq(areas_path)
    expect(page).to have_content(area.nombre)
  end
end


RSpec.feature "Crear sede" do

  let(:area) {build(:area)}

  context "siendo administrador" do
    let(:user) { create(:user_admin)}

    include_examples "create area"
  end

  context "siendo coordinador" do
    let(:user) { create(:user_coordinador)}

    include_examples "create area"
  end

  context "siendo referente" do
    let(:user) { create(:user_referente)}

    include_examples "create area"
  end

  context "cuando el nombre incluye caracteres no alfabéticos" do
    let(:user) { create(:user_admin)}
    scenario "falla al crear" do
      login_as user

      visit areas_path
      click_link "Nueva sede"

      fill_in "Nombre", with: "ABCDE123456"
      click_button "Aceptar"

      expect(page).to have_content("Nombre solo admite letras")
    end
  end

end