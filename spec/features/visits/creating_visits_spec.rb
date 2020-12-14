require 'rails_helper'


RSpec.shared_examples "create visit" do
  scenario "crea visita satisfactoriamente" do
    login_as user
    visit "/"

    click_link "Nueva Visita"

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
end

RSpec.feature "Crear visita" do

  before do
    Person.update_all(state_id: 3)
  end

  let!(:persona) { create(:person) }
  let(:visita) { build(:visit )}

  context "siendo administrador" do
    let(:user) { create(:user_admin) }

    include_examples "create visit"
  end

  context "siendo coordinador" do
    let(:user) { create(:user_coordinador) }

    include_examples "create visit"
  end

  context "siendo referente" do
    let(:user) { create(:user_referente) }

    include_examples "create visit"
  end

  context "siendo voluntario" do
    let(:user) { create(:user_voluntario) }

    include_examples "create visit"
  end

  context "cuando la persona tiene visitas previas" do
    let(:visita) { build(:visit)}
    let!(:persona_con_visitas) { create(:person, visits: [visita]) }
    let(:visita_nueva) { build(:visit)}
    let(:user) { create(:user_admin) }

    scenario "muestra la dirección de la última visita cargada" do
      login_as user

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