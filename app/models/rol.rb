class Rol < ActiveRecord::Base

	ADMINISTRADOR = 1
	REFERENTE = 2
	COORDINADOR = 3
	VOLUNTARIO = 4
	INVITADO = 5

	has_many :notificacion_roles
	has_many :notificaciones, :through => :notificacion_roles

	scope :activos, -> { where.not(id: 5) }
end
