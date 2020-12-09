require 'rails_helper'

RSpec.shared_examples "edit user" do
  scenario "edita usuario satisfactoriamente" do
    login_as user

    visit users_path
    find(:xpath, "//tr[contains(., '#{saved.name}')]/td/a", :class => "glyphicon-edit").click

    expect(page).to have_field("Email", readonly: true)
    expect(page).not_to have_field("Contraseña")

    fill_in "Nombre", with: new_data_user.name
    fill_in "Apellido", with: new_data_user.apellido
    fill_in "Teléfono", with: new_data_user.telefono
    select area.nombre, from: "Sede"
    select "referente", from: "Roles"

    click_button "Aceptar"

    expect(page).to have_content("Usuario actualizado correctamente.")
  end
end

RSpec.feature "Editar usuarios" do
  let!(:saved) { create(:user_voluntario) }
  let!(:area) { create(:area) }
  let(:new_data_user) { build(:user) }

  context "siendo administrador" do
    let(:user) { create(:user_admin) }

    it_behaves_like "edit user"
  end

  context "siendo referente" do
    let(:user) { create(:user_referente) }

    it_behaves_like 'edit user'
  end

  context "siendo coordinador" do
    let(:user) { create(:user_coordinador) }

    it_behaves_like 'edit user'
  end
end