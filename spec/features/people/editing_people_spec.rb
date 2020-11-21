require 'rails_helper'

RSpec.feature "Editar persona" do

  before do
    @admin = create(:user_admin)
    @referente = create(:user_referente)
    @coordinador = create(:user_coordinador)
    @voluntario = create(:user_voluntario)
    @institucion = create(:merendero)
  end

  let!(:area) { create(:area) }
  let!(:zona) { create(:zone, area: area) }
  let!(:estado) { create(:estado) }
  let!(:institucion) { create(:colegio) }
  let!(:departamento) { create(:departamento) }
  let(:visita) { build(:visit) }
  let!(:persona) { create(:person, zone: zona, estado: estado, institucion: institucion, departamento_ids: [departamento.id], visits: [visita]) }

  context "cambia datos satisfactoriamente" do
    let!(:institucion_nueva) { create(:institucion) }
    let!(:departamento_nuevo) { create(:departamento) }
    let!(:estado_nuevo) { create(:estado) }
    let(:visita_edit) { build(:visit) }
    let(:persona_nueva) { build(:person)}

    scenario "si usuario es administrador" do
      login_as @admin

      visit people_path
      click_link "Ver / Editar"

      fill_in name: "person[nombre]", with: persona_nueva.nombre
      select institucion_nueva.nombre, from: "Institución"
      select estado_nuevo.nombre, from: "Estado"
      uncheck departamento.nombre
      check departamento_nuevo.nombre
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

  #   scenario "si usuario es coordinador" do
  #     login_as @coordinador
  #
  #     visit instituciones_path
  #     click_link "Ver / Editar"
  #
  #     fill_in "Nombre", with: institucion.nombre
  #     select institucion.institucion_tipo.nombre, from: "Tipo"
  #     fill_in "Descripción", with: institucion.descripcion
  #     fill_in "Dirección", with: institucion.direccion
  #     fill_in "Contacto", with: institucion.contacto
  #     fill_in "Teléfono", with: institucion.telefono
  #     fill_in "Código postal", with: institucion.codigo_postal
  #     find("#institucion_latitud", visible: false).set institucion.latitud
  #     find("#institucion_longitud", visible: false).set institucion.longitud
  #
  #     click_button "Aceptar"
  #
  #     expect(page).to have_content("Institución actualizada correctamente")
  #     expect(current_path).to eq(instituciones_path)
  #     expect(page).to have_content(institucion.nombre)
  #     expect(page).to have_content(institucion.descripcion)
  #     expect(page).to have_content(institucion.institucion_tipo.nombre)
  #     expect(page).to have_content(institucion.direccion)
  #     expect(page).to have_content(institucion.contacto)
  #     expect(page).to have_content(institucion.telefono)
  #     expect(page).to have_content(institucion.codigo_postal)
  #   end
  # end
  #
  # context "no puede editar datos" do
  #   scenario "si usuario es referente" do
  #     login_as @referente
  #
  #     visit instituciones_path
  #     click_link "Ver / Editar"
  #
  #     expect(page).to have_field("Nombre", disabled: true)
  #     expect(page).to have_field("Descripción", disabled: true)
  #     expect(page).to have_field("Dirección", disabled: true)
  #     expect(page).to have_field("Contacto", disabled: true)
  #     expect(page).to have_field("Teléfono", disabled: true)
  #     expect(page).to have_field("Código postal", disabled: true)
  #     expect(page).not_to have_button("Aceptar")
  #   end

  end
end