class MapaController < ApplicationController
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
end
