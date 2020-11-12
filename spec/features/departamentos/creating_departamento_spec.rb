require 'rails_helper'

RSpec.feature "Crear Areas" do

  before do
    @admin = create(:user_admin)
    @admin.confirm
  end

  scenario "con un usuario administrador" do
    login_as @admin
    visit "/"

    click_link "Configuración"
    click_link "Áreas"
    click_link "Nueva área"

    fill_in "Nombre", with: "Psicologia"
    click_button "Aceptar"

    expect(page).to have_content("Área creada correctamente")
    expect(current_path).to eq(departamentos_path)
  end
end