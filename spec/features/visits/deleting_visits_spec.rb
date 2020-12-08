require 'rails_helper'

RSpec.feature "Borrar visitas" do

  before do
    @admin = create(:user_admin)
    @referente = create(:user_referente)
    @coordinador = create(:user_coordinador)
    @voluntario = create(:user_voluntario)
    Person.update_all(state_id: 3)
  end

  let!(:persona) { create(:person) }
  let!(:visita) { create(:visit, person: persona)}

  scenario "siendo usuario administrador borra" do
    login_as @admin
    visit "/"

    click_link "Visitas"
    find(:xpath, "//tr[contains(., '#{persona.nombre}')]/td/a", :class => "glyphicon-remove").click

    expect(page).to have_content("Visita borrada correctamente")
  end

  scenario "siendo usuario coordinador borra" do
    login_as @coordinador
    visit "/"

    click_link "Visitas"
    expect(page).to have_xpath("//tr[contains(., '#{persona.nombre}')]")
    find(:xpath, "//tr[contains(., '#{persona.nombre}')]/td/a", :class => "glyphicon-remove").click

    expect(page).to have_content("Visita borrada correctamente")
    expect(page).not_to have_xpath("//tr[contains(., '#{persona.nombre}')]")
  end

  scenario "siendo usuario referente borra" do
    login_as @referente
    visit "/"

    click_link "Visitas"
    expect(page).to have_xpath("//tr[contains(., '#{persona.nombre}')]")
    find(:xpath, "//tr[contains(., '#{persona.nombre}')]/td/a", :class => "glyphicon-remove").click

    expect(page).to have_content("Visita borrada correctamente")
    expect(page).not_to have_xpath("//tr[contains(., '#{persona.nombre}')]")
  end

  scenario "siendo usuario voluntario no tiene opción de borrar" do
    login_as @voluntario
    visit "/"

    click_link "Visitas"
    expect(page).not_to have_xpath("//tr[contains(., '#{persona.nombre}')]/td/a", :class => "glyphicon-remove")
  end
end