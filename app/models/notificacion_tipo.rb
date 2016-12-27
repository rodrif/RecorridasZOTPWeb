class NotificacionTipo < ActiveRecord::Base

	PROGRAMADA = 1
	URGENTE = 2
	CUMPLEANIOS = 3
    CALENDARIO = 4

	def self.options_for_select
		activas.order('LOWER(nombre)').map { |x| [x.nombre, x.id] }
	end

	scope :activas, -> { where.not(code: 3) }

end
