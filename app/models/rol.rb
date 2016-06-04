class Rol < ActiveRecord::Base
	has_many :notificacion_roles
	has_many :notificaciones, :through => :notificacion_roles

	scope :activos, -> { where.not(id: 4) }
end
