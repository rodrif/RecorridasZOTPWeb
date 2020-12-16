require 'rails_helper'
require 'support/shared_examples_requests'

RSpec.describe "Estados", type: :request do

  let!(:estado) { create(:estado)}

  let(:voluntario) { create(:user_voluntario)}

  describe 'POST /estados' do
    context 'con user voluntario' do
      before do
        login_as voluntario
        post "/estados", params: { estado: {nombre: estado.nombre} }
      end

      include_examples "access denied"
    end
  end

  describe 'PUT /estados/:ud' do
    context 'con user voluntario' do
      before do
        login_as voluntario
        put "/estados/#{estado.id}", params: { estado: {nombre: estado.nombre} }
      end

      include_examples "access denied"
    end
  end

  describe 'DELETE /estados/:id' do
    context 'con user voluntario' do
      before do
        login_as voluntario
        delete"/estados/#{estado.id}"
      end

      include_examples "access denied"
    end
  end

end