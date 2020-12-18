require 'rails_helper'
RSpec.feature "Crear evento" do

  let!(:area) { create(:area) }
  let!(:admin) { create(:user_admin, area: area)}
  let!(:persona) { create(:person) }
  let!(:evento) { create(:evento, person: persona, user: admin )}
  let(:evento_editado) { build(:evento )}

  def fill_in_form_and_edit_evento
    login_as admin
    visit "/"

    click_link "Calendario", match: :first
    click_link evento.titulo, match: :first

    fill_in "Título", with: evento_editado.titulo
    fill_in "Descripción", with: evento_editado.descripcion

    fill_in "datetimefrom", with: evento_editado.fecha_desde
    fill_in "datetimeto", with: evento_editado.fecha_hasta

    click_button "Aceptar"
  end

  context "editar un evento" do
    scenario "satisfactoriamente" do
      fill_in_form_and_edit_evento

      expect(page).to have_content("Evento actualizado correctamente")
      expect(page).to have_content(evento_editado.titulo)
    end
  end

  context "falla al editar" do
    scenario "fecha desde previa a actual falla" do
      evento_editado.fecha_desde = DateTime.now.advance(hours: -1)
      fill_in_form_and_edit_evento

      expect(page).to have_content("Fecha desde no puede ser anterior a la hora actual")
    end

    scenario "fecha hasta previa a fecha desde" do
      evento_editado.fecha_hasta = evento.fecha_desde.advance(hours: -1)
      fill_in_form_and_edit_evento

      expect(page).to have_content("Fecha hasta no puede ser anterior a la hora de inicio")
    end
  end

end