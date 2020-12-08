require 'rails_helper'

RSpec.feature "Listar pedidos" do

  before do
    @admin = create(:user_admin)
    @referente = create(:user_referente)
    @coordinador = create(:user_coordinador)
    @voluntario = create(:user_voluntario)
    Person.update_all(state_id: 3)
  end

  let!(:persona) { create(:person) }
  let!(:pedido) { create(:pedido, person: persona)}

  scenario "siendo usuario administrador" do
    login_as @admin
    visit "/"

    click_link "Pedidos"

    expect(page).to have_xpath("//tr[contains(., '#{persona.full_name}')]")
    expect(page).to have_xpath("//tr[contains(., '#{persona.full_name}')]/td", :text => pedido.fecha.to_date)
    expect(page).to have_xpath("//tr[contains(., '#{persona.full_name}')]/td", :text => pedido.descripcion)
    expect(page).to have_xpath("//tr[contains(., '#{persona.nombre}')]/td", :text => "No")
  end

  scenario "siendo usuario coordinador" do
    login_as @coordinador
    visit "/"

    click_link "Pedidos"

    expect(page).to have_xpath("//tr[contains(., '#{persona.full_name}')]")
    expect(page).to have_xpath("//tr[contains(., '#{persona.full_name}')]/td", :text => pedido.fecha.to_date)
    expect(page).to have_xpath("//tr[contains(., '#{persona.full_name}')]/td", :text => pedido.descripcion)
    expect(page).to have_xpath("//tr[contains(., '#{persona.nombre}')]/td", :text => "No")
  end

  scenario "siendo usuario referente" do
    login_as @referente
    visit "/"

    click_link "Pedidos"

    expect(page).to have_xpath("//tr[contains(., '#{persona.full_name}')]")
    expect(page).to have_xpath("//tr[contains(., '#{persona.full_name}')]/td", :text => pedido.fecha.to_date)
    expect(page).to have_xpath("//tr[contains(., '#{persona.full_name}')]/td", :text => pedido.descripcion)
    expect(page).to have_xpath("//tr[contains(., '#{persona.nombre}')]/td", :text => "No")
  end

  scenario "siendo usuario voluntario" do
    login_as @voluntario
    visit "/"

    click_link "Pedidos"

    expect(page).to have_xpath("//tr[contains(., '#{persona.full_name}')]")
    expect(page).to have_xpath("//tr[contains(., '#{persona.full_name}')]/td", :text => pedido.fecha.to_date)
    expect(page).to have_xpath("//tr[contains(., '#{persona.full_name}')]/td", :text => pedido.descripcion)
    expect(page).to have_xpath("//tr[contains(., '#{persona.nombre}')]/td", :text => "No")
  end
end