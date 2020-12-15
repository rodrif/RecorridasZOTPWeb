require 'rails_helper'

RSpec.feature "Editar estado" do

  before do
    @admin = create(:user_admin)
    @estado = create(:estado)
  end

  scenario "satisfactoriamente" do
    login_as @admin
    visit "/"

    click_link "Estados", match: :first
    click_link "Ver / Editar"

    nuevo_nombre_estado = "Casa"
    fill_in "Nombre", with: nuevo_nombre_estado
    click_button "Aceptar"

    expect(page).to have_content("Estado actualizado correctamente")
    expect(current_path).to eq(estados_path)
    expect(current_path).not_to have_content(@estado.nombre)
    expect(page).to have_content(nuevo_nombre_estado)
  end

  scenario "falla si nombre está vacío" do
    login_as @admin
    visit "/"

    click_link "Estados", match: :first
    click_link "Ver / Editar"

    fill_in "Nombre", with: ""
    click_button "Aceptar"

    expect(current_path).to eq(estado_path(@estado))
    expect(page).to have_content("Nombre no puede estar en blanco")
  end
end