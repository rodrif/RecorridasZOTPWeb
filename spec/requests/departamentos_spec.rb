require 'rails_helper'
require 'support/shared_examples_requests'

RSpec.describe "Departamentos", type: :request do

  let!(:departamento) { create(:departamento)}
  let(:admin) { create(:user_admin)}
  let(:voluntario) { create(:user_voluntario)}

  describe 'GET /departamentos/:id/edit' do
    context 'sin user logueado' do
      before { get "/departamentos/#{departamento.id}/edit" }

      include_examples "not logged in user"
    end

    context 'con user administrador' do
      before do
        login_as admin
        get "/departamentos/#{departamento.id}/edit"
      end

      include_examples "get ok"
    end

    context 'con user no administrador' do
      before do
        login_as voluntario
        get "/departamentos/#{departamento.id}/edit"
      end

      include_examples "access denied"
    end

    context 'con area no existente' do
      before do
        login_as admin
        get "/departamentos/XXXXX/edit"
      end

      include_examples "not found" do
        let(:resource) { "Área"}
      end
    end
  end

  describe 'POST /departamentos' do
    context 'con user administrador' do
      before do
        login_as admin
        post "/departamentos", params: { departamento: {nombre: "Nuevo departamento"} }
      end

      include_examples "post ok" do
        let(:path) {departamentos_path}
        let(:flash_message) {"Área creada correctamente."}
      end
    end

    context 'con user no administrador' do
      before do
        login_as voluntario
        post "/departamentos", params: { departamento: {nombre: "Nuevo departamento"} }
      end

      include_examples "access denied"
    end
  end

  describe 'PUT /departamentos/:id/edit' do
    context 'con user administrador' do
      before do
        login_as admin
        put "/departamentos/#{departamento.id}", params: { departamento: {nombre: "Nuevo departamento"} }
      end

      include_examples "put ok" do
        let(:path) {departamentos_path}
        let(:flash_message) {"Área actualizada correctamente."}
      end
    end

    context 'con user no administrador' do
      before do
        login_as voluntario
        put "/departamentos/#{departamento.id}", params: { departamento: {nombre: "Nuevo departamento"} }
      end

      include_examples "access denied"
    end
  end

  describe 'DELETE /departamentos/:id' do
    context 'con user administrador' do
      before do
        login_as admin
        delete "/departamentos/#{departamento.id}"
      end

      include_examples "delete ok" do
        let(:path) {departamentos_path}
        let(:flash_message) {"Área borrada correctamente."}
      end
    end

    context 'con user no administrador' do
      before do
        login_as voluntario
        delete"/departamentos/#{departamento.id}"
      end

      include_examples "access denied"
    end
  end


end