require 'rails_helper'

RSpec.feature "Ver sedes" do

  before do
    @area = create(:area)
  end

  context "ve satisfoctariamente" do
    scenario "si usuario es administrador" do
      let(:admin) { create(:user_admin) }
      login_as @admin
      visit "/"

      click_link "Configuración"
      click_link "Sedes"

      expect(page).to have_content(@area.nombre)
    end
  end
end