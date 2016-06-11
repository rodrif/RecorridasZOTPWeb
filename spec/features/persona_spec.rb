require 'rails_helper'

describe 'Personas' do
  before(:each) do
   load "#{Rails.root}/db/seeds.rb"
  end

  subject { page }

  describe "borrar persona", js: true do
    let!(:persona) { Person.find_by_nombre("Facundo") }
    before { visit people_path }

    it "validando persona borrada y sus visitas" do
      accept_alert do
        find(:xpath, "//tr[contains(., 'Facundo')]/td/a", :text => 'Borrar').click
      end
      visit people_path
      should_not have_content('Facundo')
      visit visits_path
      should_not have_content('Facundo')

      expect(persona.zone_id).to_not be_nil
      expect(persona.ranchada_id).to_not be_nil
      expect(persona.familia_id).to_not be_nil
      expect(persona.reload.zone_id).to be_nil
      expect(persona.reload.ranchada_id).to be_nil
      expect(persona.reload.familia_id).to be_nil
    end
  end

  describe "index page" do    
    before { visit people_path }

    it { should have_selector('h2', text: 'Personas') }
  end
  
  describe "edit page", js: true do
    let(:person) { Person.find_by_nombre("Facundo") }
    before { visit edit_person_path(person) }

    it "should load person fields" do
      should have_field('person[nombre]', with: 'Facundo')
      should have_field('person[apellido]', with: 'Rodriguez')
      should have_select('person[area_id]', selected: "Zona Oeste")
      should have_select('person[zone_id]', selected: "Haedo")
      should have_select('person[ranchada_id]', selected: "Familia Rodriguez")
      should have_select('person[familia_id]', selected: "Rodriguez")

      fill_in 'person[nombre]', with: 'Facundo test'
      fill_in 'person[apellido]', with: 'Rodriguez test'
      fill_in 'person[dni]', with: '34358272'
      fill_in 'person[fecha_nacimiento]', with: '28/01/1989'
      select "Liniers", from: "person_zone_id"
      select "Estacion liniers", from: "person_ranchada_id"

      find('input[name="commit"]').click
      expect(current_path).to eq(people_path)
      should have_xpath("//tr[contains(., 'Facundo test')]", text: /Facundo test\s*Rodriguez test\s*Zona Oeste\s*Liniers/)

      person.reload
      expect(person.nombre).to eq("Facundo test")
      expect(person.apellido).to eq('Rodriguez test')
      expect(person.zone.nombre).to eq("Liniers")
      expect(person.ranchada.nombre).to eq("Estacion liniers")
      expect(person.dni).to eq(34358272)
      expect(person.fecha_nacimiento.to_s).to eq('1989-01-28')
      # TODO expect(person.familia).to be_nil
    end
  end

  describe "should modals works", :js => true do
    before { visit new_person_path }
    
    it "modals" do
      # Area modal
      should_not have_selector('h4', text: 'Nueva Área')
      click_link 'area_modal'
      should have_selector('h4', text: 'Nueva Área')
      within('#new_area_modal') do
        fill_in 'area[nombre]', with: "Area personaSpec test"
        find('input[name="commit"]').click
      end 
      should_not have_selector('h4', text: 'Nueva Área')
      should have_select('person[area_id]', selected: "Area personaSpec test")

      area = Area.find_by_nombre "Area personaSpec test"
      expect(area).to_not be_nil

      # Zona modal
      should_not have_selector('h4', text: 'Nueva Zona')
      click_link 'zona_modal'
      should have_selector('h4', text: 'Nueva Zona')
      within('#new_zone_modal') do
        select "Area personaSpec test", from: "zone_area_id"
        fill_in 'zone[nombre]', with: "Zona personaSpec test"
        find('input[name="commit"]').click
      end 
      should_not have_selector('h4', text: 'Nueva Zona')
      should have_select('person[zone_id]', selected: "Zona personaSpec test")

      zona = Zone.find_by_nombre "Zona personaSpec test"
      expect(zona).to_not be_nil

      # Ranchada modal
      should_not have_selector('h4', text: 'Nueva Ranchada')
      click_link 'ranchada_modal'
      should have_selector('h4', text: 'Nueva Ranchada')
      within('#new_ranchada_modal') do
        select "Area personaSpec test", from: "ranchada_area_id"
        select "Zona personaSpec test", from: "ranchada_zone_id"
        fill_in 'ranchada[nombre]', with: "Ranchada personaSpec test"
        find('input[name="commit"]').click
      end 
      should_not have_selector('h4', text: 'Nueva Ranchada')
      should have_select('person[ranchada_id]', selected: "Ranchada personaSpec test")

      ranchada = Ranchada.find_by_nombre "Ranchada personaSpec test"
      expect(ranchada).to_not be_nil

      # Familia modal
      should_not have_selector('h4', text: 'Nueva Familia')
      click_link 'familia_modal'
      should have_selector('h4', text: 'Nueva Familia')
      within('#new_familia_modal') do
        select "Area personaSpec test", from: "familia_area_id"
        select "Zona personaSpec test", from: "familia_zone_id"
        select "Ranchada personaSpec test", from: "familia_ranchada_id"
        fill_in 'familia[nombre]', with: "Familia personaSpec test"
        find('input[name="commit"]').click
      end 
      should_not have_selector('h4', text: 'Nueva Familia')
      should have_select('person[familia_id]', selected: "Familia personaSpec test")

      familia = Familia.find_by_nombre "Familia personaSpec test"
      expect(familia).to_not be_nil
    end
  end

end