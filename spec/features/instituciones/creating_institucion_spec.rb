require 'rails_helper'

RSpec.shared_examples "create institucion" do
  scenario "crea institución satisfactoriamente" do
    login_as user

    visit "/"

    click_link "Nueva Institución"

    fill_in "Nombre", with: institucion.nombre
    select institucion.institucion_tipo.nombre, from: "Tipo"
    fill_in "Descripción", with: institucion.descripcion
    fill_in "Dirección", with: institucion.direccion
    fill_in "Contacto", with: institucion.contacto
    fill_in "Teléfono", with: institucion.telefono
    fill_in "Código postal", with: institucion.codigo_postal
    find("#institucion_latitud", visible: false).set institucion.latitud
    find("#institucion_longitud", visible: false).set institucion.longitud

    click_button "Aceptar"

    expect(page).to have_content("Institución creada correctamente")
    expect(current_path).to eq(instituciones_path)
    expect(page).to have_content(institucion.nombre)
    expect(page).to have_content(institucion.descripcion)
    expect(page).to have_content(institucion.institucion_tipo.nombre)
    expect(page).to have_content(institucion.direccion)
    expect(page).to have_content(institucion.contacto)
    expect(page).to have_content(institucion.telefono)
    expect(page).to have_content(institucion.codigo_postal)
  end
end

RSpec.feature "Crear institucion" do

  let(:institucion) {build(:merendero)}

  context "siendo administrador" do
    let(:user) { create(:user_admin)}

    include_examples "create institucion"
  end

  context "siendo coordinador" do
    let(:user) { create(:user_coordinador)}

    include_examples "create institucion"
  end

  context "siendo referente" do
    let(:user) { create(:user_referente)}

    scenario "no puede crear" do
      login_as user
      visit "/"

      expect(page).not_to have_link("Nueva institución")
    end
  end

  context "Falla al crear" do
    let(:user) { create(:user_admin)}

    scenario "Nombre está vacío" do
      login_as user
      visit "/"

      click_link "Nueva Institución"
      click_button "Aceptar"

      expect(current_path).to eq(instituciones_path(institucion))
      expect(page).to have_content("Nombre no puede estar en blanco")
    end

    scenario "Teléfono contiene caracteres no numéricos" do
      login_as user
      visit "/"

      click_link "Nueva Institución"

      fill_in "Nombre", with: institucion.nombre
      fill_in "Teléfono", with: "4345-6789"

      click_button "Aceptar"

      expect(current_path).to eq(instituciones_path)
      expect(page).to have_content("Teléfono solo admite números")
    end
  end

end