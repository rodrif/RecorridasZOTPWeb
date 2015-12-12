require 'rails_helper'

describe 'Areas' do 
  before(:each) do
   load "#{Rails.root}/db/seeds.rb"
  end

  subject { page }

  describe "index page" do    
    before { visit areas_path }

    it { should have_selector('h2', text: 'Areas') }
  end
  
  describe "edit page" do   
    let(:area) { Area.first }
    before { visit edit_area_path(area) }

    it "should load area fields" do
      should have_field('area[nombre]', with: 'Zona Oeste')
      find_button('Aceptar')
    end
  end

end