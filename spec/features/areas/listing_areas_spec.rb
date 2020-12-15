require 'rails_helper'

RSpec.shared_examples "list area" do
  scenario "lista sedes satisfactoriamente" do
    login_as user
    visit "/"
    click_link "Sedes", match: :first

    expect(page).to have_content(area.nombre)
  end
end

RSpec.feature "Listar sedes" do

  let!(:area) {create(:area)}

  context "siendo administrador" do
    let(:user) { create(:user_admin)}

    include_examples "list area"
  end

  context "siendo coordinador" do
    let(:user) { create(:user_coordinador)}

    include_examples "list area"
  end

  context "siendo referente" do
    let(:user) { create(:user_referente)}

    include_examples "list area"
  end

  context "siendo voluntario" do
    let(:voluntario) { create(:user_voluntario)}
    scenario "no tiene acceso a listar areas" do
      login_as voluntario
      visit "/"
      expect(page).not_to have_link("Sedes")
    end
  end
end