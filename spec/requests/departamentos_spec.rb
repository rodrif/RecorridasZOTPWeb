require 'rails_helper'

RSpec.describe "Departamentos", type: :request do

  before do
    @admin = create(:user_admin)
    @admin.confirm
    @departamento = create(:departamento)
    @non_admin = create(:user)
    @non_admin.confirm
  end

  describe 'GET /departamentos/:id/edit' do
    context 'sin user logueado' do
      before { get "/departamentos/#{@departamento.id}/edit" }

      it "redirecciona a página de sign in" do
        expect(response.status).to eq 302
        flash_message = "Necesitas iniciar sesión o registrarte para continuar."
        expect(flash[:alert]).to eq flash_message
      end
    end

    context 'con user administrador' do
      before do
        login_as @admin
        get "/departamentos/#{@departamento.id}/edit"
      end

      it "muestra la página de edit" do
        expect(response.status).to eq 200
      end
    end

    context 'con user no administrador' do
      before do
        login_as @non_admin
        get "/departamentos/#{@departamento.id}/edit"
      end

      it "redirecciona a la página de acceso denegado" do
        expect(response).to redirect_to(acceso_denegado_path)
        expect(response.status).to eq 302
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

  describe 'POST /departamentos' do
    context 'con user administrador' do
      before do
        login_as @admin
        post "/departamentos", {departamento: {nombre: "Nuevo departamento"} }
      end

      it "crea el departamento y redirecciona a la página de departamentos" do
        flash_message = "Área creada correctamente."
        expect(response).to redirect_to(departamentos_path)
        expect(response.status).to eq 302
        expect(flash[:notice]).to eq flash_message
      end
    end

    context 'con user no administrador' do
      before do
        login_as @non_admin
        post "/departamentos", {departamento: {nombre: "Nuevo departamento"} }
      end

      it "redirecciona a la página de acceso denegado" do
        expect(response).to redirect_to(acceso_denegado_path)
        expect(response.status).to eq 302
      end
    end
  end



end