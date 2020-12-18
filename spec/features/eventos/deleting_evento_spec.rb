require 'rails_helper'
RSpec.feature "Borrar evento" do

  let!(:area) { create(:area) }
  let!(:admin) { create(:user_admin, area: area)}
  let!(:persona) { create(:person) }
  let!(:evento) { create(:evento, person: persona, user: admin )}

  context "borrar un evento" do
    scenario "satisfactoriamente" do
      login_as admin
      visit "/"

      click_link "Calendario", match: :first
      click_link evento.titulo, match: :first

      click_link "Eliminar"

      expect(page).to have_content("Evento borrado correctamente")
      expect(page).not_to have_content(evento.titulo)
    end
  end
end