require 'rails_helper'

RSpec.feature "Creating Articles" do

  before do
    @rol_admin = Rol.create!(nombre: "admin", puede_ver_web: 1)
    @admin = User.create!(email: "admin@example.com", password: "password", rol: @rol_admin)
    @admin.confirm
    login_as(@admin)
  end

  scenario "Un usuario administrador crea un area nueva" do
    visit "/"

    click_link "Configuración"
    click_link "Áreas"
    click_link "Nueva área"

    fill_in "Nombre", with: "Capital"
    click_button "Aceptar"

    expect(page).to have_content("Área creada correctamente")
    expect(current_path).to eq(departamentos_path)
  end

end