require 'rails_helper'

RSpec.feature "Eliminar pedidos" do

  before do
    @admin = create(:user_admin)
    @referente = create(:user_referente)
    @coordinador = create(:user_coordinador)
    @voluntario = create(:user_voluntario)
  end

  let!(:persona) { create(:person) }
  let!(:pedido) { create(:pedido, person: persona)}

  scenario "siendo usuario administrador" do
    login_as @admin
    visit "/"

    click_link "Pedidos"
    find(:xpath, "//tr[contains(., '#{persona.full_name}')]/td/a", :class => "glyphicon-remove").click

    expect(page).to have_content("Pedido borrado correctamente")
    expect(page).not_to have_xpath("//tr[contains(., '#{persona.full_name}')]")
  end

  scenario "siendo usuario coordinador" do
    login_as @coordinador
    visit "/"

    click_link "Pedidos"
    find(:xpath, "//tr[contains(., '#{persona.full_name}')]/td/a", :class => "glyphicon-remove").click

    expect(page).to have_content("Pedido borrado correctamente")
    expect(page).not_to have_xpath("//tr[contains(., '#{persona.full_name}')]")
  end

  scenario "siendo usuario referente" do
    login_as @referente
    visit "/"

    click_link "Pedidos"
    find(:xpath, "//tr[contains(., '#{persona.full_name}')]/td/a", :class => "glyphicon-remove").click

    expect(page).to have_content("Pedido borrado correctamente")
    expect(page).not_to have_xpath("//tr[contains(., '#{persona.full_name}')]")
  end

  scenario "siendo usuario voluntario no tiene opción de borrar" do
    login_as @voluntario
    visit "/"

    click_link "Pedidos"
    expect(page).not_to have_xpath("//tr[contains(., '#{persona.full_name}')]/td/a", :class => "glyphicon-remove")
  end
end