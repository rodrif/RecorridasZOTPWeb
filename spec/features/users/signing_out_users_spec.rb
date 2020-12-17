require 'rails_helper'

RSpec.feature "Sign users out" do

  context "cuando un usuario sale de la aplicación" do
    let(:admin) { create(:user_admin)}
    scenario "es redireccionado a la página de sign in" do
      login_as admin
      visit "/"

      click_link "Salir"

      expect(current_path).to eq(new_user_session_path)
    end
  end

end