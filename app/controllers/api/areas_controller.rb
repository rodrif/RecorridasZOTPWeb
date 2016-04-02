class Api::AreasController < Api::ApiController
  before_action :authenticate_user!, only: [:download] # TODO: es para testing

  def download
    respuesta = AreaDataAccess.download params['datos'], params['fecha']
    render :json => respuesta
  end

  def upload
    respuesta = AreaDataAccess.upload params['datos'], params['fecha']
    render :json => respuesta
  end

end