require 'rails_helper'

RSpec.feature "Borrar institución" do

  before do
    @admin = create(:user_admin)
    @referente = create(:user_referente)
    @coordinador = create(:user_coordinador)
    @institucion = create(:merendero)
  end

  context "elimina satisfactoriamente" do
    scenario "si usuario es administrador" do
      login_as @admin

      visit instituciones_path
      find(:xpath, "//tr[contains(., '#{@institucion.nombre}')]/td/a", :class => "glyphicon-remove").click

      expect(page).to have_content("Institución borrada correctamente")
      expect(current_path).to eq(instituciones_path)
      expect(page).not_to have_content(@institucion.nombre)
    end

    scenario "si usuario es coordinador" do
      login_as @coordinador

      visit instituciones_path
      find(:xpath, "//tr[contains(., '#{@institucion.nombre}')]/td/a", :class => "glyphicon-remove").click

      expect(page).to have_content("Institución borrada correctamente")
      expect(current_path).to eq(instituciones_path)
      expect(page).not_to have_content(@institucion.nombre)
    end
  end

  context "no puede eliminar" do
    scenario "si usuario es referente" do
      login_as @referente

      visit instituciones_path

      expect(page).not_to have_link("Borrar")
    end
  end


end