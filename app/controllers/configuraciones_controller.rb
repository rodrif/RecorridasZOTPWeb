class ConfiguracionesController < ApplicationController
  include ApplicationHelper
  before_action :authenticate_user!
  before_action :puede_ver_web

  def index
  end

end
