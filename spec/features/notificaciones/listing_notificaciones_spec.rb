require 'rails_helper'

RSpec.shared_examples "list notificaciones" do
  scenario "lista notificaciones satisfactoriamente" do
    login_as user
    visit "/"
    click_link "Notificaciones", match: :first

    expect(page).to have_content(notificacion.titulo)
    expect(page).to have_content(notificacion.subtitulo)
    expect(page).to have_content(notificacion.fecha_desde)
  end
end

RSpec.feature "Listar notificaciones" do

  let!(:area) { create(:area) }
  let!(:notificacion) { create(:notificacion_unica,  area_ids: [area.id], rol_ids: [Rol.find_by_nombre("administrador").id] ) }

  context "siendo administrador" do
    let(:user) { create(:user_admin) }

    include_examples "list notificaciones"
  end

  context "siendo referente" do
    let(:user) { create(:user_referente) }

    include_examples "list notificaciones"
  end

  context "siendo coordinador" do
    let(:user) { create(:user_coordinador) }

    scenario "no puede ver las notificaciones" do
      login_as user
      expect(page).not_to have_link("Notificaciones")
    end
  end

  context "siendo voluntario" do
    let(:user) { create(:user_voluntario) }

    scenario "no puede ver las notificaciones" do
      login_as user
      expect(page).not_to have_link("Notificaciones")
    end
  end

end