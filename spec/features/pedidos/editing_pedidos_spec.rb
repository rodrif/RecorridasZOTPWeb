require 'rails_helper'

RSpec.shared_examples "update pedido" do
  scenario "edita pedido satisfactoriamente" do
    login_as user
    visit "/"

    click_link "Ver Pedidos"
    find(:xpath, "//tr[contains(., '#{persona.full_name}')]/td/a[@title='#{I18n.t("common.ver_editar")}']").click

    select persona.nombre, from: "Persona"
    fill_in "Fecha", with: pedido.fecha
    fill_in "Descripción", with: pedido.descripcion
    check "Completado"
    click_button "Aceptar"

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
end