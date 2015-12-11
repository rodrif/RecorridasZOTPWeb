require 'rails_helper'

describe 'Visitas' do
  before(:each) do
   load "#{Rails.root}/db/seeds.rb"
  end

  subject { page }

  describe "visita index", js: true do
    let(:persona) { Person.find_by_nombre("Facundo") }
    before { visit people_path }

    it "no deberia mostrar visitas de una persona borrada" do
      accept_alert do
        find(:xpath, "//tr[contains(., 'Facundo')]/td/a", :text => 'Borrar').click
      end
      visit visits_path
      
      should_not have_content('Facundo')
    end
  end


end