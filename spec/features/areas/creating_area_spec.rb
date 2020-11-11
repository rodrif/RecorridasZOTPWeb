require 'rails_helper'

RSpec.feature "Crear Areas" do

  before do
    @admin = create(:user_admin)
    @non_admin = create(:user)
    @admin.confirm
    @non_admin.confirm
  end

  scenario "Un usuario administrador crea un area nueva" do
    login_as @admin
    visit "/"

    click_link "Configuración"
    click_link "Áreas"
    click_link "Nueva área"

    fill_in "Nombre", with: "Capital"
    click_button "Aceptar"

    expect(page).to have_content("Área creada correctamente")
    expect(current_path).to eq(departamentos_path)
  end

  scenario "Un usuario no administrador no puede crear areas" do
    login_as @non_admin
    visit "/"
    
    click_link "Configuración"

    expect(page).not_to have_link("Áreas")
  end

end