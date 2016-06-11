class NotificacionTipo < ActiveRecord::Base

	def self.options_for_select
		order('LOWER(nombre)').map { |x| [x.nombre, x.id] }
	end

end
