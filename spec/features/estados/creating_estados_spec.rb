require 'rails_helper'

RSpec.feature "Crear estado" do

  before do
    @admin = create(:user_admin)
  end

  scenario "satisfactoriamente siendo admin" do
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

  scenario "falla si nombre está vacío" do
    login_as @admin
    visit "/"

    click_link "Configuración"
    click_link "Estados"
    click_link "Nuevo estado"

    fill_in "Nombre", with: ""
    click_button "Aceptar"

    expect(current_path).to eq(estados_path)
    expect(page).to have_content("Nombre no puede estar en blanco")
  end
end