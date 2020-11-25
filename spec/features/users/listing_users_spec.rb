require 'rails_helper'

RSpec.shared_examples "list users" do
  scenario "puede listar usuarios" do
    login_as user

    visit users_path

    expect(page).to have_content("Usuarios")
  end
end

RSpec.feature "Listar usuarios" do
  context "siendo administrador" do
    let(:user) { create(:user_admin) }

    it_behaves_like "list users"
  end

  context "siendo referente" do
    let(:user) { create(:user_referente) }

    it_behaves_like 'list users'
  end

  context "siendo coordinador" do
    let(:user) { create(:user_coordinador) }

    it_behaves_like 'list users'
  end

  context "siendo voluntario" do
    let(:user) { create(:user_voluntario) }
    scenario "no puede listar usuarios" do
      login_as user
      visit users_path

      expect(page).to have_content("Acceso denegado")

    end
  end
end