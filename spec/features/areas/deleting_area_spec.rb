require 'rails_helper'

RSpec.feature "Borrar Areas" do

  before do
    @admin = create(:user_admin)
    @admin.confirm
    @area = create(:departamento)
  end

  scenario "con un usuario administrador" do
    login_as @admin
    visit "/"

    nombre_area = @area.nombre

    click_link "Configuración"
    click_link "Áreas"

    expect(page).to have_content(nombre_area)

    click_link "Borrar"

    expect(page).to have_content("Área borrada correctamente")
    expect(page).not_to have_content(nombre_area)
    expect(current_path).to eq(departamentos_path)
  end
end