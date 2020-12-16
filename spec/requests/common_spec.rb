require 'rails_helper'
require 'support/shared_examples_requests'

RSpec.describe "Commons", type: :request do

  let(:admin) { create(:user_admin)}

  describe 'GET /common/update_zonas_filter' do
    context 'response ok' do
      before do
        login_as admin
        get "/common/update_zonas_filter", xhr: true
      end

      include_examples "get ok"
    end
  end

  describe 'GET /common/update_personas' do
    context 'response ok' do
      before do
        login_as admin
        get "/common/update_personas", xhr: true
      end

      include_examples "get ok"
    end
  end

  describe 'GET /common/update_pedidos_pendientes' do
    context 'response ok with pedido null' do
      before do
        login_as admin
        get "/common/update_pedidos_pendientes"
      end

      include_examples "get ok"
    end
  end

  describe 'GET /common/update_pedidos_pendientes' do
    context 'response ok with pedido' do
      let!(:persona) { create(:person) }
      let!(:pedido) { create(:pedido, person: persona)}
      before do
        login_as admin
        get "/common/update_pedidos_pendientes?#{persona.id}"
      end

      include_examples "get ok"
    end
  end

  describe 'GET /common/edit_pedido_modal' do
    context 'response ok' do
      let!(:persona) { create(:person) }
      let!(:pedido) { create(:pedido, person: persona)}
      before do
        login_as admin
        get "/common/edit_pedido_modal/#{pedido.id}", xhr: true
      end

      include_examples "get ok"
    end
  end
end