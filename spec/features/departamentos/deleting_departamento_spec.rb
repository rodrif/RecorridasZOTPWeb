require 'rails_helper'

RSpec.feature "Borrar Area" do

  before do
    @admin = create(:user_admin)
    @departamento = create(:departamento)
  end

  scenario "siendo administrador" do
    login_as @admin
    visit "/"

    @departamento.nombre

    click_link "Configuración"
    click_link "Áreas"

    expect(page).to have_content(@departamento.nombre)

    click_link "Borrar"

    expect(page).to have_content("Área borrada correctamente")
    expect(page).not_to have_content(@departamento.nombre)
    expect(current_path).to eq(departamentos_path)
  end
end