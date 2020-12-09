require 'rails_helper'

RSpec.feature "Crear institucion" do

  before do
    @admin = create(:user_admin)
    @referente = create(:user_referente)
    @coordinador = create(:user_coordinador)
  end

  let(:institucion) {build(:merendero)}

  context "crea satisfoctariamente" do
    scenario "si usuario es administrador" do
      login_as @admin
      visit "/"

      visit instituciones_path
      click_link "Nueva institución"

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

    scenario "si usuario es coordinador" do
      login_as @coordinador
      visit "/"

      visit instituciones_path
      click_link "Nueva institución"

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

  context "No puede crear" do
    scenario "si es usuario referente" do
      login_as @referente
      visit "/"

      visit instituciones_path
      expect(page).not_to have_link("Nueva institución")
    end
  end

  context "Falla al crear" do
    scenario "Nombre está vacío" do
      login_as @admin
      visit "/"

      visit instituciones_path
      click_link "Nueva institución"

      click_button "Aceptar"

      expect(current_path).to eq(instituciones_path(@institucion))
      expect(page).to have_content("Nombre no puede estar en blanco")
    end

    scenario "Teléfono contiene caracteres no numéricos" do
      login_as @admin
      visit "/"

      visit instituciones_path
      click_link "Nueva institución"

      fill_in "Nombre", with: institucion.nombre
      fill_in "Teléfono", with: "4345-6789"

      click_button "Aceptar"

      expect(current_path).to eq(instituciones_path)
      expect(page).to have_content("Teléfono solo admite números")
    end
  end

end