require 'rails_helper'

describe 'Familias' do
  before(:each) do
   load "#{Rails.root}/db/seeds.rb"
  end

  subject { page }

  describe "familia cambia de zona" do
    let(:persona) { Person.find_by_nombre("Facundo") }
    let(:familia) { Familia.find_by_nombre("Rodriguez") }
    before { visit edit_familia_path(familia) }

    it "should change zona coherentemente" do
      expect(familia.zone.nombre).to eq("Haedo")
      expect(persona.zone.nombre).to eq("Haedo")

      select "Ramos", from: "familia_zone_id"
      find('input[name="commit"]').click

      expect(familia.reload.zone.nombre).to eq("Ramos")
      expect(persona.reload.zone.nombre).to eq("Ramos")
    end
  end

  describe "familia cambia de ranchada" do
    let(:persona) { Person.find_by_nombre("Facundo") }
    let(:familia) { Familia.find_by_nombre("Rodriguez") }
    before { visit edit_familia_path(familia) }

    it "should change ranchada coherentemente" do
      expect(familia.ranchada.nombre).to eq("Familia Rodriguez")
      expect(persona.ranchada.nombre).to eq("Familia Rodriguez")

      select "Ranchada Aquino", from: "familia_ranchada_id"
      find('input[name="commit"]').click

      expect(familia.reload.ranchada.nombre).to eq("Ranchada Aquino")
      expect(persona.reload.ranchada.nombre).to eq("Ranchada Aquino")
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
  #     should have_select('person[ranchada_id]', selected: "Familia Rodriguez")
  #     should have_select('person[familia_id]', selected: "Rodriguez")
  #   end
  # end 


end