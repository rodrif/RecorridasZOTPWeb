require 'rails_helper'

RSpec.shared_examples "list zone" do
  scenario "lista zonas satisfactoriamente" do
    login_as user
    visit "/"
    click_link "Zonas", match: :first

    expect(page).to have_content(zona.nombre)
    expect(page).to have_content(zona.latitud)
    expect(page).to have_content(zona.latitud)
    expect(page).to have_content(area.nombre)
  end
end

RSpec.feature "Listar zonas" do

  let!(:area) { create(:area) }
  let!(:zona) { create(:zone, area_id: area.id) }

  context "siendo administrador" do
    let(:user) { create(:user_admin) }

    include_examples "list zone"
  end

  context "siendo coordinador" do
    let(:user) { create(:user_coordinador) }

    include_examples "list zone"
  end

  context "siendo referente" do
    let(:user) { create(:user_referente) }

    include_examples "list zone"
  end

  context "siendo voluntario" do
    let(:user) { create(:user_voluntario) }

    scenario "no puede ver las zonas" do
      login_as user
      expect(page).not_to have_link("Zonas")
    end
  end

end