require 'google/apis/content_v2'
require 'googleauth' # https://github.com/googleapis/google-auth-library-ruby

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
    self.enviar notificaciones
    #delay.enviar notificaciones
    #delay(:run_at => Proc.new { 1.seconds.from_now }).enviarPrueba
    #delay.enviarPrueba
  end

  def self.getToken
    content = Google::Apis::ContentV2::ShoppingContentService.new
    scope = 'https://www.googleapis.com/auth/firebase.messaging'
    content.authorization = Google::Auth::ServiceAccountCredentials.make_creds(
      json_key_io: File.open('./config/service-account-file.json'),
      scope: scope
    )
    token = content.authorization.fetch_access_token!
    token["access_token"]
  end

  def self.borrar_logico notificacion, user
    notificacion.state_id = 3
    notificacion.save(validate: false)
    if user
      AuditoriaDataAccess.log user,  Auditoria::BAJA, Auditoria::NOTIFICACION, notificacion
    end
  end

  private

  def self.enviarRequestCumpleanios personas, descripcion
    url = self.createUrl
    http = self.createHttp(url)
    personas.each do |p|
      notificacion = Notificacion.new
      notificacion.titulo = 'Cumpleaños'
      notificacion.subtitulo = "#{p.full_name}"
      notificacion.descripcion = "#{descripcion}"
      notificacion.notificacion_tipo = NotificacionTipo.new
      notificacion.notificacion_tipo.code = NotificacionTipo::CUMPLEANIOS
      response = http.request(self.createRequest(url, notificacion, 'all', p.zone.area_id, p.id, 'cumpleanios'))
    end
  end

  def self.createUrl
    return URI.parse('https://fcm.googleapis.com/v1/projects/recorridasflutter/messages:send')
  end

  def self.createHttp url
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    return http
  end

  def self.createRequest url, notificacion, topic, areaId, personaId = nil, handler = nil
    request = Net::HTTP::Post.new(url.path, {'Content-Type' =>'application/json', 'Authorization' => 'Bearer ' + self.getToken()})
    request.body = "{
      'message': {
        'topic': 'all',
        'notification': {
          'title': \"#{notificacion.titulo}\",
          'body': \"#{notificacion.subtitulo}\"
        },
        'data': {
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'descripcion': \"#{notificacion.descripcion}\",
          'tipo': \"#{notificacion.notificacion_tipo.code}\",
          'persona_id': \"#{personaId ? personaId : ''}\",
          'handler': \"#{handler}\",
          'sede_id': \"#{areaId ? areaId.to_s : ''}\"
        }
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
          notificacion.areas.each do |a|
            response = http.request(self.createRequest(url, notificacion, r.nombre, a.id))
          end
        end
      end
    end
  end

end
