require 'rails_helper'

RSpec.shared_examples "update zone" do
  scenario "edita zona satisfactoriamente" do
    login_as user
    visit "/"

    click_link "Zonas"
    find(:xpath, "//tr[contains(., '#{zona.nombre}')]/td/a[@title='#{I18n.t("common.ver_editar")}']").click

    fill_in "Nombre", with: zona_editada.nombre
    select area_nueva.nombre, from: "Sede"
    fill_in "Latitud", with: zona_editada.latitud
    fill_in "Longitud", with: zona_editada.longitud
    click_button "Aceptar"

    expect(page).to have_content(zona_editada.nombre)
    expect(page).to have_content(zona_editada.longitud)
    expect(page).to have_content(zona_editada.latitud)
    expect(page).to have_css("td", :text => area_nueva.nombre)
  end
end

RSpec.feature "Editar zona" do

  let!(:area) { create(:area) }
  let!(:zona) { create(:zone, area_id: area.id) }
  let!(:area_nueva) { create(:area) }
  let(:zona_editada) { build(:zone) }

  context "siendo administrador" do
    let(:user) { create(:user_admin) }

    include_examples "update zone"
  end

  context "siendo coordinador" do
    let(:user) { create(:user_coordinador) }

    include_examples "update zone"
  end

  context "siendo referente" do
    let(:user) { create(:user_referente) }

    include_examples "update zone"
  end

  context "cuando el nombre tiene caracteres no alfanuméricos" do
    let(:user) { create(:user_admin)}
    scenario "no crea y muestra mensaje de error" do
      login_as user
      visit "/"

      click_link "Zonas"
      find(:xpath, "//tr[contains(., '#{zona.nombre}')]/td/a[@title='#{I18n.t("common.ver_editar")}']").click

      fill_in "Nombre", with: "ABCDE123456!?+="
      click_button "Aceptar"

      expect(page).to have_content("Nombre solo admite letras y números")
    end
  end
end