require 'rails_helper'

describe 'Ranchadas' do
  before(:each) do
   load "#{Rails.root}/db/seeds.rb"
  end

  subject { page }

  describe "ranchada cambia de zona", :js => true do
    let(:persona) { Person.first }
    let(:familia) { Familia.second }
    let(:ranchada) { Ranchada.find_by_nombre("Famila Rodriguez") }
    before { visit edit_ranchada_path(ranchada) }

    it "should change ranchada coherentemente" do
      expect(familia.zone.nombre).to eq("Haedo")
      expect(persona.zone.nombre).to eq("Haedo")
      expect(persona.ranchada_id).to eq(ranchada.id)
      expect(familia.ranchada_id).to eq(ranchada.id)

      select "Liniers", from: "ranchada_zone_id"
      find('input[name="commit"]').click

      expect(ranchada.reload.zone.nombre).to eq("Liniers")
      expect(persona.reload.zone.nombre).to eq("Liniers")
      expect(familia.reload.zone.nombre).to eq("Liniers")
    end
  end

  # TODO
  # describe "index page" do    
  #   before { visit people_path }

  #   it { should have_content('Personas') }
  # end
  
  # describe "edit page" do   
  #   let(:person) { Person.first }
  #   before { visit edit_person_path(person) }

  #   it "should load person fields" do
  #     should have_field('person[nombre]', with: 'Facundo')
  #     should have_field('person[apellido]', with: 'Rodriguez')
  #     should have_select('person[area_id]', selected: "Zona Oeste")
  #     should have_select('person[zone_id]', selected: "Haedo")
  #     should have_select('person[ranchada_id]', selected: "Famila Rodriguez")
  #     should have_select('person[familia_id]', selected: "Rodriguez")
  #   end
  # end 


end