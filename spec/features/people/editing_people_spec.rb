require 'rails_helper'

RSpec.shared_examples "update user" do
  scenario "actualiza datos satisfactoriamente" do
    login_as user

    visit people_path

    find(:xpath, "//tr[contains(., '#{persona.nombre}')]/td/a[@title='#{I18n.t("common.ver_editar")}']").click

    fill_in name: "person[nombre]", with: persona_nueva.nombre
    select institucion_nueva.nombre, from: "Institución"
    select estado_nuevo.nombre, from: "Estado"
    unselect departamento.nombre, from: "Áreas"
    select departamento_nuevo.nombre, from: "Áreas"
    fill_in name: "person[visits_attributes][0][latitud]", with: visita_edit.latitud
    fill_in name: "person[visits_attributes][0][longitud]", with: visita_edit.longitud

    within("#edit_person_#{persona.id}") do
      click_button "Aceptar"
    end

    expect(page).to have_content("Persona actualizada correctamente")
    expect(current_path).to eq(people_path)
    tr = find("td", :text => persona_nueva.nombre).find(:xpath, '..')
    expect(tr.find(:xpath, 'td[1]')).to have_content(persona_nueva.nombre)
    expect(tr.find(:xpath, 'td[2]')).to have_content(visita_edit.direccion)
    expect(tr.find(:xpath, 'td[5]')).to have_content(institucion_nueva.nombre)
    expect(tr.find(:xpath, 'td[6]')).to have_content(estado_nuevo.nombre)
    expect(tr.find(:xpath, 'td[7]')).to have_content(departamento_nuevo.nombre)
  end
end

RSpec.feature "Editar persona" do

  before do
    Person.update_all(state_id: 3)
  end

  let!(:area) { create(:area) }
  let!(:zona) { create(:zone, area: area) }
  let!(:estado) { create(:estado) }
  let!(:institucion) { create(:colegio) }
  let!(:departamento) { create(:departamento) }
  let(:visita) { build(:visit) }
  let!(:persona) { create(:person, zone: zona, estado: estado, institucion: institucion, departamento_ids: [departamento.id], visits: [visita]) }

  let!(:institucion_nueva) { create(:institucion) }
  let!(:departamento_nuevo) { create(:departamento) }
  let!(:estado_nuevo) { create(:estado) }
  let(:visita_edit) { build(:visit) }
  let(:persona_nueva) { build(:person)}

  context "siendo administrador" do
    let(:user) { create(:user_admin) }

    include_examples "update user"
  end

  context "siendo coordinador" do
    let(:user) { create(:user_coordinador) }

    include_examples "update user"
  end

  context "siendo referente" do
    let(:user) { create(:user_referente) }

    include_examples "update user"
  end

  context "siendo voluntario" do
    let(:user) { create(:user_voluntario) }

    scenario "no puede editar los datos" do
      login_as user

      visit people_path
      find(:xpath, "//tr[contains(., '#{persona.nombre}')]/td/a[@title='#{I18n.t("common.ver_editar")}']").click

      expect(page).to have_field(name: "person[nombre]", disabled: true)
      expect(page).to have_field(name: "person[apellido]", disabled: true)
      expect(page).to have_field(name: "person[area_id]", disabled: true)
      expect(page).to have_field(name: "person[zone_id]", disabled: true)
      expect(page).to have_field(name: "person[institucion_id]", disabled: true)
      expect(page).to have_field(name: "person[visits_attributes][0][direccion]", disabled: true)
      expect(page).to have_field(name: "person[visits_attributes][0][latitud]", disabled: true)
      expect(page).to have_field(name: "person[visits_attributes][0][longitud]", disabled: true)
    end
  end

  context "cuando el nombre está vacío" do
    let(:user) { create(:user_admin) }

    scenario "falla al editar" do
      login_as user

      visit people_path
      find(:xpath, "//tr[contains(., '#{persona.nombre}')]/td/a[@title='#{I18n.t("common.ver_editar")}']").click

      fill_in name: "person[nombre]", with: ""

      within("#edit_person_#{persona.id}") do
        click_button "Aceptar"
      end

      expect(current_path).to eq(person_path(persona))
      expect(page).to have_content("Nombre no puede estar en blanco")
    end
  end

end