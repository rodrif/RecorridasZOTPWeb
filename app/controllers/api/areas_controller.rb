class Api::AreasController < Api::ApiController
  before_action :authenticate_user!
  before_action :invitado

  def download
    respuesta = AreaDataAccess.download current_user, params['datos'], params['fecha'], params['version']
    render :json => respuesta
  end

  def upload
    respuesta = AreaDataAccess.upload current_user, params['datos'], params['fecha']
    render :json => respuesta
  end

end
