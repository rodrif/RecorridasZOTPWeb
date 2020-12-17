require 'rails_helper'
RSpec.feature "Ingreso de usuario" do

  before do
    @voluntario = create(:user_voluntario)
    @invitado = create(:user_invitado)
    @not_confirmed_user = create(:user)
  end

  def fill_form_and_sign_in(user)
    visit "/"

    fill_in "Email", with: user.email
    fill_in "Contraseña", with: user.password

    click_button "Ingresar"
  end

  scenario "voluntario se loguea correctamente" do
    fill_form_and_sign_in(@voluntario)

    expect(page).to have_content("Has iniciado sesión correctamente.")
  end

  scenario "usuario no confirmado no puede acceder al sistema" do
    fill_form_and_sign_in(@not_confirmed_user)

    expect(page).to have_content("Debes confirmar tu cuenta para continuar.")
  end

  scenario "invitado no puede acceder al sistema" do
    fill_form_and_sign_in(@invitado)

    expect(page).to have_content("Falta autorización de un administrador")
  end
end