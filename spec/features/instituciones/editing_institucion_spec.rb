require 'rails_helper'

RSpec.feature "Editar institución" do

  before do
    @admin = create(:user_admin)
    @referente = create(:user_referente)
    @coordinador = create(:user_coordinador)
    @institucion = create(:merendero)
  end

  let(:institucion) {build(:universidad)}

  context "cambia datos satisfactoriamente" do
    scenario "si usuario es administrador" do
      login_as @admin

      visit instituciones_path
      find(:xpath, "//tr[contains(., '#{@institucion.nombre}')]/td/a", :class => "glyphicon-edit").click

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

      expect(page).to have_content("Institución actualizada correctamente")
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

      visit instituciones_path
      find(:xpath, "//tr[contains(., '#{@institucion.nombre}')]/td/a", :class => "glyphicon-edit").click

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

      expect(page).to have_content("Institución actualizada correctamente")
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

  context "no puede editar datos" do
    scenario "si usuario es referente" do
      login_as @referente

      visit instituciones_path
      find(:xpath, "//tr[contains(., '#{@institucion.nombre}')]/td/a", :class => "glyphicon-edit").click

      expect(page).to have_field("Nombre", disabled: true)
      expect(page).to have_field("Descripción", disabled: true)
      expect(page).to have_field("Dirección", disabled: true)
      expect(page).to have_field("Contacto", disabled: true)
      expect(page).to have_field("Teléfono", disabled: true)
      expect(page).to have_field("Código postal", disabled: true)
      expect(page).not_to have_button("Aceptar")
    end
  end

  context "Falla al editar" do
    scenario "Nombre está vacío" do
      login_as @admin

      visit instituciones_path
      find(:xpath, "//tr[contains(., '#{@institucion.nombre}')]/td/a", :class => "glyphicon-edit").click

      fill_in "Nombre", with: ""

      click_button "Aceptar"

      expect(current_path).to eq(institucion_path(@institucion))
      expect(page).to have_content("Nombre no puede estar en blanco")
    end

    scenario "Teléfono contiene caracteres no numéricos" do
      login_as @admin

      visit instituciones_path
      find(:xpath, "//tr[contains(., '#{@institucion.nombre}')]/td/a", :class => "glyphicon-edit").click

      fill_in "Nombre", with: institucion.nombre
      fill_in "Teléfono", with: "4345-6789"

      click_button "Aceptar"

      expect(current_path).to eq(institucion_path(@institucion))
      expect(page).to have_content("Teléfono solo admite números")
    end
  end
end