class Notificacion < ActiveRecord::Base
  belongs_to :frecuencia_tipo
  belongs_to :notificacion_tipo
  has_many :roles, :through => :notificacion_role
end
