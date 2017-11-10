class PedidoDataAccess

	def self.download datosJson = nil, fecha = nil
		respuesta = Hash.new
		respuesta['datos'] = Hash.new
		respuesta['fecha'] = DateTime.now.utc.strftime('%Y-%m-%d %H:%M:%S.%L')

		query = 'id AS web_id, person_id AS web_person_id, fecha, descripcion, completado, state_id AS estado, updated_at'
    if fecha.nil?
      respuesta['datos'] = Pedido.select(query)
    else
      respuesta['datos'] = Pedido.where('updated_at > ?', fecha).select(query)
    end

		respuesta['datos'].each_with_index do |p, index|
			fecha = p.fecha.to_datetime.strftime('%Q')
			p = p.attributes
			p['fecha'] = fecha
			respuesta['datos'][index] = p
		end

		respuesta
	end

	def self.upload user, json, fecha = nil
		respuesta = Hash.new
		respuesta['datos'] = Hash.new
    pedidos = ActiveSupport::JSON.decode(json)

    pedidos.each do |p|
      if (p['web_id'].nil? || p['web_id'] <= 0)
        pedido = Pedido.new
        accion = Auditoria::ALTA
      else
        pedido = Pedido.find(p['web_id']);
        accion = Auditoria::MODIFICACION
      end
      if !p['estado'].nil? && p['estado'] == 3
        PedidoDataAccess.borrar_logico pedido, user
        accion = Auditoria::BAJA
      else
        pedido.state_id = 1
      end
      pedido.person_id = p['web_person_id']
      pedido.fecha = Time.at(p['fecha'] / 1000)
      pedido.descripcion = p['descripcion'] ? p['descripcion'] : nil
      pedido.completado = p['completado'] ? p['completado'] : nil

      if (pedido.save(validate: false))
        if accion != Auditoria::BAJA
          AuditoriaDataAccess.log user, accion, Auditoria::PEDIDO, pedido
        end
        respuesta['datos'][p['android_id'].to_s] = pedido.id
      else
        respuesta['datos'][p['android_id'].to_s] = -1
      end
    end

    respuesta['fecha'] = DateTime.now.utc.strftime('%Y-%m-%d %H:%M:%S.%L')
    respuesta
  end

  def self.borrar_logico pedido, user
    pedido.state_id = 3
    if user
      AuditoriaDataAccess.log user, Auditoria::BAJA, Auditoria::PEDIDO, pedido
    end
    pedido.person_id = nil
    pedido.save(validate: false)
  end

end
