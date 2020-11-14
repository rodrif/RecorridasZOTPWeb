require 'rails_helper'

RSpec.feature "Editar area" do

  before do
    @admin = create(:user_admin)
    @admin.confirm
    @departamento = create(:departamento)
  end

  scenario "siendo administrador" do
    login_as @admin
    visit "/"

    click_link "Configuración"
    click_link "Áreas"
    click_link "Ver / Editar"

    fill_in "Nombre", with: "Casos complejos"
    click_button "Aceptar"

    expect(page).to have_content("Área actualizada correctamente")
    expect(current_path).to eq(departamentos_path)
  end
end