class CalendarioController < ApplicationController
  before_action :authenticate_user!
  before_action :is_admin

  def index
  	@meetings = Notificacion.calendario
  end

end
