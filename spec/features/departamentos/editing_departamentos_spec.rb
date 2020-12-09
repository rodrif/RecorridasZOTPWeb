require 'rails_helper'

RSpec.feature "Editar area" do

  before do
    @admin = create(:user_admin)
    @departamento = create(:departamento)
  end

  scenario "siendo administrador" do
    login_as @admin
    visit "/"

    click_link "Configuración"
    click_link "Áreas"
    find(:xpath, "//tr[contains(., '#{@departamento.nombre}')]/td/a", :class => "glyphicon-edit").click

    fill_in "Nombre", with: "Casos complejos"
    click_button "Aceptar"

    expect(page).to have_content("Área actualizada correctamente")
    expect(current_path).to eq(departamentos_path)
  end
end