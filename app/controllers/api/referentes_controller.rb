class Api::ReferentesController < Api::ApiController
  before_action :authenticate_user!
  before_action :invitado

  def download
    respuesta = ReferenteDataAccess.download params['datos'], params['fecha']
    render :json => respuesta
  end

  def upload
    respuesta = ReferenteDataAccess.upload params['datos'], params['fecha']
    render :json => respuesta
  end

end