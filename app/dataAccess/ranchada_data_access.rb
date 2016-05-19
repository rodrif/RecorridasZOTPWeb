class RanchadaDataAccess

  def self.download datosJson = nil, fecha = nil
    respuesta = Hash.new
    respuesta['datos'] = Hash.new
    respuesta['fecha'] = DateTime.now.utc.strftime('%Y-%m-%d %H:%M:%S.%L')

    query = 'id AS web_id, zone_id AS web_zone_id, nombre, descripcion, latitud, longitud, state_id AS estado, updated_at'
    if fecha.nil?
      respuesta['datos'] = Ranchada.select(query)
    else
      respuesta['datos'] = Ranchada.where('updated_at > ?', fecha).select(query)
    end

    respuesta
  end

  # def self.upload json, fecha = nil
  #   respuesta = Hash.new
  #   respuesta['datos'] = Hash.new
  #   zones = ActiveSupport::JSON.decode(json)

  #   zones.each do |z|
  #     if (z['web_id'].nil? || z['web_id'] <= 0)
  #       zone = Zone.new
  #     else
  #       zone = Zone.find(z['web_id']);
  #     end

  #     if !z['estado'].nil? && z['estado'] == 3
  #       ZoneDataAccess.borrar_logico zone
  #     else          
  #       zone.state_id = 1
  #     end

  #       zone.nombre = z['nombre']
  #       zone.latitud = z['latitud']
  #       zone.longitud = z['longitud']
  #       zone.area_id = z['area_id']

  #     if (zone.save)
  #       respuesta['datos'][z['android_id'].to_s] = zone.id
  #     else
  #       respuesta['datos'][z['android_id'].to_s] = -1
  #     end
  #   end

  #   respuesta['fecha'] = DateTime.now.utc.strftime('%Y-%m-%d %H:%M:%S.%L')
  #   respuesta
  # end

  def self.borrar_logico ranchada, user = nil
    if Person.activas.where(ranchada_id: ranchada.id).first ||
      Familia.activas.where(ranchada_id: ranchada.id).first
        raise ActiveRecord::InvalidForeignKey, 'error'
    end
    ranchada.state_id = 3
    ranchada.nombre += '@' + SecureRandom.uuid
    ranchada.zone_id = nil
    ranchada.save(validate: false)
    if user
      AuditoriaDataAccess.log user, Auditoria::BAJA, Auditoria::RANCHADA, ranchada
    end
  end

end