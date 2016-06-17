class Api::PeopleController < Api::ApiController
  before_action :authenticate_user!
  before_action :invitado

  def download
    respuesta = PersonDataAccess.download params['datos'], params['fecha']
    render :json => respuesta
  end

  def upload
    respuesta = PersonDataAccess.upload current_user, params['datos'], params['fecha']
    render :json => respuesta
  end

end