require 'rails_helper'
require 'support/shared_examples_requests'

RSpec.describe "Instituciones", type: :request do

  let!(:institucion) { create(:institucion)}

  let(:voluntario) { create(:user_voluntario)}

  describe 'POST /instituciones' do
    context 'con user voluntario' do
      before do
        login_as voluntario
        post "/instituciones", params: { institucion: {nombre: institucion.nombre} }
      end

      include_examples "access denied"
    end
  end

  describe 'PUT /instituciones/:ud' do
    context 'con user voluntario' do
      before do
        login_as voluntario
        put "/instituciones/#{institucion.id}", params: { institucion: {nombre: institucion.nombre} }
      end

      include_examples "access denied"
    end
  end

  describe 'DELETE /instituciones/:id' do
    context 'con user voluntario' do
      before do
        login_as voluntario
        delete"/instituciones/#{institucion.id}"
      end

      include_examples "access denied"
    end
  end

end