require 'rails_helper'
RSpec.feature "Registración de usuario" do

  let!(:area) { create(:area) }
  let!(:coordinador) { create(:user_coordinador, area: area)}
  let(:user) { build(:user) }

  def fill_form_and_sign_up()
    visit "/"
    click_link "Registrarse"

    fill_in "Email", with: user.email
    fill_in "Contraseña", with: user.password
    fill_in "Confirmar contraseña", with: user.password
    fill_in "Nombre", with: user.name
    fill_in "Apellido", with: user.apellido
    select area.nombre, from: "Sede"

    click_button "Registrarse"
  end

  scenario "registración exitosa" do
    fill_form_and_sign_up

    expect(page).to have_content("Se te ha enviado un mensaje con un enlace de confirmación. Por favor visita el enlace para activar tu cuenta.")
  end

  scenario "al registrarse el user es seteado con rol invitado" do
    fill_form_and_sign_up

    user_saved = User.find_by_email(user.email)
    expect(user_saved.rol_id).to eq(Rol::INVITADO)
  end

  scenario "al registrarse se envía un mail al usuario registrado y a los coordinadores de la sede" do
    expect{ (fill_form_and_sign_up) }.to change { Enviador.deliveries.count }.by(2)

    mail_to_registrado = open_email(user.email)
    mail_to_coordinador = open_email(coordinador.email)

    expect(mail_to_registrado.subject).to eq("Instrucciones de confirmación")
    expect(mail_to_coordinador.subject).to eq("Un voluntario se registró en la web")
  end

end