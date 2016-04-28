class ApplicationController < ActionController::Base
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
      redirect_to acceso_denegado_path, alert: 'Acceso denegado, faltan permisos'
    end
  end

  def puede_editar_persona
    if !current_user.rol || !current_user.rol.puede_editar_persona
      redirect_to acceso_denegado_path, alert: 'Acceso denegado, faltan permisos'
    end
  end

  def puede_borrar_persona
    if !current_user.rol || !current_user.rol.puede_borrar_persona
      redirect_to acceso_denegado_path, alert: 'Acceso denegado, faltan permisos'
    end
  end

  def puede_ver_telefono_persona
    if !current_user.rol || !current_user.rol.puede_ver_telefono_persona
      redirect_to acceso_denegado_path, alert: 'Acceso denegado, faltan permisos'
    end
  end

  def puede_crear_visita
    if !current_user.rol || !current_user.rol.puede_crear_visita
      redirect_to acceso_denegado_path, alert: 'Acceso denegado, faltan permisos'
    end
  end

  def puede_editar_visita
    if !current_user.rol || !current_user.rol.puede_editar_visita
      redirect_to acceso_denegado_path, alert: 'Acceso denegado, faltan permisos'
    end
  end

  def puede_borrar_visita
    if !current_user.rol || !current_user.rol.puede_borrar_visita
      redirect_to acceso_denegado_path, alert: 'Acceso denegado, faltan permisos'
    end
  end

  def puede_ver_web
    if !current_user.rol || !current_user.rol.puede_ver_web
      redirect_to acceso_denegado_path, alert: 'Acceso denegado, faltan permisos'
    end
  end

end
