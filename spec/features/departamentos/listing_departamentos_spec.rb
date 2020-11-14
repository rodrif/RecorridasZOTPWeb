require 'rails_helper'

RSpec.feature "Un usuario quiere ver las areas existentes" do

  before do
    @admin = create(:user_admin)
    @admin.confirm
    @non_admin = create(:user)
    @non_admin.confirm
    @departamento = create(:departamento)
  end

  scenario "siendo administrador" do
    login_as @admin
    visit "/"

    click_link "Configuración"
    click_link "Áreas"

    expect(page).to have_content(@departamento.nombre)
  end


  scenario "sin ser administrador" do
    login_as @non_admin
    visit "/"

    click_link "Configuración"

    expect(page).not_to have_link("Áreas")
  end
end