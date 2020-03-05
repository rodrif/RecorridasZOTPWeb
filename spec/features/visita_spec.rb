require 'rails_helper'

xdescribe 'Visitas' do
  before(:each) do
   load "#{Rails.root}/db/seeds.rb"
  end

  subject { page }

  describe "index page", js: true do
    let(:visita) { Person.find_by_nombre("Facundo").visits.first }
    before { visit visits_path }

    it "borrar visita" do
      should have_selector('h2', text: 'Visitas')

      accept_alert do
        should have_xpath("//tr[contains(., 'Facundo')]", count: 1)
        find(:xpath, "//tr[contains(., 'Facundo')]/td/a", :text => 'Borrar').click
      end
      should have_xpath("//tr[contains(., 'Facundo')]", count: 0)
    end
  end
  
  describe "edit page" do   
    let(:visita) { Person.find_by_nombre("Facundo").visits.first } 
    before { visit edit_visit_path(visita) }

    it "should load visit fields" do
      should have_field('visit[descripcion]', with: 'Descripcion1')
      should have_field('visit[latitud]', with: '-34.6425867')
      should have_field('visit[longitud]', with: "-58.5659176")

      fecha = 1.day.ago
      fill_in 'visit[fecha]', with: fecha
      fill_in 'visit[descripcion]', with: "comentario de prueba edit page visita"
      fill_in 'visit[latitud]', with: "-34.642567854"
      fill_in 'visit[longitud]', with: "-58.565912323"

      find('input[name="commit"]').click
      expect(current_path).to eq(visits_path)
      should have_content('Visita actualizada correctamente.')

      should have_xpath("//tr[contains(., 'Facundo')]", text: /Facundo.*comentario de prueba edit page visita/)

      visita.reload
      expect(visita.fecha.to_s).to eq(fecha.to_s)
      expect(visita.descripcion).to eq("comentario de prueba edit page visita")
      expect(visita.latitud).to eq(-34.642567854)
      expect(visita.longitud).to eq(-58.565912323)
    end
  end

  describe "new page" do
    let!(:persona) { Person.find_by_nombre("Gonzalo") }    
    before { visit new_visit_path }

    it "nueva visita" do
      fecha = 2.day.ago
      select "Gonzalo", from: "visit_person_id"
      fill_in 'visit[fecha]', with: fecha
      fill_in 'visit[descripcion]', with: "comentario de prueba new page visita"
      fill_in 'visit[latitud]', with: "-34.6425678"
      fill_in 'visit[longitud]', with: "-58.5659123"

      find('input[name="commit"]').click
      expect(current_path).to eq(visits_path)
      should have_content('Visita creada correctamente.')

      should have_xpath("//tr[contains(., 'Gonzalo')]", text: /Gonzalo.*comentario de prueba new page visita/)

      nuevaVisita = persona.reload.visits.first
      expect(nuevaVisita.fecha.to_s).to eq(fecha.to_s)
      expect(nuevaVisita.descripcion).to eq("comentario de prueba new page visita")
      expect(nuevaVisita.latitud).to eq(-34.6425678)
      expect(nuevaVisita.longitud).to eq(-58.5659123)
    end
  end

  describe "visits link", js: true do
    let!(:persona) { Person.find_by_nombre("Laura") }
    let!(:visita) { persona.visits.activas.first }
    before { visit people_path }

    it "nueva visita con ultima ubicacion de persona" do
      find(:xpath, "//tr[contains(., 'Laura')]/td/a", :text => 'Visitas').click

      assert_current_path(visits_path + "?person_id=#{persona.id}")

      click_link('Nueva visita')

      should have_select('visit[person_id]', selected: "Laura Aquino")
      should have_field('visit[latitud]', with: visita.latitud)
      should have_field('visit[longitud]', with: visita.longitud)
    end
  end

end