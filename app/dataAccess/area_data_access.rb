class AreaDataAccess

  def self.download datosJson = nil, fecha = nil
    respuesta = Hash.new
    respuesta['datos'] = Hash.new

    if fecha.nil?
      respuesta['datos'] = Area.select("id AS web_id, nombre, state_id AS estado, updated_at")
    else
      respuesta['datos'] = Area.where('updated_at > ?', fecha).select("id AS web_id, nombre, state_id AS estado, updated_at")
    end

    respuesta
  end

  # def self.guardarVisitasFromJson visitasJson, fecha = nil
  #   respuesta = Hash.new
  #   respuesta['datos'] = Hash.new
  #   visitas = ActiveSupport::JSON.decode(visitasJson)
  #   #TODO

  #     personas.each do |p|
  #       if (p['web_id'].nil? || p['web_id'] <= 0)
  #         person = Person.new
  #       else
  #         person = Person.find(p['web_id']);
  #       end 

  #       if !p['estado'].nil? && p['estado'] == 3
  #         person.state_id = 3
  #       end

  #         person.nombre = p['nombre']
  #         person.apellido = p['apellido']       

  #       if (person.save)
  #         respuesta['datos'][p['android_id'].to_s] = person.id
  #       else
  #         respuesta['datos'][p['android_id'].to_s] = -1
  #       end
  #     end

  #     respuesta
  # end


end