class ApplicationController < ActionController::Base
  before_action :prepare_exception_notifier
  before_action :authenticate_user!
  before_action :es_invitado

  rescue_from ActiveRecord::RecordNotFound, with: :resource_not_found

  rescue_from 'ActiveRecord::InvalidForeignKey' do
    flash[:error] = I18n.t('common.errores.foreign_key')
    redirect_back(fallback_location: root_path)
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

  def puede_crear_institucion
    if !RolDataAccess.puede_crear_institucion(current_user)
      redireccionar
    end
  end

  def puede_editar_institucion
    if !RolDataAccess.puede_editar_institucion(current_user)
      redireccionar
    end
  end

  def puede_borrar_institucion
    if !RolDataAccess.puede_borrar_institucion(current_user)
      redireccionar
    end
  end

  def puede_ver_informes
    if !RolDataAccess.puede_ver_informes(current_user)
      redireccionar
    end
  end

  def is_admin
    if !current_user.rol_id || current_user.rol_id != 1
      redireccionar
    end
  end

  protected

  def resource_not_found
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

  def es_invitado
    if current_user
      if !current_user.rol_id || current_user.rol_id == 5
        sign_out current_user
        redirect_to falta_confirmacion_path
      end
    end
  end

end
