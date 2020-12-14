require 'rails_helper'

def fill_in_form_estado_and_submit(nombre)
  visit "/"

  click_link "Estados"
  click_link "Nuevo estado"

  fill_in "Nombre", with: nombre
  click_button "Aceptar"
end

RSpec.feature "Crear estado" do

  context "siendo un administrador" do
    let!(:user) {create(:user_admin)}
    scenario "satisfactoriamente al colocar un nombre" do
      login_as user

      fill_in_form_estado_and_submit "Casa"

      expect(page).to have_content("Estado creado correctamente")
      expect(current_path).to eq(estados_path)
    end

    scenario "falla si nombre está vacío" do
      login_as user

      fill_in_form_estado_and_submit ""

      expect(current_path).to eq(estados_path)
      expect(page).to have_content("Nombre no puede estar en blanco")
    end
  end

end