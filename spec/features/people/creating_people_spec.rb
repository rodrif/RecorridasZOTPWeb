require 'rails_helper'
RSpec.feature "Crear persona" do

  before do
    @admin = create(:user_admin)
    @referente = create(:user_referente)
    @coordinador = create(:user_coordinador)
    @voluntario = create(:user_voluntario)
  end

  let!(:area) { create(:area) }
  let!(:zona) { create(:zone, area: area) }
  let!(:estado) { create(:estado) }
  let!(:institucion) { create(:colegio) }
  let!(:departamento) { create(:departamento) }
  let(:visita) { build(:visit)}
  let(:persona) { create(:person, zone: zona, estado: estado, institucion: institucion, departamento_ids: [departamento.id], visits: [visita]) }

  scenario "usuario administrador ve todos los campos" do
    login_as @admin
    visit "/"

    click_link "Personas"
    click_link "Nueva persona"

    fill_in name: "person[nombre]", with: persona.nombre
    fill_in "Apellido", with: persona.apellido
    fill_in "Dni", with: persona.dni
    fill_in "Fecha nacimiento", with: persona.fecha_nacimiento
    select institucion.nombre, from: "Institución"
    fill_in "Pantalón", with: persona.pantalon
    fill_in "Remera", with: persona.remera
    fill_in name: "person[zapatillas]", with: persona.zapatillas
    select estado.nombre, from: "Estado"
    check departamento.nombre
    fill_in name: "person[visits_attributes][0][direccion]", with: visita.direccion
    fill_in "Latitud", with: visita.latitud
    fill_in "Longitud", with: visita.longitud
    fill_in "Descripción", with: persona.descripcion

    within("#new_person") do
      click_button "Aceptar"
    end

    expect(page).to have_content("Persona creada correctamente")
    expect(current_path).to eq(people_path)
    expect(page).to have_content(persona.nombre)
    expect(page).to have_content(visita.direccion)
    expect(page).to have_content(estado.nombre)
    expect(page).to have_content(departamento.nombre)
  end

end