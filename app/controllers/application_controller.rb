class ApplicationController < ActionController::Base
  before_filter :prepare_exception_notifier
  #protect_from_forgery with: :null_session
  #skip_before_filter :verify_authenticity_token
  #include DeviseTokenAuth::Concerns::SetUserByToken
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  #protect_from_forgery with: :exception

  rescue_from 'ActiveRecord::InvalidForeignKey' do
    flash[:error] = I18n.t('common.errores.foreign_key')
    redirect_to :back
  end

  def puede_crear_persona
    if !current_user.rol || !current_user.rol.puede_crear_persona
      redireccionar
    end
  end

  def puede_editar_persona
    if !current_user.rol || !current_user.rol.puede_editar_persona
      redireccionar
    end
  end

  def puede_borrar_persona
    if !current_user.rol || !current_user.rol.puede_borrar_persona
      redireccionar
    end
  end

  def puede_ver_telefono_persona
    if !current_user.rol || !current_user.rol.puede_ver_telefono_persona
      redireccionar
    end
  end

  def puede_crear_visita
    if !current_user.rol || !current_user.rol.puede_crear_visita
      redireccionar
    end
  end

  def puede_editar_visita
    if !current_user.rol || !current_user.rol.puede_editar_visita
      redireccionar
    end
  end

  def puede_borrar_visita
    if !current_user.rol || !current_user.rol.puede_borrar_visita
      redireccionar
    end
  end

  def puede_ver_web
    if !current_user.rol || !current_user.rol.puede_ver_web
      redireccionar
    end
  end

  def is_admin
    if !current_user.rol_id || current_user.rol_id != 1
      redireccionar
    end
  end

  private

  def redireccionar
    if !current_user.rol.puede_ver_web
      sign_out current_user
    end
    redirect_to acceso_denegado_path
  end

  def prepare_exception_notifier
    request.env["exception_notifier.exception_data"] = {
      :current_user => current_user
    }
  end

end
