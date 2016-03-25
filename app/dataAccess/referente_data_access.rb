class ReferenteDataAccess

def self.download datosJson = nil, fecha = nil
    respuesta = Hash.new
    respuesta['datos'] = Hash.new
    respuesta['fecha'] = DateTime.now.utc.strftime('%Y-%m-%d %H:%M:%S.%L')

    query = 'id AS web_id, area_id AS web_area_id, nombre, apellido, telefono, dia, state_id AS estado, updated_at'
    if fecha.nil?
      respuesta['datos'] = Referente.select(query)
    else
      respuesta['datos'] = Referente.where('updated_at > ?', fecha).select(query)
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

  def self.borrar_logico referente
    referente.state_id = 3
    referente.save(validate: false)
  end


end