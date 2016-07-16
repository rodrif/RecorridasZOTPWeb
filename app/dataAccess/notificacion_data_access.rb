class NotificacionDataAccess
  require 'net/http'

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

  def self.proxCumpleanios
    personas = Person.getCumpleanios(3).to_a
    self.enviarRequestCumpleanios personas, "cumple años en 3 días!!"
  end

  def self.enviarCumpleanios
    personas = Person.getCumpleanios.to_a
    self.enviarRequestCumpleanios personas, "cumple años hoy!!"
  end

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

  def self.enviarRequestCumpleanios personas, subtituloExtra
    url = self.createUrl
    http = self.createHttp(url)
    personas.each do |p|
      notificacion = Notificacion.new
      notificacion.titulo = 'Cumpleaños'
      notificacion.subtitulo = "#{p.full_name} #{subtituloExtra}"
      notificacion.notificacion_tipo = NotificacionTipo.new
      notificacion.notificacion_tipo.code = NotificacionTipo::CUMPLEANIOS
      Rol.activos.each do |r|
        response = http.request(self.createRequest(url, notificacion, r.nombre, p.id))
      end
    end
  end

  def self.createUrl
    return URI.parse('https://gcm-http.googleapis.com/gcm/send')
  end

  def self.createHttp url
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    return http
  end

  def self.createRequest url, notificacion, topic, personaId = nil
    request = Net::HTTP::Post.new(url.path, {'Content-Type' =>'application/json', 'Authorization' => 'key=AIzaSyDdrRhWx2vSJF9VQShaBQ1zFo8IkI67Vcc'})
    request.body = "{
      \"to\": \"/topics/#{topic}\",
      \"data\": {
        \"titulo\": \"#{notificacion.titulo}\",
        \"subtitulo\": \"#{notificacion.subtitulo}\",
        \"descripcion\": \"#{notificacion.descripcion}\",
        \"tipo\": \"#{notificacion.notificacion_tipo.code}\",
        \"persona_id\": #{personaId ? personaId : -1}
       }
    }"
    return request
  end

  def self.enviar notificaciones
    url = self.createUrl
    Notificacion.transaction do
      http = self.createHttp(url)
      notificaciones.each do |notificacion|
        notificacion.calcularProxEnvio
        notificacion.save
        notificacion.roles.each do |r|
          response = http.request(self.createRequest(url, notificacion, r.nombre))
        end
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