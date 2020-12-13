require 'rails_helper'

def fill_in_form_and_submit()
  visit "/"
  click_link "Nueva Persona"

  fill_in name: "person[nombre]", with: persona.nombre
  fill_in "Apellido", with: persona.apellido
  fill_in "Dni", with: persona.dni
  fill_in "Teléfono", with: persona.telefono
  fill_in "Fecha nacimiento", with: persona.fecha_nacimiento
  select area.nombre, from: "person[area_id]"
  select institucion.nombre, from: "Institución"
  fill_in "Pantalón", with: persona.pantalon
  fill_in "Remera", with: persona.remera
  fill_in "Zapatillas", with: persona.zapatillas
  select estado.nombre, from: "Estado"
  select departamento.nombre, from: "Áreas"
  fill_in name: "person[visits_attributes][0][latitud]", with: visita.latitud
  fill_in name: "person[visits_attributes][0][longitud]", with: visita.longitud
  fill_in "Descripción", with: persona.descripcion

  within("#new_person") do
    click_button "Aceptar"
  end
end

RSpec.shared_examples "create user" do
  scenario "crea usuario con los datos asignados" do
    login_as user

    fill_in_form_and_submit

    expect(page).to have_content("Persona creada correctamente")
    expect(current_path).to eq(people_path)

    expect(page).to have_xpath("//tr[contains(., '#{persona.nombre}')]")
    expect(page).to have_xpath("//tr[contains(., '#{persona.nombre}')]/td", :text => visita.direccion)
    expect(page).to have_xpath("//tr[contains(., '#{persona.nombre}')]/td", :text => institucion.nombre)
    expect(page).to have_xpath("//tr[contains(., '#{persona.nombre}')]/td", :text => estado.nombre)
    expect(page).to have_xpath("//tr[contains(., '#{persona.nombre}')]/td", :text => departamento.nombre)
  end
end

RSpec.feature "Crear persona" do

  before do
    @admin = create(:user_admin)
    @referente = create(:user_referente)
    @coordinador = create(:user_coordinador)
    @voluntario = create(:user_voluntario)
    Person.update_all(state_id: 3)
  end

  context "carga todos los campos satisfactoriamente" do
    let!(:area) { create(:area) }
    let!(:zona) { create(:zone, area: area) }
    let!(:estado) { create(:estado) }
    let!(:institucion) { create(:colegio) }
    let!(:departamento) { create(:departamento) }
    let(:visita) { create(:visit) }
    let(:persona) { build(:person, zone: zona, estado: estado, institucion: institucion, departamento_ids: [departamento.id], visits: [visita]) }

    context "siendo administrador" do
      let(:user) { create(:user_admin)}

      include_examples "create user"
    end

    context "siendo coordinador" do
      let(:user) { create(:user_coordinador)}

      include_examples "create user"
    end

    context "siendo referente" do
      let(:user) { create(:user_referente)}

      include_examples "create user"
    end



    # scenario "siendo administrador carga todos los campos" do
    #   expect(page).to have_select("Estado")
    #   expect(page).to have_css("input", id: "person_dni")
    #   expect(page).to have_css("input", id: "person_fecha_nacimiento")
    #   expect(page).to have_css("input", id: "person_pantalon")
    #   expect(page).to have_css("input", id: "person_remera")
    #   expect(page).to have_css("input", id: "person_zapatillas")
    #   expect(page).to have_css("label", text: "Áreas")
    # end

    scenario "solo nombre, sede y zona" do
      login_as @admin
      visit "/"
      click_link "Nueva Persona"

      fill_in name: "person[nombre]", with: persona.nombre
      select area.nombre, from: "person[area_id]"

      within("#new_person") do
        click_button "Aceptar"
      end

      expect(page).to have_content("Persona creada correctamente")
      expect(current_path).to eq(people_path)
      expect(page).to have_xpath("//tr[contains(., '#{persona.nombre}')]")
    end

    scenario "al crearlo se genera una visita asociada con la dirección cargada" do
      login_as @admin
      visit "/"
      click_link "Nueva Persona"

      fill_in name: "person[nombre]", with: persona.nombre
      select area.nombre, from: "person[area_id]"
      fill_in name: "person[visits_attributes][0][latitud]", with: visita.latitud
      fill_in name: "person[visits_attributes][0][longitud]", with: visita.longitud

      within("#new_person") do
        click_button "Aceptar"
      end

      expect(page).to have_content("Persona creada correctamente")
      find(:xpath, "//tr[contains(., '#{persona.nombre}')]/td/a[@title='Visitas']").click

      expect(current_path).to eq(visits_path(person_id: persona.id))
      expect(page).to have_xpath("//tr[contains(., '#{persona.nombre}')]")
      expect(page).to have_xpath("//tr[contains(., '#{persona.nombre}')]/td", :text => "Persona vista por primera vez")
      expect(page).to have_xpath("//tr[contains(., '#{persona.nombre}')]/td", :text => visita.latitud)
      expect(page).to have_xpath("//tr[contains(., '#{persona.nombre}')]/td", :text => visita.longitud)
      expect(page).to have_xpath("//tr[contains(., '#{persona.nombre}')]/td", :text => visita.direccion)
    end

    scenario "usuario voluntario carga todos los campos, excepto Estado, DNI, Telefono, Fecha de Nac, Pantalón, Remera, Zapatilla que no lo tiene visible" do
      login_as @voluntario
      visit "/"
      click_link "Nueva Persona"

      fill_in name: "person[nombre]", with: persona.nombre
      fill_in name: "person[apellido]", with: persona.apellido
      select area.nombre, from: "person[area_id]"
      select institucion.nombre, from: "Institución"
      fill_in name: "person[visits_attributes][0][latitud]", with: visita.latitud
      fill_in name: "person[visits_attributes][0][longitud]", with: visita.longitud

      expect(page).not_to have_select("Estado")
      expect(page).not_to have_css("input", id: "person_dni")
      expect(page).not_to have_css("input", id: "person_fecha_nacimiento")
      expect(page).not_to have_css("input", id: "person_pantalon")
      expect(page).not_to have_css("input", id: "person_remera")
      expect(page).not_to have_css("input", id: "person_zapatillas")
      expect(page).not_to have_css("label", text: "Áreas")
      expect(page).not_to have_css("textarea", id: "person_descripcion")

      within("#new_person") do
        click_button "Aceptar"
      end

      expect(current_path).to eq(people_path)
      expect(page).to have_content("Persona creada correctamente")
      expect(page).to have_xpath("//tr[contains(., '#{persona.nombre}')]")
      expect(page).to have_xpath("//tr[contains(., '#{persona.nombre}')]/td", :text => visita.direccion)
      expect(page).to have_xpath("//tr[contains(., '#{persona.nombre}')]/td", :text => institucion.nombre)
    end
  end

  context "falla al crear" do
    before do
      Pedido.delete_all
      Visit.delete_all
      Person.delete_all
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