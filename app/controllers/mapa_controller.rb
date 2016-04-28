class MapaController < ApplicationController
  before_action :authenticate_user!
  before_action :esInvitado
  before_action :puede_ver_web, only: [:index, :mostrar]

  def index
    @personas = PersonDataAccess.listPersonaMapa
  end

  def mostrar
    @personas = PersonDataAccess.listPersonaMapa
  end

  def mobMapaPersonas
    render :json => PersonDataAccess.listPersonaMapa.to_json
  end

  private

    def esInvitado
      if !current_user.rol_id || current_user.rol_id == 5
        sign_out current_user
        redirect_to falta_confirmacion_path
      end
    end

end
