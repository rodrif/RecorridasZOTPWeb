require 'rails_helper'

def fill_in_form_edit_pedido
  visit "/"

  click_link "Ver Pedidos"
  find(:xpath, "//tr[contains(., '#{persona.full_name}')]/td/a[@title='#{I18n.t("common.ver_editar")}']").click

  select persona.nombre, from: "Persona"
  fill_in "Fecha", with: pedido.fecha
  fill_in "Descripción", with: pedido.descripcion
  check "Completado"
  click_button "Aceptar"
end

RSpec.shared_examples "update pedido" do
  scenario "edita pedido satisfactoriamente" do
    login_as user

    fill_in_form_edit_pedido

    expect(page).to have_xpath("//tr[contains(., '#{persona.full_name}')]")
    expect(page).to have_xpath("//tr[contains(., '#{persona.full_name}')]/td", :text => pedido.fecha.to_date)
    expect(page).to have_xpath("//tr[contains(., '#{persona.full_name}')]/td", :text => pedido.descripcion)
    expect(page).to have_xpath("//tr[contains(., '#{persona.nombre}')]/td", :text => "Si")
  end
end

RSpec.feature "Editar pedido" do

  before do
    Person.update_all(state_id: 3)
  end

  let!(:persona) { create(:person) }
  let!(:pedido_guardado) { create(:pedido, person: persona)}
  let(:pedido) { build(:pedido)}

  context "siendo administrador" do
    let(:user) { create(:user_admin) }

    include_examples "update pedido"
  end

  context "siendo coordinador" do
    let(:user) { create(:user_coordinador) }

    include_examples "update pedido"
  end

  context "siendo referente" do
    let(:user) { create(:user_referente) }

    include_examples "update pedido"
  end

  context "siendo voluntario" do
    let(:user) { create(:user_voluntario) }

    include_examples "update pedido"
  end

  context "cuando la fecha de pedido está vacía" do
    let(:user) { create(:user_admin) }
    let(:pedido) { build(:pedido)}

    scenario "falla al editarlo" do
      pedido.fecha = nil
      login_as user
      fill_in_form_edit_pedido

      expect(page).to have_content("Fecha no puede estar en blanco")
    end
  end

  context "cuando la descripción del pedido está vacía" do
    let(:user) { create(:user_admin) }
    let(:pedido) { build(:pedido, descripcion: "")}

    scenario "falla al editarlo" do
      login_as user
      fill_in_form_edit_pedido

      expect(page).to have_content("Descripción no puede estar en blanco")
    end
  end

  context "cuando no se selecciona persona" do
    let(:user) { create(:user_admin) }

    scenario "falla al editarlo" do
      login_as user
      fill_in_form_edit_pedido

      visit "/"
      click_link "Nuevo Pedido"

      select "", from: "Persona"
      click_button "Aceptar"

      expect(page).to have_content("Persona no puede estar en blanco")
    end
  end
end