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

  def self.programar
    delay(:run_at => Proc.new { 1.seconds.from_now }).enviar
    #delay.enviar
  end

  def self.borrar_logico notificacion, user
    notificacion.state_id = 3
    notificacion.save(validate: false)
    if user
      AuditoriaDataAccess.log user,  Auditoria::BAJA, Auditoria::NOTIFICACION, notificacion
    end
  end

  private

  def self.enviar
    url = URI.parse('https://gcm-http.googleapis.com/gcm/send')
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new(url.path, {'Content-Type' =>'application/json', 'Authorization' => 'key=AIzaSyDdrRhWx2vSJF9VQShaBQ1zFo8IkI67Vcc'})
    request.body = '{
      "to": "/topics/global",
      "data": {
        "message": "Juan cumple años",
        "title": "Cumpleaños!!!",  
       }
    }'

    response = http.request(request)
  end

end