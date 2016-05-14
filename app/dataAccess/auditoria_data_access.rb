class AuditoriaDataAccess

	def self.log user, accion, entidad, entityId
		auditoria = Auditoria.new
		if user
			auditoria.email = user.email
    end
		auditoria.fecha = Time.now
		auditoria.accion = accion
		auditoria.entidad = entidad
		auditoria.entity_id = entityId
		auditoria.save
	end

end
