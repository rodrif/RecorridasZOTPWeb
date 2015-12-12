require 'rails_helper'

describe 'Visitas' do
  before(:each) do
   load "#{Rails.root}/db/seeds.rb"
  end

  subject { page }

  describe "index page" do    
    before { visit visits_path }

    it { should have_content('Visitas') }
  end
  
  describe "edit page" do   
    let(:visita) { Person.find_by_nombre("Facundo").visits.first } 
    before { visit edit_visit_path(visita) }

    it "should load visit fields" do
      should have_field('visit[descripcion]', with: 'Descripcion1')
      should have_field('visit[latitud]', with: '-34.6425867')
      should have_field('visit[longitud]', with: "-58.5659176")
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

end