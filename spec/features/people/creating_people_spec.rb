require 'rails_helper'
RSpec.feature "Crear persona" do

  before do
    @admin = create(:user_admin)
    @referente = create(:user_referente)
    @coordinador = create(:user_coordinador)
    @voluntario = create(:user_voluntario)
  end

  context "crea satisfactoriamente" do
    let!(:area) { create(:area) }
    let!(:zona) { create(:zone, area: area) }
    let!(:estado) { create(:estado) }
    let!(:institucion) { create(:colegio) }
    let!(:departamento) { create(:departamento) }
    let(:visita) { build(:visit)}
    let(:persona) { create(:person, zone: zona, estado: estado, institucion: institucion, departamento_ids: [departamento.id], visits: [visita]) }

    scenario "administrador carga todos los campos" do
      login_as @admin
      visit "/"

      click_link "Personas"
      click_link "Nueva persona"

      fill_in name: "person[nombre]", with: persona.nombre
      fill_in "Apellido", with: persona.apellido
      fill_in "Dni", with: persona.dni
      fill_in "Fecha nacimiento", with: persona.fecha_nacimiento
      select area.nombre, from: "person[area_id]"
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
      tr = find("td", :text => persona.nombre).find(:xpath, '..')
      expect(tr.find(:xpath, 'td[1]')).to have_content(persona.nombre)
      expect(tr.find(:xpath, 'td[2]')).to have_content(visita.direccion)
      expect(tr.find(:xpath, 'td[3]')).to have_content(area.nombre)
      expect(tr.find(:xpath, 'td[4]')).to have_content(zona.nombre)
      expect(tr.find(:xpath, 'td[5]')).to have_content(institucion.nombre)
      expect(tr.find(:xpath, 'td[6]')).to have_content(estado.nombre)
      expect(tr.find(:xpath, 'td[7]')).to have_content(departamento.nombre)
    end

    scenario "usuario administrador carga solo nombre, sede y zona" do
      login_as @admin
      visit "/"

      click_link "Personas"
      click_link "Nueva persona"

      fill_in name: "person[nombre]", with: persona.nombre
      select area.nombre, from: "person[area_id]"

      within("#new_person") do
        click_button "Aceptar"
      end

      expect(page).to have_content("Persona creada correctamente")
      expect(current_path).to eq(people_path)
      expect(page).to have_content(persona.nombre)
      expect(page).to have_content(area.nombre)
      expect(page).to have_content(zona.nombre)
    end

    scenario "usuario coordinador carga todos los campos" do
      login_as @coordinador
      visit "/"

      click_link "Personas"
      click_link "Nueva persona"

      fill_in name: "person[nombre]", with: persona.nombre
      fill_in "Apellido", with: persona.apellido
      fill_in "Dni", with: persona.dni
      fill_in "Fecha nacimiento", with: persona.fecha_nacimiento
      select area.nombre, from: "person[area_id]"
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
      tr = find("td", :text => persona.nombre).find(:xpath, '..')
      expect(tr.find(:xpath, 'td[1]')).to have_content(persona.nombre)
      expect(tr.find(:xpath, 'td[2]')).to have_content(visita.direccion)
      expect(tr.find(:xpath, 'td[3]')).to have_content(area.nombre)
      expect(tr.find(:xpath, 'td[4]')).to have_content(zona.nombre)
      expect(tr.find(:xpath, 'td[5]')).to have_content(institucion.nombre)
      expect(tr.find(:xpath, 'td[6]')).to have_content(estado.nombre)
      expect(tr.find(:xpath, 'td[7]')).to have_content(departamento.nombre)
    end

    scenario "usuario referente carga todos los campos, excepto Estado" do
      login_as @referente
      visit "/"

      click_link "Personas"
      click_link "Nueva persona"

      fill_in name: "person[nombre]", with: persona.nombre
      fill_in "Apellido", with: persona.apellido
      fill_in "Dni", with: persona.dni
      fill_in "Fecha nacimiento", with: persona.fecha_nacimiento
      select area.nombre, from: "person[area_id]"
      select institucion.nombre, from: "Institución"
      fill_in "Pantalón", with: persona.pantalon
      fill_in "Remera", with: persona.remera
      fill_in name: "person[zapatillas]", with: persona.zapatillas
      expect(page).not_to have_selector("Estado")
      check departamento.nombre
      fill_in name: "person[visits_attributes][0][direccion]", with: visita.direccion
      fill_in "Latitud", with: visita.latitud
      fill_in "Longitud", with: visita.longitud
      fill_in "Descripción", with: persona.descripcion

      within("#new_person") do
        click_button "Aceptar"
      end

      expect(current_path).to eq(people_path)
      expect(page).to have_content("Persona creada correctamente")
      tr = find("td", :text => persona.nombre).find(:xpath, '..')
      expect(tr.find(:xpath, 'td[1]')).to have_content(persona.nombre)
      expect(tr.find(:xpath, 'td[2]')).to have_content(visita.direccion)
      expect(tr.find(:xpath, 'td[3]')).to have_content(area.nombre)
      expect(tr.find(:xpath, 'td[4]')).to have_content(zona.nombre)
      expect(tr.find(:xpath, 'td[5]')).to have_content(institucion.nombre)
      expect(tr.find(:xpath, 'td[6]')).to have_content(departamento.nombre)
    end
  end

  context "falla al crear" do
    before do
      Zone.delete_all
    end

    scenario "nombre está vacío" do
      login_as @admin
      visit new_person_path

      within("#new_person") do
        click_button "Aceptar"
      end

      expect(current_path).to eq(people_path)
      expect(page).to have_content("Nombre no puede estar en blanco")
    end

    scenario "nombre contiene números" do
      login_as @admin
      visit new_person_path

      fill_in name: "person[nombre]", with: "ABC123456"

      within("#new_person") do
        click_button "Aceptar"
      end

      expect(current_path).to eq(people_path)
      expect(page).to have_content("Nombre solo admite letras")
    end

    scenario "apellido contiene números" do
      login_as @admin
      visit new_person_path

      fill_in name: "person[nombre]", with: "Nombre"
      fill_in name: "person[apellido]", with: "ABC123456"

      within("#new_person") do
        click_button "Aceptar"
      end

      expect(current_path).to eq(people_path)
      expect(page).to have_content("Apellido solo admite letras")
    end

    scenario "DNI contiene caracteres no numéricos" do
      login_as @admin
      visit new_person_path

      fill_in name: "person[nombre]", with: "Nombre"
      fill_in name: "person[dni]", with: "12.345.678"

      within("#new_person") do
        click_button "Aceptar"
      end

      expect(current_path).to eq(people_path)
      expect(page).to have_content("Dni solo admite números")
    end

    scenario "Teléfono contiene caracteres no numéricos" do
      login_as @admin
      visit new_person_path

      fill_in name: "person[nombre]", with: "Nombre"
      fill_in name: "person[telefono]", with: "4345-6789"

      within("#new_person") do
        click_button "Aceptar"
      end

      expect(current_path).to eq(people_path)
      expect(page).to have_content("Teléfono solo admite números")
    end

    scenario "Zona está vacía" do
      login_as @admin
      visit new_person_path

      fill_in name: "person[nombre]", with: "Nombre"

      within("#new_person") do
        click_button "Aceptar"
      end

      expect(current_path).to eq(people_path)
      expect(page).to have_content("Zona no puede estar en blanco")
    end
  end

end