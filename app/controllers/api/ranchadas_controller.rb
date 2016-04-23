class Api::RanchadasController < Api::ApiController
  before_action :authenticate_user!
  before_action :invitado

  def download
    respuesta = RanchadaDataAccess.download params['datos'], params['fecha']
    render :json => respuesta
  end

  def upload
    respuesta = RanchadaDataAccess.upload params['datos'], params['fecha']
    render :json => respuesta
  end

end