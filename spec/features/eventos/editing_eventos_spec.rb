require 'rails_helper'
RSpec.feature "Editar eventos" do

  let!(:user) { create(:user_voluntario) }
  let!(:persona) { create(:person) }

  def fill_form_and_edit_evento
    visit eventos_path
    click_link evento.titulo

    fill_in "Título", with: evento_editado.titulo
    fill_in "Descripción", with: evento_editado.descripcion

    fill_in "datetimefrom", with: evento_editado.fecha_desde
    fill_in "datetimeto", with: evento_editado.fecha_hasta
    select persona.nombre, from: "Persona"
    fill_in "Ubicación", with: evento_editado.ubicacion

    click_button "Aceptar"
  end

  context "dado un evento existente" do
    let!(:evento) { create(:evento, person: persona, user: user)}
    let(:evento_editado) { build(:evento, person: persona, user: user)}
    scenario "solo lista los eventos del usuario actaul" do
      login_as user
      fill_form_and_edit_evento

      expect(page).to have_content("Evento actualizado correctamente")
      expect(page).to have_content(evento_editado.titulo)
    end
  end

  context "falla al editar" do
    let!(:evento) { create(:evento, person: persona, user: user)}
    let(:evento_editado) { build(:evento, person: persona, user: user)}
    scenario "cuando fecha desde es previa a actual falla" do
      login_as user
      evento_editado.fecha_desde = DateTime.now.advance(hours: -1)
      fill_form_and_edit_evento

      expect(page).to have_content("Fecha desde no puede ser anterior a la hora actual")
    end

    scenario "cuando fecha hasta es previa a fecha desde" do
      login_as user
      evento_editado.fecha_hasta = evento_editado.fecha_desde.advance(hours: -1)
      fill_form_and_edit_evento

      expect(page).to have_content("Fecha hasta no puede ser anterior a la hora de inicio")
    end
  end
end