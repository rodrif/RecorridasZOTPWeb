require 'rails_helper'

xdescribe 'Ranchadas' do

  subject { page }

  describe "index page", js: true do
    before { visit ranchadas_path }

    it "borrar ranchada" do
      should have_selector('h2', text: 'Ranchadas')

      accept_alert do
        should have_xpath("//tr[contains(., 'Familia Rodriguez')]", count: 1)
        find(:xpath, "//tr[contains(., 'Familia Rodriguez')]/td/a", :text => 'Borrar').click
      end
      should have_content(I18n.t('common.errores.foreign_key'))

      accept_alert do
        should have_xpath("//tr[contains(., 'Ranchada Aquino')]", count: 1)
        find(:xpath, "//tr[contains(., 'Ranchada Aquino')]/td/a", :text => 'Borrar').click
      end
      should_not have_content(I18n.t('common.errores.foreign_key'))
      should have_content(I18n.t('common.exito.borrado_ranchada'))
      should have_xpath("//tr[contains(., 'Ranchada Aquino')]", count: 0)
    end
  end

  describe "edit page" do
    let(:ranchada) { Ranchada.find_by_nombre("Familia Rodriguez") }
    before { visit edit_ranchada_path(ranchada) }

    it "should load ranchada fields" do
      should have_field('ranchada[nombre]', with: 'Familia Rodriguez')
      should have_select('ranchada[zone_id]', selected: "Haedo")

      select "Liniers", from: "ranchada_zone_id"
      fill_in 'ranchada[descripcion]', with: "comentario de prueba edit page ranchada"
      fill_in 'ranchada[latitud]', with: "-34.6425662354"
      fill_in 'ranchada[longitud]', with: "-58.5659103259"
      find('input[name="commit"]').click

      assert_current_path(ranchadas_path)
      should have_content(I18n.t('common.exito.actualizacion_ranchada'))
      should have_xpath("//tr[contains(., 'Familia Rodriguez')]", text: /Familia Rodriguez\s*Zona Oeste\s*Liniers\s*comentario de prueba edit page ranchada/)

      ranchada.reload
      expect(ranchada.descripcion).to eq("comentario de prueba edit page ranchada")
      expect(ranchada.latitud).to eq(-34.6425662354)
      expect(ranchada.longitud).to eq(-58.5659103259)
    end
  end

  # TODO new page

  describe "ranchada cambia de zona" do
    let(:persona) { Person.first }
    let(:familia) { Familia.second }
    let(:ranchada) { Ranchada.find_by_nombre("Familia Rodriguez") }
    before { visit edit_ranchada_path(ranchada) }

    it "should change ranchada coherentemente" do
      expect(familia.zone.nombre).to eq("Haedo")
      expect(persona.zone.nombre).to eq("Haedo")
      expect(persona.ranchada_id).to eq(ranchada.id)
      expect(familia.ranchada_id).to eq(ranchada.id)

      select "Liniers", from: "ranchada_zone_id"
      find('input[name="commit"]').click

      expect(ranchada.reload.zone.nombre).to eq("Liniers")
      expect(persona.reload.zone.nombre).to eq("Liniers")
      expect(familia.reload.zone.nombre).to eq("Liniers")
    end
  end




end