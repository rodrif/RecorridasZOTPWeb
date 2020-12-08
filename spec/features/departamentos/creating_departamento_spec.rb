require 'rails_helper'

RSpec.feature "Crear area" do

  before do
    @admin = create(:user_admin)
  end

  scenario "siendo administrador" do
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