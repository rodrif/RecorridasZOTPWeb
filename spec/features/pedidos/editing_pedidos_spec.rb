require 'rails_helper'

RSpec.feature "Editar pedido" do

  before do
    @admin = create(:user_admin)
    @referente = create(:user_referente)
    @coordinador = create(:user_coordinador)
    @voluntario = create(:user_voluntario)
    Person.update_all(state_id: 3)
  end

  let!(:persona) { create(:person) }
  let!(:pedido_guardado) { create(:pedido, person: persona)}
  let(:pedido) { build(:pedido)}

  scenario "siendo usuario administrador" do
    login_as @admin
    visit "/"

    click_link "Pedidos"
    find(:xpath, "//tr[contains(., '#{persona.full_name}')]/td/a", :class => "glyphicon-edit").click

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

  scenario "siendo usuario coordinador" do
    login_as @coordinador
    visit "/"

    click_link "Pedidos"
    find(:xpath, "//tr[contains(., '#{persona.full_name}')]/td/a", :class => "glyphicon-edit").click

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

  scenario "siendo usuario referente" do
    login_as @referente
    visit "/"

    click_link "Pedidos"
    find(:xpath, "//tr[contains(., '#{persona.full_name}')]/td/a", :class => "glyphicon-edit").click

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

  scenario "siendo usuario voluntario" do
    login_as @voluntario
    visit "/"

    click_link "Pedidos"
    find(:xpath, "//tr[contains(., '#{persona.full_name}')]/td/a", :class => "glyphicon-edit").click

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