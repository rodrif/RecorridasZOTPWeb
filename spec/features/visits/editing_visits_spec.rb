require 'rails_helper'
RSpec.feature "Editar visita" do

  def fill_in_visit_form_for_edit
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
  end

  RSpec.shared_examples "update visit" do
    scenario "edita visita satisfactoriamente" do
      login_as user

      fill_in_visit_form_for_edit

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

  context "cuando la fecha de visita está vacía" do
    let(:user) { create(:user_voluntario) }
    let(:visita) { build(:visit)}

    scenario "falla al editar la visita" do
      visita.fecha = nil
      login_as user
      fill_in_visit_form_for_edit

      expect(page).to have_content("Fecha no puede estar en blanco")
    end
  end

  context "cuando la fecha es posterior a la fecha actual" do
    let(:user) { create(:user_voluntario) }
    let(:visita) { build(:visit, fecha: DateTime.now.advance(days: 10))}

    scenario "falla al editar la visita" do
      login_as user
      fill_in_visit_form_for_edit

      expect(page).to have_content("Fecha no pueda ser futura")
    end
  end
end