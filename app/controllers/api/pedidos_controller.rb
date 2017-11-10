class Api::PedidosController < Api::ApiController
  before_action :authenticate_user!
  before_action :invitado

  def download
    respuesta = PedidoDataAccess.download params['datos'], params['fecha']
    render :json => respuesta
  end

  def upload
    respuesta = PedidoDataAccess.upload current_user, params['datos'], params['fecha']
    render :json => respuesta
  end

end
