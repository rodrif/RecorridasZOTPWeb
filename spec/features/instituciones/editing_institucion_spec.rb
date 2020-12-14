require 'rails_helper'

def look_for_institucion_and_update()
  visit instituciones_path

  find(:xpath, "//tr[contains(., '#{institucion_existente.nombre}')]/td/a[@title='#{I18n.t("common.ver_editar")}']").click

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
end

RSpec.shared_examples "edit institucion" do
  scenario "edita sede satisfactoriamente" do
    login_as user

    look_for_institucion_and_update

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

RSpec.feature "Editar institución" do

  let!(:institucion_existente) {create(:merendero)}
  let(:institucion) {build(:universidad)}

  context "siendo administrador" do
    let(:user) { create(:user_admin)}

    include_examples "edit institucion"
  end

  context "siendo coordinador" do
    let(:user) { create(:user_coordinador)}

    include_examples "edit institucion"
  end

  context "siendo referente" do
    let(:user) { create(:user_referente)}

    scenario "no puede editar" do
      login_as user

      visit instituciones_path
      find(:xpath, "//tr[contains(., '#{institucion_existente.nombre}')]/td/a[@title='#{I18n.t("common.ver_editar")}']").click

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
    let(:user) { create(:user_admin)}
    scenario "Nombre está vacío" do
      login_as user

      visit instituciones_path
      find(:xpath, "//tr[contains(., '#{institucion_existente.nombre}')]/td/a[@title='#{I18n.t("common.ver_editar")}']").click

      fill_in "Nombre", with: ""

      click_button "Aceptar"

      expect(current_path).to eq(institucion_path(institucion_existente))
      expect(page).to have_content("Nombre no puede estar en blanco")
    end

    scenario "Teléfono contiene caracteres no numéricos" do
      login_as user

      visit instituciones_path
      find(:xpath, "//tr[contains(., '#{institucion_existente.nombre}')]/td/a[@title='#{I18n.t("common.ver_editar")}']").click

      fill_in "Nombre", with: institucion.nombre
      fill_in "Teléfono", with: "4345-6789"

      click_button "Aceptar"

      expect(current_path).to eq(institucion_path(institucion_existente))
      expect(page).to have_content("Teléfono solo admite números")
    end
  end
end