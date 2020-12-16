require 'rails_helper'
require 'support/shared_examples_requests'

RSpec.describe "Sedes", type: :request do

  let!(:area) { create(:area)}

  let(:voluntario) { create(:user_voluntario)}

  describe 'POST /areas' do
    context 'con user voluntario' do
      before do
        login_as voluntario
        post "/areas", params: { area: {nombre: area.nombre} }
      end

      include_examples "access denied"
    end
  end

  describe 'PUT /areas/:ud' do
    context 'con user voluntario' do
      before do
        login_as voluntario
        put "/areas/#{area.id}", params: { area: {nombre: area.nombre} }
      end

      include_examples "access denied"
    end
  end

  describe 'DELETE /areas/:id' do
    context 'con user voluntario' do
      before do
        login_as voluntario
        delete"/areas/#{area.id}"
      end

      include_examples "access denied"
    end
  end

end