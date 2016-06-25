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

  def self.enviarNotificaciones
    notificaciones = Notificacion.where("prox_envio < ? AND NOT state_id = ? AND finalizada = ?", Time.now.utc, 3, false)
    delay.enviar notificaciones
    #delay(:run_at => Proc.new { 1.seconds.from_now }).enviarPrueba
    #delay.enviarPrueba
  end

  def self.borrar_logico notificacion, user
    notificacion.state_id = 3
    notificacion.save(validate: false)
    if user
      AuditoriaDataAccess.log user,  Auditoria::BAJA, Auditoria::NOTIFICACION, notificacion
    end
  end

  private

  def self.enviar notificaciones
    Notificacion.transaction do
      notificaciones.each do |notificacion|
        url = URI.parse('https://gcm-http.googleapis.com/gcm/send')
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        request = Net::HTTP::Post.new(url.path, {'Content-Type' =>'application/json', 'Authorization' => 'key=AIzaSyDdrRhWx2vSJF9VQShaBQ1zFo8IkI67Vcc'})
        request.body = "{
          \"to\": \"/topics/facundo\",
          \"data\": {
            \"titulo\": \"#{notificacion.titulo}\",
            \"subtitulo\": \"#{notificacion.subtitulo}\",
            \"descripcion\": \"#{notificacion.descripcion}\",
           }
        }"
        notificacion.calcularProxEnvio
        notificacion.save
        response = http.request(request)
      end
    end
  end

  def self.enviarPrueba
    url = URI.parse('https://gcm-http.googleapis.com/gcm/send')
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new(url.path, {'Content-Type' =>'application/json', 'Authorization' => 'key=AIzaSyDdrRhWx2vSJF9VQShaBQ1zFo8IkI67Vcc'})
    request.body = '{
      "to": "/topics/facundo",
      "data": {
        "message": "Juan cumple años",
        "title": "Cumpleaños!!!",  
       }
    }'

    response = http.request(request)
  end

end