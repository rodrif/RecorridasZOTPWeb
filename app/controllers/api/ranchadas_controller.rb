class Api::RanchadasController < Api::ApiController

  def download
    respuesta = RanchadaDataAccess.download params['datos'], params['fecha']
    render :json => respuesta
  end

  def upload
    respuesta = RanchadaDataAccess.upload params['datos'], params['fecha']
    render :json => respuesta
  end

end