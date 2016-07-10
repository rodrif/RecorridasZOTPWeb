class NotificacionTipo < ActiveRecord::Base

	PROGRAMADA = 1
	URGENTE = 2
	CUMPLEANIOS = 3

	def self.options_for_select
		order('LOWER(nombre)').map { |x| [x.nombre, x.id] }
	end

end
