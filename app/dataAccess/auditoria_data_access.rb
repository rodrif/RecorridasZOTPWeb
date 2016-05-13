class AuditoriaDataAccess

	def self.log accion, entidad, id
		auditoria = Auditoria.new
		if current_user
			auditoria.email = current_user.email
    end
		auditoria.fecha = Time.now
		auditoria.accion = accion
		auditoria.entidad = entidad
		auditoria.id = id
		auditoria.save
	end

end