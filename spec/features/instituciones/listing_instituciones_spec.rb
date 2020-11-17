require 'rails_helper'

RSpec.feature "Listar instituciones" do

  before do
    @admin = create(:user_admin)
    @referente = create(:user_referente)
    @coordinador = create(:user_coordinador)
    @voluntario = create(:user_voluntario)
  end

  let!(:institucion) { create(:merendero) }

  context "puede listar satisfactoriamente" do
    scenario "si usuario es administrador" do
      login_as @admin
      visit "/"

      click_link "Instituciones"

      expect(page).to have_content(institucion.nombre)
      expect(page).to have_content(institucion.descripcion)
      expect(page).to have_content(institucion.institucion_tipo.nombre)
      expect(page).to have_content(institucion.direccion)
      expect(page).to have_content(institucion.contacto)
      expect(page).to have_content(institucion.telefono)
      expect(page).to have_content(institucion.codigo_postal)

    end

    scenario "si usuario es referente" do
      login_as @referente
      visit "/"

      click_link "Instituciones"

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

      click_link "Instituciones"

      expect(page).to have_content(institucion.nombre)
      expect(page).to have_content(institucion.descripcion)
      expect(page).to have_content(institucion.institucion_tipo.nombre)
      expect(page).to have_content(institucion.direccion)
      expect(page).to have_content(institucion.contacto)
      expect(page).to have_content(institucion.telefono)
      expect(page).to have_content(institucion.codigo_postal)

    end
  end

  context "no puede listar" do
    scenario "si usuario es voluntario" do
      login_as @voluntario
      visit "/"

      expect(page).not_to have_link("Instituciones")
    end
  end
end