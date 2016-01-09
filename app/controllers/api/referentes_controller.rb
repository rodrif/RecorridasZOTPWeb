class Api::ReferentesController < Api::ApiController

  def download
    respuesta = ReferenteDataAccess.download params['datos'], params['fecha']
    render :json => respuesta
  end

  def upload
    respuesta = ReferenteDataAccess.upload params['datos'], params['fecha']
    render :json => respuesta
  end

end