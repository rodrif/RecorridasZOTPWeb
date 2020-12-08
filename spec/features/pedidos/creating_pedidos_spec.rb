require 'rails_helper'
RSpec.feature "Crear pedido" do

  before do
    @admin = create(:user_admin)
    @referente = create(:user_referente)
    @coordinador = create(:user_coordinador)
    @voluntario = create(:user_voluntario)
  end

  let!(:persona) { create(:person) }
  let(:pedido) { build(:pedido )}

  scenario "siendo administrador" do
    login_as @admin
    visit "/"

    click_link "Pedidos"
    click_link "Nuevo pedido"

    select persona.nombre, from: "Persona"
    fill_in "Fecha", with: pedido.fecha
    fill_in "Descripción", with: pedido.descripcion
    click_button "Aceptar"


    expect(page).to have_content("Pedido creado correctamente")
    expect(current_path).to eq(pedidos_path)

    expect(page).to have_xpath("//tr[contains(., '#{persona.full_name}')]")
    expect(page).to have_xpath("//tr[contains(., '#{persona.full_name}')]/td", :text => pedido.fecha.to_date)
    expect(page).to have_xpath("//tr[contains(., '#{persona.full_name}')]/td", :text => pedido.descripcion)
    expect(page).to have_xpath("//tr[contains(., '#{persona.nombre}')]/td", :text => "No")
  end

  scenario "siendo coordinador" do
    login_as @coordinador
    visit "/"

    click_link "Pedidos"
    click_link "Nuevo pedido"

    select persona.nombre, from: "Persona"
    fill_in "Fecha", with: pedido.fecha
    fill_in "Descripción", with: pedido.descripcion
    click_button "Aceptar"


    expect(page).to have_content("Pedido creado correctamente")
    expect(current_path).to eq(pedidos_path)

    expect(page).to have_xpath("//tr[contains(., '#{persona.full_name}')]")
    expect(page).to have_xpath("//tr[contains(., '#{persona.full_name}')]/td", :text => pedido.fecha.to_date)
    expect(page).to have_xpath("//tr[contains(., '#{persona.full_name}')]/td", :text => pedido.descripcion)
    expect(page).to have_xpath("//tr[contains(., '#{persona.nombre}')]/td", :text => "No")
  end

  scenario "siendo referente" do
    login_as @referente
    visit "/"

    click_link "Pedidos"
    click_link "Nuevo pedido"

    select persona.nombre, from: "Persona"
    fill_in "Fecha", with: pedido.fecha
    fill_in "Descripción", with: pedido.descripcion
    click_button "Aceptar"


    expect(page).to have_content("Pedido creado correctamente")
    expect(current_path).to eq(pedidos_path)

    expect(page).to have_xpath("//tr[contains(., '#{persona.full_name}')]")
    expect(page).to have_xpath("//tr[contains(., '#{persona.full_name}')]/td", :text => pedido.fecha.to_date)
    expect(page).to have_xpath("//tr[contains(., '#{persona.full_name}')]/td", :text => pedido.descripcion)
    expect(page).to have_xpath("//tr[contains(., '#{persona.nombre}')]/td", :text => "No")
  end

  scenario "siendo voluntario" do
    login_as @voluntario
    visit "/"

    click_link "Pedidos"
    click_link "Nuevo pedido"

    select persona.nombre, from: "Persona"
    fill_in "Fecha", with: pedido.fecha
    fill_in "Descripción", with: pedido.descripcion
    click_button "Aceptar"


    expect(page).to have_content("Pedido creado correctamente")
    expect(current_path).to eq(pedidos_path)

    expect(page).to have_xpath("//tr[contains(., '#{persona.full_name}')]")
    expect(page).to have_xpath("//tr[contains(., '#{persona.full_name}')]/td", :text => pedido.fecha.to_date)
    expect(page).to have_xpath("//tr[contains(., '#{persona.full_name}')]/td", :text => pedido.descripcion)
    expect(page).to have_xpath("//tr[contains(., '#{persona.nombre}')]/td", :text => "No")
  end

  scenario "marcándolo como completado" do
    login_as @admin
    visit "/"

    click_link "Pedidos"
    click_link "Nuevo pedido"

    select persona.nombre, from: "Persona"
    fill_in "Fecha", with: pedido.fecha
    fill_in "Descripción", with: pedido.descripcion
    check "Completado"
    click_button "Aceptar"


    expect(page).to have_content("Pedido creado correctamente")
    expect(current_path).to eq(pedidos_path)

    expect(page).to have_xpath("//tr[contains(., '#{persona.full_name}')]")
    expect(page).to have_xpath("//tr[contains(., '#{persona.full_name}')]/td", :text => pedido.fecha.to_date)
    expect(page).to have_xpath("//tr[contains(., '#{persona.full_name}')]/td", :text => pedido.descripcion)
    expect(page).to have_xpath("//tr[contains(., '#{persona.nombre}')]/td", :text => "Si")
  end

  # context "persona con visitas existentes" do
  #   let(:visita) { build(:visit)}
  #   let!(:persona_con_visitas) { create(:person, visits: [visita]) }
  #   let(:visita_nueva) { build(:visit)}
  #
  #   scenario "muestra la dirección de la última visita cargada" do
  #     login_as @admin
  #
  #     visit people_path
  #     expect(page).to have_xpath("//tr[contains(., '#{persona_con_visitas.nombre}')]/td", :text => visita.direccion)
  #
  #     visit new_visit_path
  #     within('#new_visit') do
  #       select persona_con_visitas.nombre, from: "Persona"
  #       fill_in "Fecha", with: visita_nueva.fecha
  #       fill_in "Comentario", with: visita_nueva.descripcion
  #       fill_in "Latitud", with: visita_nueva.latitud
  #       fill_in "Longitud", with: visita_nueva.longitud
  #       click_button "Aceptar"
  #     end
  #
  #     visit people_path
  #     expect(page).to have_xpath("//tr[contains(., '#{persona_con_visitas.nombre}')]/td", :text => visita_nueva.direccion)
  #   end
  # end



end