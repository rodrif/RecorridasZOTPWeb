require 'rails_helper'
RSpec.feature "Editar visita" do

  before do
    @admin = create(:user_admin)
    @referente = create(:user_referente)
    @coordinador = create(:user_coordinador)
    @voluntario = create(:user_voluntario)
  end

  let!(:persona) { create(:person) }
  let!(:visita_guardada) { create(:visit, person: persona)}
  let(:visita) { build(:visit )}

  context "satisfactoriamente" do
    scenario "siendo administrador" do
      login_as @admin
      visit "/"

      click_link "Visitas"
      find(:xpath, "//tr[contains(., '#{persona.nombre}')]/td/a", :class => "glyphicon-edit").click

      within("#edit_visit_#{visita_guardada.id}") do
        select persona.nombre, from: "Persona"
        fill_in "Fecha", with: visita.fecha
        fill_in "Comentario", with: visita.descripcion
        fill_in "Latitud", with: visita.latitud
        fill_in "Longitud", with: visita.longitud
        click_button "Aceptar"
      end

      expect(page).to have_content("Visita actualizada correctamente")
      expect(current_path).to eq(visits_path)

      expect(page).to have_xpath("//tr[contains(., '#{persona.nombre}')]")
      expect(page).to have_xpath("//tr[contains(., '#{persona.nombre}')]/td", :text => visita.fecha.to_date)
      expect(page).to have_xpath("//tr[contains(., '#{persona.nombre}')]/td", :text => visita.descripcion)
      expect(page).to have_xpath("//tr[contains(., '#{persona.nombre}')]/td", :text => visita.latitud)
      expect(page).to have_xpath("//tr[contains(., '#{persona.nombre}')]/td", :text => visita.longitud)
      expect(page).to have_xpath("//tr[contains(., '#{persona.nombre}')]/td", :text => visita.direccion)
    end

    scenario "siendo coordinador" do
      login_as @coordinador
      visit "/"

      click_link "Visitas"
      find(:xpath, "//tr[contains(., '#{persona.nombre}')]/td/a", :class => "glyphicon-edit").click

      within("#edit_visit_#{visita_guardada.id}") do
        select persona.nombre, from: "Persona"
        fill_in "Fecha", with: visita.fecha
        fill_in "Comentario", with: visita.descripcion
        fill_in "Latitud", with: visita.latitud
        fill_in "Longitud", with: visita.longitud
        click_button "Aceptar"
      end

      expect(page).to have_content("Visita actualizada correctamente")
      expect(current_path).to eq(visits_path)

      expect(page).to have_xpath("//tr[contains(., '#{persona.nombre}')]")
      expect(page).to have_xpath("//tr[contains(., '#{persona.nombre}')]/td", :text => visita.fecha.to_date)
      expect(page).to have_xpath("//tr[contains(., '#{persona.nombre}')]/td", :text => visita.descripcion)
      expect(page).to have_xpath("//tr[contains(., '#{persona.nombre}')]/td", :text => visita.latitud)
      expect(page).to have_xpath("//tr[contains(., '#{persona.nombre}')]/td", :text => visita.longitud)
      expect(page).to have_xpath("//tr[contains(., '#{persona.nombre}')]/td", :text => visita.direccion)
    end

    scenario "siendo referente" do
      login_as @referente
      visit "/"

      click_link "Visitas"
      find(:xpath, "//tr[contains(., '#{persona.nombre}')]/td/a", :class => "glyphicon-edit").click

      within("#edit_visit_#{visita_guardada.id}") do
        select persona.nombre, from: "Persona"
        fill_in "Fecha", with: visita.fecha
        fill_in "Comentario", with: visita.descripcion
        fill_in "Latitud", with: visita.latitud
        fill_in "Longitud", with: visita.longitud
        click_button "Aceptar"
      end

      expect(page).to have_content("Visita actualizada correctamente")
      expect(current_path).to eq(visits_path)

      expect(page).to have_xpath("//tr[contains(., '#{persona.nombre}')]")
      expect(page).to have_xpath("//tr[contains(., '#{persona.nombre}')]/td", :text => visita.fecha.to_date)
      expect(page).to have_xpath("//tr[contains(., '#{persona.nombre}')]/td", :text => visita.descripcion)
      expect(page).to have_xpath("//tr[contains(., '#{persona.nombre}')]/td", :text => visita.latitud)
      expect(page).to have_xpath("//tr[contains(., '#{persona.nombre}')]/td", :text => visita.longitud)
      expect(page).to have_xpath("//tr[contains(., '#{persona.nombre}')]/td", :text => visita.direccion)
    end

    scenario "siendo voluntario" do
      login_as @voluntario
      visit "/"

      click_link "Visitas"
      find(:xpath, "//tr[contains(., '#{persona.nombre}')]/td/a", :class => "glyphicon-edit").click

      within("#edit_visit_#{visita_guardada.id}") do
        select persona.nombre, from: "Persona"
        fill_in "Fecha", with: visita.fecha
        fill_in "Comentario", with: visita.descripcion
        fill_in "Latitud", with: visita.latitud
        fill_in "Longitud", with: visita.longitud
        click_button "Aceptar"
      end

      expect(page).to have_content("Visita actualizada correctamente")
      expect(current_path).to eq(visits_path)

      expect(page).to have_xpath("//tr[contains(., '#{persona.nombre}')]")
      expect(page).to have_xpath("//tr[contains(., '#{persona.nombre}')]/td", :text => visita.fecha.to_date)
      expect(page).to have_xpath("//tr[contains(., '#{persona.nombre}')]/td", :text => visita.descripcion)
      expect(page).to have_xpath("//tr[contains(., '#{persona.nombre}')]/td", :text => visita.latitud)
      expect(page).to have_xpath("//tr[contains(., '#{persona.nombre}')]/td", :text => visita.longitud)
      expect(page).to have_xpath("//tr[contains(., '#{persona.nombre}')]/td", :text => visita.direccion)
    end
  end

end