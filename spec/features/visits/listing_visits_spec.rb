require 'rails_helper'

RSpec.shared_examples "list visits" do
  scenario "lista visitas satisfactoriamente" do
    login_as user
    visit "/"

    click_link "Ver Visitas"

    expect(page).to have_xpath("//tr[contains(., '#{persona.nombre}')]")
    expect(page).to have_xpath("//tr[contains(., '#{persona.nombre}')]/td", :text => visita.fecha.to_date)
    expect(page).to have_xpath("//tr[contains(., '#{persona.nombre}')]/td", :text => visita.descripcion)
    expect(page).to have_xpath("//tr[contains(., '#{persona.nombre}')]/td", :text => visita.latitud)
    expect(page).to have_xpath("//tr[contains(., '#{persona.nombre}')]/td", :text => visita.longitud)
    expect(page).to have_xpath("//tr[contains(., '#{persona.nombre}')]/td", :text => visita.direccion)
  end
end

RSpec.feature "Listar visitas" do

  before do
    Person.update_all(state_id: 3)
  end

  let!(:persona) { create(:person) }
  let!(:visita) { create(:visit, person: persona)}

  context "siendo administrador" do
    let(:user) { create(:user_admin) }

    include_examples "list visits"
  end

  context "siendo coordinador" do
    let(:user) { create(:user_coordinador) }

    include_examples "list visits"
  end

  context "siendo referente" do
    let(:user) { create(:user_referente) }

    include_examples "list visits"
  end

  context "siendo voluntario" do
    let(:user) { create(:user_referente) }

    include_examples "list visits"
  end
end