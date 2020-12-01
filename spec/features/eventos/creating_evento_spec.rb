require 'rails_helper'
RSpec.feature "Crear evento" do

  before do
    @admin = create(:user_admin)
  end

  let!(:persona) { create(:person) }
  let(:evento) { build(:evento )}

  scenario "siendo administrador" do
    login_as @admin
    visit new_evento_path

    fill_in "Título", with: evento.titulo
    fill_in "Descripción", with: evento.descripcion
    fill_in "Fecha Desde", with: evento.fecha_desde
    fill_in "Fecha Hasta", with: evento.fecha_hasta
    select persona.nombre, from: "Persona"
    fill_in "Ubicación", with: evento.ubicacion
    click_button "Aceptar"

    expect(page).to have_content("Evento creado correctamente")
  end
end