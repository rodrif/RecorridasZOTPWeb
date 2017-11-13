class AreaDataAccess

  def self.download user, datosJson = nil, fecha = nil, version = nil
    respuesta = Hash.new
    respuesta['datos'] = Hash.new
    respuesta['fecha'] = DateTime.now.utc.strftime('%Y-%m-%d %H:%M:%S.%L')
    if fecha.nil?
      respuesta['datos'] = Area.select("id AS web_id, nombre, state_id AS estado, updated_at")
    else
      respuesta['datos'] = Area.where('updated_at > ?', fecha).select("id AS web_id, nombre, state_id AS estado, updated_at")
    end
    if !version.blank?
      user.version = version.to_i
      user.save
      if version.to_i < Area::VERSION
        respuesta['errores'] = Hash.new
        respuesta['errores']['version'] = 'Por favor actualice la versión de la aplicación'
        Enviador.version_android_deprecada(user).deliver_now
      end
    end
    respuesta
  end

  def self.upload user, json, fecha = nil
    respuesta = Hash.new
    respuesta['datos'] = Hash.new
    areas = ActiveSupport::JSON.decode(json)
    areas.each do |a|
      if (a['web_id'].nil? || a['web_id'] <= 0)
        area = Area.new
        accion = Auditoria::ALTA
      else
        area = Area.find(a['web_id']);
        accion = Auditoria::MODIFICACION
      end

      if !a['estado'].nil? && a['estado'] == 3
        AreaDataAccess.borrar_logico area, user
        accion = Auditoria::BAJA
      else
        area.state_id = 1
      end

      area.nombre = a['nombre']

      if (accion == Auditoria::BAJA || area.save)
        if accion != Auditoria::BAJA
          AuditoriaDataAccess.log user, accion, Auditoria::AREA, area
        end
        respuesta['datos'][a['android_id'].to_s] = area.id
      else
        respuesta['datos'][a['android_id'].to_s] = -1
      end
    end

    respuesta['fecha'] = DateTime.now.utc.strftime('%Y-%m-%d %H:%M:%S.%L')
    respuesta
  end

  def self.borrar_logico area, user
    if Zone.activas.where(area_id: area.id).first
      raise ActiveRecord::InvalidForeignKey, 'error'
    end
    area.state_id = 3
    if user
      AuditoriaDataAccess.log user, Auditoria::BAJA, Auditoria::AREA, area
    end
    area.nombre += '@' + SecureRandom.uuid
    area.save(validate: false)
  end

end
