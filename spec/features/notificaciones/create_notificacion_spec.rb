require 'rails_helper'

def fill_form_notificacion_and_create notificacion
  login_as user
  visit "/"

  click_link "Notificaciones", match: :first
  click_link "Nueva notificacion"


  fill_in "Título", with: notificacion.titulo
  fill_in "Subtítulo", with: notificacion.subtitulo
  fill_in "Descripción", with: notificacion.descripcion

  fill_in "datetimefrom", with: notificacion.fecha_desde
  fill_in "datetimeto", with: notificacion.fecha_hasta
  select notificacion.frecuencia_tipo.nombre, from: "Frecuencia"
  select user.rol.nombre, from: "Roles"
  select area.nombre, from: "Sedes"

  click_button "Aceptar"
end


RSpec.feature "Crear notificacion" do
  let!(:area) { create(:area) }
  let(:notificacion) { build(:notificacion_unica )}

  context "siendo administrador" do
    let!(:user) {create(:user_admin)}

    scenario "crea satisfactoriamente al llenar los datos correctamente" do
      fill_form_notificacion_and_create notificacion

      expect(page).to have_content("Notificación creada correctamente")
    end
  end

  context "siendo referente" do
    let!(:user) {create(:user_referente)}

    scenario "crea satisfactoriamente al llenar los datos correctamente" do
      fill_form_notificacion_and_create notificacion

      expect(page).to have_content("Notificación creada correctamente")
    end
  end

  context "falla al crear" do
    let!(:user) {create(:user_admin)}
    let(:notificacion) { build(:notificacion_diaria )}

    scenario "fecha desde previa a actual falla" do
      notificacion.fecha_desde = DateTime.now.advance(hours: -1)
      fill_form_notificacion_and_create notificacion

      expect(page).to have_content("Fecha desde no puede estar en el pasado")
    end

    scenario "fecha hasta previa a fecha desde" do
      notificacion.fecha_hasta = notificacion.fecha_desde.advance(hours: -1)
      fill_form_notificacion_and_create notificacion

      expect(page).to have_content("Fecha hasta no puede ser anterior a fecha desde")
    end

    scenario "título vacío" do
      notificacion.titulo = ""
      fill_form_notificacion_and_create notificacion

      expect(page).to have_content("Título no puede estar en blanco")
    end

    scenario "subtítulo vacío" do
      notificacion.subtitulo = ""
      fill_form_notificacion_and_create notificacion

      expect(page).to have_content("Subtítulo no puede estar en blanco")
    end
  end
end