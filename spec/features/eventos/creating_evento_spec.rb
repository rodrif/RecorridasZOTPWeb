require 'rails_helper'
RSpec.feature "Crear evento" do

  let!(:area) { create(:area) }
  let!(:admin) { create(:user_admin, area: area)}
  let!(:persona) { create(:person) }
  let(:evento) { build(:evento )}

  def fill_form_and_create evento
    login_as admin
    visit "/"

    click_link "Calendario", match: :first
    click_link DateTime.now.day.to_s

    fill_in "Título", with: evento.titulo
    fill_in "Descripción", with: evento.descripcion

    fill_in "datetimefrom", with: evento.fecha_desde
    fill_in "datetimeto", with: evento.fecha_hasta
    select persona.nombre, from: "Persona"
    fill_in "Ubicación", with: evento.ubicacion

    click_button "Aceptar"
  end

  scenario "satisfactoriamente" do
    fill_form_and_create evento

    expect(page).to have_content("Evento creado correctamente")
  end

  scenario "al crear crea una notificación asociada, una hora antes para todos los roles del area del user" do
    fill_form_and_create evento

    expect(page).to have_content("Evento creado correctamente")

    notificacion = Evento.first.notificacion
    expect(notificacion.titulo).to eq(evento.titulo)
    expect(notificacion.subtitulo).to eq(persona.full_name)
    expect(notificacion.areas).to include(admin.area)
    expect(notificacion.rol_ids).to eq([1,2,3,4])
    expect(notificacion.prox_envio).to eq(evento.fecha_desde.advance(hours: -1).change(:min => 0))
  end

  context "falla al crear" do
    scenario "fecha desde previa a actual falla" do
      evento.fecha_desde = DateTime.now.advance(hours: -1)
      fill_form_and_create evento

      expect(page).to have_content("Fecha desde no puede ser anterior a la hora actual")
    end

    scenario "fecha hasta previa a fecha desde" do
      evento.fecha_hasta = evento.fecha_desde.advance(hours: -1)
      fill_form_and_create evento

      expect(page).to have_content("Fecha hasta no puede ser anterior a la hora de inicio")
    end
  end
end