class UserDataAccess

  # def self.download datosJson = nil, fecha = nil
  #   respuesta = Hash.new
  #   respuesta['datos'] = Hash.new
  #   respuesta['fecha'] = DateTime.now.utc.strftime('%Y-%m-%d %H:%M:%S.%L')

  #   if fecha.nil?
  #     respuesta['datos'] = Area.select("id AS web_id, nombre, state_id AS estado, updated_at")
  #   else
  #     respuesta['datos'] = Area.where('updated_at > ?', fecha).select("id AS web_id, nombre, state_id AS estado, updated_at")
  #   end

  #   respuesta
  # end

  # def self.upload json, fecha = nil
  #   respuesta = Hash.new
  #   respuesta['datos'] = Hash.new
  #   areas = ActiveSupport::JSON.decode(json)

  #   areas.each do |a|
  #     if (a['web_id'].nil? || a['web_id'] <= 0)
  #       area = Area.new
  #     else
  #       area = Area.find(a['web_id']);
  #     end

  #     if !a['estado'].nil? && a['estado'] == 3
  #       area.state_id = 3
  #     else          
  #       area.state_id = 1
  #     end

  #     area.nombre = a['nombre']

  #     if (area.save)
  #       respuesta['datos'][a['android_id'].to_s] = area.id
  #     else
  #       respuesta['datos'][a['android_id'].to_s] = -1
  #     end
  #   end

  #   respuesta['fecha'] = DateTime.now.utc.strftime('%Y-%m-%d %H:%M:%S.%L')
  #   respuesta
  # end

  def self.borrar_logico user, usuario = nil
    user.email += '@' + SecureRandom.uuid
    user.state_id = 3
    user.save(validate: false)
    if usuario
      AuditoriaDataAccess.log usuario, Auditoria::BAJA, Auditoria::USUARIO, user
    end
  end

end