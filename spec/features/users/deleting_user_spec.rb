require 'rails_helper'

RSpec.shared_examples "delete user" do
  scenario "borra usuario satisfactoriamente" do
    login_as user
    visit users_path

    find(:xpath, "//tr[contains(., '#{saved.name}')]/td/a[@title='Borrar']").click

    expect(page).to have_content("Usuario borrado correctamente")
  end
end

RSpec.feature "Borrar usuarios" do
  let!(:area) { create(:area) }
  let!(:saved) { create(:user_voluntario, area: area) }

  context "siendo administrador" do
    let!(:user) { create(:user_admin, area: area) }

    it_behaves_like "delete user"
  end

  context "siendo referente" do
    let!(:user) { create(:user_referente, area: area) }

    it_behaves_like 'delete user'
  end

  context "siendo coordinador" do
    let!(:user) { create(:user_coordinador, area: area) }

    it_behaves_like 'delete user'
  end
end