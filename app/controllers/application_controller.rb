class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  #protect_from_forgery with: :exception

  #TODO ver como hacer para poner esto solo en peticiones de mobile
  protect_from_forgery with: :null_session


  rescue_from 'ActiveRecord::InvalidForeignKey' do
    flash[:error] = I18n.t('common.errores.foreign_key')
    redirect_to :back
  end
end
