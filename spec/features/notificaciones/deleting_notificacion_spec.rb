require 'rails_helper'

RSpec.feature "Borrar notificacion" do
  let!(:area) { create(:area) }
  let!(:area) { create(:area) }
  let!(:notificacion) { create(:notificacion_unica,  area_ids: [area.id], rol_ids: [Rol.find_by_nombre("administrador").id] ) }

  context "siendo administrador" do
    let!(:user) {create(:user_admin)}

    scenario "borra satisfactoriamente una notificación existente" do
      login_as user
      visit "/"

      click_link "Notificaciones", match: :first
      find(:xpath, "//tr[contains(., '#{notificacion.titulo}')]/td/a[@title='Borrar']").click

      expect(page).to have_content("Notificación borrada correctamente")
    end
  end
end