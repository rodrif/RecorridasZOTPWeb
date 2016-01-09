class Api::ZonesController < Api::ApiController

  def download
    respuesta = ZoneDataAccess.download params['datos'], params['fecha']
    render :json => respuesta
  end

  def upload
    respuesta = ZoneDataAccess.upload params['datos'], params['fecha']
    render :json => respuesta
  end

end