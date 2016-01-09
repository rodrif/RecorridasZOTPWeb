class Api::VisitsController < Api::ApiController

  def download
    respuesta = VisitDataAccess.download params['datos'], params['fecha']
    render :json => respuesta
  end

  def upload
    respuesta = VisitDataAccess.upload params['datos'], params['fecha']
    render :json => respuesta
  end

end