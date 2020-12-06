require 'rails_helper'
RSpec.feature "Crear evento" do

  let!(:area) { create(:area) }
  let!(:admin) { create(:user_admin, area: area)}
  let!(:persona) { create(:person) }
  let(:evento) { build(:evento )}

  scenario "siendo administrador" do
    login_as admin
    visit "/"

    click_link "Configuración"
    click_link "Calendario"
    click_link DateTime.now.day.to_s

    fill_in "Título", with: evento.titulo
    fill_in "Descripción", with: evento.descripcion

    select_date_and_time evento.fecha_desde, from: "evento_fecha_desde"
    select_date_and_time evento.fecha_hasta, from: "evento_fecha_hasta"
    select persona.nombre, from: "Persona"
    fill_in "Ubicación", with: evento.ubicacion
    click_button "Aceptar"

    expect(page).to have_content("Evento creado correctamente")
  end
end