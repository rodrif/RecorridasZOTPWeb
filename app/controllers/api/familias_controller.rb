class Api::FamiliasController < Api::ApiController
  before_action :authenticate_user!
  before_action :invitado

  def download
    respuesta = FamiliaDataAccess.download params['datos'], params['fecha']
    render :json => respuesta
  end

  # def upload
  #   respuesta = FamiliaDataAccess.upload current_user, params['datos'], params['fecha']
  #   render :json => respuesta
  # end

end