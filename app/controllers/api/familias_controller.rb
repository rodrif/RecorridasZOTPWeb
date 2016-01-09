class Api::FamiliasController < Api::ApiController

  def download
    respuesta = FamiliaDataAccess.download params['datos'], params['fecha']
    render :json => respuesta
  end

  def upload
    respuesta = FamiliaDataAccess.upload params['datos'], params['fecha']
    render :json => respuesta
  end

end