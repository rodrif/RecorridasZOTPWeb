class NotificacionDataAccess

  # def self.download datosJson = nil, fecha = nil
  #   respuesta = Hash.new
  #   respuesta['datos'] = Hash.new
  #   respuesta['fecha'] = DateTime.now.utc.strftime('%Y-%m-%d %H:%M:%S.%L')

  #   query = 'id AS web_id, area_id AS web_area_id, nombre, apellido, telefono, dia, state_id AS estado, updated_at'
  #   if fecha.nil?
  #     respuesta['datos'] = Notificacion.select(query)
  #   else
  #     respuesta['datos'] = Notificacion.where('updated_at > ?', fecha).select(query)
  #   end

  #   respuesta
  # end

  def self.borrar_logico notificacion, user
    notificacion.state_id = 3
    notificacion.save(validate: false)
    if user
      AuditoriaDataAccess.log user,  Auditoria::BAJA, Auditoria::NOTIFICACION, notificacion
    end
  end

end