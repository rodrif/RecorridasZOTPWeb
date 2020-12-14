require 'rails_helper'

RSpec.shared_examples "create pedido" do
  scenario "crea pedido satisfactoriamente" do
    login_as user
    visit "/"

    click_link "Nuevo Pedido"

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
end

RSpec.feature "Crear pedido" do

  before do
    Person.update_all(state_id: 3)
  end

  let!(:persona) { create(:person) }
  let(:pedido) { build(:pedido )}

  context "siendo administrador" do
    let(:user) { create(:user_admin) }

    include_examples "create pedido"
  end

  context "siendo coordinador" do
    let(:user) { create(:user_coordinador) }

    include_examples "create pedido"
  end

  context "siendo referente" do
    let(:user) { create(:user_referente) }

    include_examples "create pedido"
  end

  context "siendo voluntario" do
    let(:user) { create(:user_voluntario) }

    include_examples "create pedido"
  end

  context "marcándolo como completado" do
  let(:user) { create(:user_admin) }
    scenario "queda en el status correcto" do
      login_as user
      visit "/"

      click_link "Nuevo Pedido"

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
  end

end