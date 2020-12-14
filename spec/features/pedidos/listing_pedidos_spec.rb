require 'rails_helper'

RSpec.shared_examples "list pedidos" do
  scenario "lista pedidos satisfactoriamente" do
    login_as user
    visit "/"

    click_link "Ver Pedidos"

    expect(page).to have_xpath("//tr[contains(., '#{persona.full_name}')]")
    expect(page).to have_xpath("//tr[contains(., '#{persona.full_name}')]/td", :text => pedido.fecha.to_date)
    expect(page).to have_xpath("//tr[contains(., '#{persona.full_name}')]/td", :text => pedido.descripcion)
    expect(page).to have_xpath("//tr[contains(., '#{persona.nombre}')]/td", :text => "No")
  end
end

RSpec.feature "Listar pedidos" do

  before do
    Person.update_all(state_id: 3)
  end

  let!(:persona) { create(:person) }
  let!(:pedido) { create(:pedido, person: persona)}

  context "siendo administrador" do
    let(:user) { create(:user_admin) }

    include_examples "list pedidos"
  end

  context "siendo coordinador" do
    let(:user) { create(:user_coordinador) }

    include_examples "list pedidos"
  end

  context "siendo referente" do
    let(:user) { create(:user_referente) }

    include_examples "list pedidos"
  end

  context "siendo voluntario" do
    let(:user) { create(:user_voluntario) }

    include_examples "list pedidos"
  end
end