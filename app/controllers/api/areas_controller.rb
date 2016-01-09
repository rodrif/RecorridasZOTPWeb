class Api::AreasController < Api::ApiController

  def download
    respuesta = AreaDataAccess.download params['datos'], params['fecha']
    render :json => respuesta
  end

  def upload
    respuesta = AreaDataAccess.upload params['datos'], params['fecha']
    render :json => respuesta
  end

end