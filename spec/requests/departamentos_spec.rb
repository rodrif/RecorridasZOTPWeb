require 'rails_helper'

RSpec.describe "Departamentos", type: :request do

  before do
    @admin = create(:user_admin)
    @admin.confirm
    @departamento = create(:departamento)
  end

  describe 'GET /departamentos/:id/edit' do
    context 'con user no logueado' do
      before { get "/departamentos/#{@departamento.id}/edit" }

      it "redirecciona a página de sign in" do
        expect(response.status).to eq 302
        flash_message = "Necesitas iniciar sesión o registrarte para continuar."
        expect(flash[:alert]).to eq flash_message
      end
    end

    context 'con user administrador logueado' do
      before do
        login_as @admin
        get "/departamentos/#{@departamento.id}/edit"
      end

      it "muestra la página de edit" do
        expect(response.status).to eq 200
      end
    end

    context 'con area no existente' do
      before do
        login_as @admin
        get "/departamentos/XXXXX/edit"
      end

      it "muestra mensaje de área no encontrada" do
        expect(response.status).to eq 302
        flash_message = "El área no se ha podido encontrar."
        expect(flash[:alert]).to eq flash_message
      end
    end


  end

end