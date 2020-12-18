class ZoneDataAccess

  def self.download datosJson = nil, fecha = nil
    respuesta = Hash.new
    respuesta['datos'] = Hash.new
    respuesta['fecha'] = DateTime.now.utc.strftime('%Y-%m-%d %H:%M:%S.%L')

    query = 'id AS web_id, area_id AS web_area_id, nombre, latitud, longitud, state_id AS estado, updated_at'
    if fecha.nil?
      respuesta['datos'] = Zone.select(query)
    else
      respuesta['datos'] = Zone.where('updated_at > ?', fecha).select(query)
    end

    respuesta
  end

  def self.upload user, json, fecha = nil
    respuesta = Hash.new
    respuesta['datos'] = Hash.new
    zones = ActiveSupport::JSON.decode(json)

    zones.each do |z|
      if (z['web_id'].nil? || z['web_id'] <= 0)
        zone = Zone.new
        accion = Auditoria::ALTA
      else
        zone = Zone.find(z['web_id'])
        accion = Auditoria::MODIFICACION
      end
      if !z['estado'].nil? && z['estado'] == 3
        ZoneDataAccess.borrar_logico zone, user
        accion = Auditoria::BAJA
      else
        zone.state_id = 1
      end
        zone.nombre = z['nombre']
        zone.latitud = z['latitud']
        zone.longitud = z['longitud']
        zone.area_id = z['area_id']
      if (accion == Auditoria::BAJA || zone.save)
        if accion != Auditoria::BAJA
          AuditoriaDataAccess.log user, accion, Auditoria::ZONA, zone
        end
        respuesta['datos'][z['android_id'].to_s] = zone.id
      else
        respuesta['datos'][z['android_id'].to_s] = -1
      end
    end
    respuesta['fecha'] = DateTime.now.utc.strftime('%Y-%m-%d %H:%M:%S.%L')
    respuesta
  end

  def self.borrar_logico zone, user
    if Person.activas.where(zone_id: zone.id).first
        raise ActiveRecord::InvalidForeignKey, 'error'
    end
    zone.state_id = 3
    if user
      AuditoriaDataAccess.log user, Auditoria::BAJA, Auditoria::ZONA, zone
    end
    zone.nombre += '@' + SecureRandom.uuid
    zone.area_id = nil
    zone.save(validate: false)
  end

end