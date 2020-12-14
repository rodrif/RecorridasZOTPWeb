require 'rails_helper'

RSpec.shared_examples "delete pedido" do
  scenario "borra pedido satisfactoriamente" do
    login_as user
    visit "/"

    click_link "Ver Pedidos"
    find(:xpath, "//tr[contains(., '#{persona.full_name}')]/td/a[@title='Borrar']").click

    expect(page).to have_content("Pedido borrado correctamente")
    expect(page).not_to have_xpath("//tr[contains(., '#{persona.full_name}')]")
  end
end

RSpec.feature "Eliminar pedidos" do

  before do
    Person.update_all(state_id: 3)
  end

  let!(:persona) { create(:person) }
  let!(:pedido) { create(:pedido, person: persona)}

  context "siendo administrador" do
    let(:user) { create(:user_admin) }

    include_examples "delete pedido"
  end

  context "siendo coordinador" do
    let(:user) { create(:user_coordinador) }

    include_examples "delete pedido"
  end

  context "siendo referente" do
    let(:user) { create(:user_referente) }

    include_examples "delete pedido"
  end

  context "siendo voluntario" do
    let(:user) { create(:user_voluntario) }
    scenario "siendo usuario voluntario no tiene opción de borrar" do
      login_as user
      visit "/"

      click_link "Pedidos"
      expect(page).not_to have_xpath("//tr[contains(., '#{persona.full_name}')]/td/a", :class => "glyphicon-remove")
    end
  end

end