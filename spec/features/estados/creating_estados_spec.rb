require 'rails_helper'

RSpec.feature "Crear estado" do

  before do
    @admin = create(:user_admin)
  end

  scenario "siendo administrador" do
    login_as @admin
    visit "/"

    click_link "Configuración"
    click_link "Estados"
    click_link "Nuevo estado"

    fill_in "Nombre", with: "Casa"
    click_button "Aceptar"

    expect(page).to have_content("Estado creado correctamente")
    expect(current_path).to eq(estados_path)
  end
end