require 'rails_helper'

describe 'Zonas' do 
  before(:each) do
   load "#{Rails.root}/db/seeds.rb"
  end

  subject { page }

  describe "index page" do    
    before { visit zones_path }

    it "should have preloaded Zones" do
      should have_content('Zonas')
      should have_content('Haedo')
      should have_content('Ramos')
      should have_content('Liniers')
      should have_content('San Justo')
    end
  end

  describe "new page" do    
    before do
      visit zones_path
      click_link('Nueva zona')
    end

    it { find_button('Aceptar') }
  end

  describe "edit page" do
    let(:zona) { Zone.first }
    before { visit edit_zone_path(zona) }

    it { should have_selector('h2', text: 'Zonas') }
  end
  
end