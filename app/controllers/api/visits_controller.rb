class Api::VisitsController < Api::ApiController
  before_action :authenticate_user!
  before_action :invitado

  def download
    respuesta = VisitDataAccess.download params['datos'], params['fecha']
    render :json => respuesta
  end

  def upload
    respuesta = VisitDataAccess.upload current_user, params['datos'], params['fecha']
    render :json => respuesta
  end

  def list
    respuesta = VisitDataAccess.list
    render :json => respuesta
  end

end