require 'rails_helper'
RSpec.feature "Editar visita" do

  RSpec.shared_examples "update visit" do
    scenario "edita visita satisfactoriamente" do
      login_as user
      visit "/"

      click_link "Ver Visitas"
      find(:xpath, "//tr[contains(., '#{persona.nombre}')]/td/a[@title='#{I18n.t("common.ver_editar")}']").click

      within("#edit_visit_#{visita_guardada.id}") do
        select persona.nombre, from: "Persona"
        fill_in "Fecha", with: visita.fecha
        fill_in "Comentario", with: visita.descripcion
        fill_in "Latitud", with: visita.latitud
        fill_in "Longitud", with: visita.longitud
        click_button "Aceptar"
      end

      expect(page).to have_content("Visita actualizada correctamente")
      expect(current_path).to eq(visits_path)

      expect(page).to have_xpath("//tr[contains(., '#{persona.nombre}')]")
      expect(page).to have_xpath("//tr[contains(., '#{persona.nombre}')]/td", :text => visita.fecha.to_date)
      expect(page).to have_xpath("//tr[contains(., '#{persona.nombre}')]/td", :text => visita.descripcion)
      expect(page).to have_xpath("//tr[contains(., '#{persona.nombre}')]/td", :text => visita.latitud)
      expect(page).to have_xpath("//tr[contains(., '#{persona.nombre}')]/td", :text => visita.longitud)
      expect(page).to have_xpath("//tr[contains(., '#{persona.nombre}')]/td", :text => visita.direccion)
    end
  end

  before do
    Person.update_all(state_id: 3)
  end

  let!(:persona) { create(:person) }
  let!(:visita_guardada) { create(:visit, person: persona)}
  let(:visita) { build(:visit )}

  context "siendo administrador" do
    let(:user) { create(:user_admin) }

    include_examples "update visit"
  end

  context "siendo coordinador" do
    let(:user) { create(:user_coordinador) }

    include_examples "update visit"
  end

  context "siendo referente" do
    let(:user) { create(:user_referente) }

    include_examples "update visit"
  end

  context "siendo voluntario" do
    let(:user) { create(:user_voluntario) }

    include_examples "update visit"
  end
end