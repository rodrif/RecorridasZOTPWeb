class Rol < ActiveRecord::Base
	has_many :notificaciones, :through => :notificacion_role
end
