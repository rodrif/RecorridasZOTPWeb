require 'rails_helper'

RSpec.shared_examples "remove area" do
  scenario "elimina sede satisfactoriamente" do
    login_as user
    visit "/"
    click_link "Sedes", match: :first

    find(:xpath, "//tr[contains(., '#{area.nombre}')]/td/a[@title='Borrar']").click

    expect(page).to have_content("Sede borrada correctamente")
    expect(current_path).to eq(areas_path)
    expect(page).not_to have_content(area.nombre)
  end
end

RSpec.feature "Borrar sede" do

  let!(:area) {create(:area)}

  context "siendo administrador" do
    let(:user) { create(:user_admin)}

    include_examples "remove area"
  end

  context "siendo coordinador" do
    let(:user) { create(:user_coordinador)}

    include_examples "remove area"
  end

  context "siendo referente" do
    let(:user) { create(:user_referente)}

    include_examples "remove area"
  end

  context "cuando tiene zonas asociadas" do
    let!(:zona) { create(:zone, area_id: area.id) }
    let(:user) { create(:user_referente)}

    scenario "no permite borrar" do
      login_as user
      visit areas_path

      find(:xpath, "//tr[contains(., '#{area.nombre}')]/td/a[@title='Borrar']").click

      expect(page).to have_content("No se pudo borrar porque el registro esta siendo utilizado.")
      expect(current_path).to eq(areas_path)
      expect(page).to have_content(area.nombre)
    end
  end


end