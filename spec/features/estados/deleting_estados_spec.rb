require 'rails_helper'

RSpec.feature "Borrar Estado" do

  before do
    @admin = create(:user_admin)
    @estado = create(:estado)
  end

  scenario "siendo administrador" do
    login_as @admin
    visit "/"

    click_link "Estados", match: :first

    expect(page).to have_content(@estado.nombre)

    click_link "Borrar"

    expect(page).to have_content("Estado borrado correctamente")
    expect(page).not_to have_content(@estado.nombre)
    expect(current_path).to eq(estados_path)
  end
end