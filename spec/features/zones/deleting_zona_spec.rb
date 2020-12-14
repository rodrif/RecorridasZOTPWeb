require 'rails_helper'

RSpec.shared_examples "delete zone" do
  scenario "borra zona satisfactoriamente" do
    login_as user
    visit "/"

    click_link "Zonas"

    find(:xpath, "//tr[contains(., '#{zona.nombre}')]/td/a[@title='Borrar']").click

    expect(page).to have_content("Zona borrada correctamente")
    expect(current_path).to eq(zones_path)
    expect(page).not_to have_content(zona.nombre)
  end
end

RSpec.feature "Borrar zona" do

  let!(:area) { create(:area) }
  let!(:zona) { create(:zone, area_id: area.id) }

  context "siendo administrador" do
    let(:user) { create(:user_admin)}

    include_examples "delete zone"
  end

  context "siendo coordinador" do
    let(:user) { create(:user_coordinador)}

    include_examples "delete zone"
  end

  context "siendo referente" do
    let(:user) { create(:user_referente)}

    include_examples "delete zone"
  end
end