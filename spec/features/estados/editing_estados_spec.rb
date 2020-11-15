require 'rails_helper'

RSpec.feature "Editar estado" do

  before do
    @admin = create(:user_admin)
    @estado = create(:estado)
  end

  scenario "siendo administrador" do
    login_as @admin
    visit "/"

    click_link "Configuración"
    click_link "Estados"
    click_link "Ver / Editar"

    nuevo_nombre_estado = "Casa"
    fill_in "Nombre", with: nuevo_nombre_estado
    click_button "Aceptar"

    expect(page).to have_content("Estado actualizado correctamente")
    expect(current_path).to eq(estados_path)
    expect(current_path).not_to have_content(@estado.nombre)
    expect(page).to have_content(nuevo_nombre_estado)
  end
end