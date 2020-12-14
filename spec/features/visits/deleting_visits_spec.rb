require 'rails_helper'

RSpec.shared_examples "delete visit" do
  scenario "borra visita satisfactoriamente" do
    login_as user
    visit "/"

    click_link "Ver Visitas"
    find(:xpath, "//tr[contains(., '#{persona.nombre}')]/td/a[@title='Borrar']").click

    expect(page).to have_content("Visita borrada correctamente")
  end
end

RSpec.feature "Borrar visitas" do

  before do
    Person.update_all(state_id: 3)
  end

  let!(:persona) { create(:person) }
  let!(:visita) { create(:visit, person: persona)}

  context "siendo administrador" do
    let(:user) { create(:user_admin) }

    include_examples "delete visit"
  end

  context "siendo coordinador" do
    let(:user) { create(:user_coordinador) }

    include_examples "delete visit"
  end

  context "siendo referente" do
    let(:user) { create(:user_referente) }

    include_examples "delete visit"
  end

  context "siendo voluntario" do
    let(:user) { create(:user_voluntario) }

    include_examples "delete visit"
  end
end