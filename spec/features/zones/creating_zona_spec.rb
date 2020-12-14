require 'rails_helper'

def fill_in_form_and_submit()
  visit "/"

  click_link "Zonas"
  click_link "Nueva zona"

  fill_in "Nombre", with: zona.nombre
  select area.nombre, from: "Sede"
  fill_in "Latitud", with: zona.latitud
  fill_in "Longitud", with: zona.longitud

  click_button "Aceptar"
end

RSpec.shared_examples "create zone" do
  scenario "crea zona satisfactoriamente" do
    login_as user

    fill_in_form_and_submit

    expect(page).to have_content("Zona creada correctamente")
    expect(current_path).to eq(zones_path)

    expect(page).to have_xpath("//tr[contains(., '#{zona.nombre}')]")
    expect(page).to have_xpath("//tr[contains(., '#{zona.nombre}')]/td", :text => zona.latitud)
    expect(page).to have_xpath("//tr[contains(., '#{zona.nombre}')]/td", :text => zona.longitud)
    expect(page).to have_xpath("//tr[contains(., '#{zona.nombre}')]/td", :text => area.nombre)
  end
end

RSpec.feature "Crear zona" do

  let!(:area) {create(:area)}
  let(:zona) {build(:zone)}

  context "siendo administrador" do
    let(:user) { create(:user_admin)}

    include_examples "create zone"
  end

  context "siendo coordinador" do
    let(:user) { create(:user_coordinador)}

    include_examples "create zone"
  end

  context "siendo referente" do
    let(:user) { create(:user_referente)}

    include_examples "create zone"
  end

  context "cuando el nombre tiene caracteres no alfanuméricos" do
    let(:user) { create(:user_admin)}
    scenario "no crea y muestra mensaje de error" do
      login_as user

      visit zones_path
      click_link "Nueva zona"

      fill_in "Nombre", with: "ABCDE123456!?+="
      click_button "Aceptar"

      expect(page).to have_content("Nombre solo admite letras y números")
    end
  end

end