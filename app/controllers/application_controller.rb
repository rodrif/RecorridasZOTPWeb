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
    if !RolDataAccess.puede_crear_persona(current_user)
      redireccionar
    end
  end

  def puede_editar_persona
    if !RolDataAccess.puede_editar_persona(current_user)
      redireccionar
    end
  end

  def puede_borrar_persona
    if !RolDataAccess.puede_borrar_persona(current_user)
      redireccionar
    end
  end

  def puede_ver_datos_persona
    if !RolDataAccess.puede_ver_datos_persona(current_user)
      redireccionar
    end
  end

  def puede_crear_visita
    if !RolDataAccess.puede_crear_visita(current_user)
      redireccionar
    end
  end

  def puede_editar_visita
    if !RolDataAccess.puede_editar_visita(current_user)
      redireccionar
    end
  end

  def puede_borrar_visita
    if !RolDataAccess.puede_borrar_visita(current_user)
      redireccionar
    end
  end

  def puede_ver_web
    if !RolDataAccess.puede_ver_web(current_user)
      redireccionar
    end
  end

  def puede_editar_area
    if !RolDataAccess.puede_editar_area(current_user)
      redireccionar
    end
  end

  def puede_editar_zona
    if !RolDataAccess.puede_editar_zona(current_user)
      redireccionar
    end
  end

  def puede_editar_ranchada
    if !RolDataAccess.puede_editar_ranchada(current_user)
      redireccionar
    end
  end

  def puede_editar_familia
    if !RolDataAccess.puede_editar_familia(current_user)
      redireccionar
    end
  end

  def puede_editar_usuarios
    if !RolDataAccess.puede_editar_usuarios(current_user)
      redireccionar
    end
  end

  def puede_editar_estado
    if !RolDataAccess.puede_editar_estado(current_user)
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
