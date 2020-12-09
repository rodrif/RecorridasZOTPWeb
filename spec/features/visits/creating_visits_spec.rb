require 'rails_helper'
RSpec.feature "Crear visita" do

  before do
    @admin = create(:user_admin)
    @referente = create(:user_referente)
    @coordinador = create(:user_coordinador)
    @voluntario = create(:user_voluntario)
    Person.update_all(state_id: 3)
  end

  let!(:persona) { create(:person) }
  let(:visita) { build(:visit )}

  scenario "siendo administrador" do
    login_as @admin
    visit "/"

    click_link "Visitas"
    click_link "Nueva visita"

    within('#new_visit') do
      select persona.nombre, from: "Persona"
      fill_in "Fecha", with: visita.fecha
      fill_in "Comentario", with: visita.descripcion
      fill_in "Latitud", with: visita.latitud
      fill_in "Longitud", with: visita.longitud
      click_button "Aceptar"
    end

    expect(page).to have_content("Visita creada correctamente")
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
    click_link "Nueva visita"

    within('#new_visit') do
      select persona.nombre, from: "Persona"
      fill_in "Fecha", with: visita.fecha
      fill_in "Comentario", with: visita.descripcion
      fill_in "Latitud", with: visita.latitud
      fill_in "Longitud", with: visita.longitud
      click_button "Aceptar"
    end

    expect(page).to have_content("Visita creada correctamente")
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
    click_link "Nueva visita"

    within('#new_visit') do
      select persona.nombre, from: "Persona"
      fill_in "Fecha", with: visita.fecha
      fill_in "Comentario", with: visita.descripcion
      fill_in "Latitud", with: visita.latitud
      fill_in "Longitud", with: visita.longitud
      click_button "Aceptar"
    end

    expect(page).to have_content("Visita creada correctamente")
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
    click_link "Nueva visita"

    within('#new_visit') do
      select persona.nombre, from: "Persona"
      fill_in "Fecha", with: visita.fecha
      fill_in "Comentario", with: visita.descripcion
      fill_in "Latitud", with: visita.latitud
      fill_in "Longitud", with: visita.longitud
      click_button "Aceptar"
    end

    expect(page).to have_content("Visita creada correctamente")
    expect(current_path).to eq(visits_path)

    expect(page).to have_xpath("//tr[contains(., '#{persona.nombre}')]")
    expect(page).to have_xpath("//tr[contains(., '#{persona.nombre}')]/td", :text => visita.fecha.to_date)
    expect(page).to have_xpath("//tr[contains(., '#{persona.nombre}')]/td", :text => visita.descripcion)
    expect(page).to have_xpath("//tr[contains(., '#{persona.nombre}')]/td", :text => visita.latitud)
    expect(page).to have_xpath("//tr[contains(., '#{persona.nombre}')]/td", :text => visita.longitud)
    expect(page).to have_xpath("//tr[contains(., '#{persona.nombre}')]/td", :text => visita.direccion)
  end

  context "persona con visitas existentes" do
    let(:visita) { build(:visit)}
    let!(:persona_con_visitas) { create(:person, visits: [visita]) }
    let(:visita_nueva) { build(:visit)}

    scenario "muestra la dirección de la última visita cargada" do
      login_as @admin

      visit people_path
      expect(page).to have_xpath("//tr[contains(., '#{persona_con_visitas.nombre}')]/td", :text => visita.direccion)

      visit new_visit_path
      within('#new_visit') do
        select persona_con_visitas.nombre, from: "Persona"
        fill_in "Fecha", with: visita_nueva.fecha
        fill_in "Comentario", with: visita_nueva.descripcion
        fill_in "Latitud", with: visita_nueva.latitud
        fill_in "Longitud", with: visita_nueva.longitud
        click_button "Aceptar"
      end

      visit people_path
      expect(page).to have_xpath("//tr[contains(., '#{persona_con_visitas.nombre}')]/td", :text => visita_nueva.direccion)
    end
  end



end