require 'rails_helper'

RSpec.feature "Ver Areas" do

  before do
    @admin = create(:user_admin)
    @admin.confirm
    @non_admin = create(:user)
    @non_admin.confirm
    @area = create(:departamento)
  end

  scenario "con un usuario administrador" do
    login_as @admin
    visit "/"

    click_link "Configuración"
    click_link "Áreas"

    expect(page).to have_content(@area.nombre)
  end


  scenario "con un usuario no administrador" do
    login_as @non_admin
    visit "/"

    click_link "Configuración"

    expect(page).not_to have_link("Áreas")
  end
end